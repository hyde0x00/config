local mp = require 'mp'

local function get_os()
    local handle = io.popen("uname", "r")
    local result = handle:read()
    handle:close()
    return result:gsub("%s+", "")
end

local function is_executable(cmd)
    local handle = io.popen("type " .. cmd .. " &>/dev/null; echo $?", "r")
    local success = handle:read() == "0"
    handle:close()
    return success
end

local function get_clipboard_command()
    if is_executable("pbcopy") then
        return "pbcopy"
    elseif is_executable("xsel") then
        return "xsel --input --clipboard"
    end
    local msg = "No supported clipboard command found"
    mp.osd_message(msg)
    mp.msg.error(msg)
    return false
end

local function copy_to_clipboard(str)
    local cmd = get_clipboard_command()
    if not (cmd) then
        return false
    end
    local handle = io.popen(cmd, "w")
    handle:write(str)
    handle:close()
    local msg = "Copied to clipboard: " .. str
    mp.osd_message(msg)
    mp.msg.warn(msg)
    return true
end

function shell_quote(str)
    local escaped = str:gsub("'", "'\\''")
    return "'" .. escaped .. "'"
end

local function realpath(path)
    local handle = io.popen("realpath -- " .. shell_quote(path) .. " 2>/dev/null", "r")
    local result = handle:read()
    handle:close()
    return result
end

local function is_url(path)
    return string.match(path, "^https?://*")
end

local function copy_path_to_clipboard(esc)
    local path = mp.get_property("path")
    if is_url(path) then
        copy_to_clipboard(path)
    else
        if esc then
            copy_to_clipboard(shell_quote(realpath(path)))
        else
            copy_to_clipboard(realpath(path))
        end
    end
end

local function copy_path()
    copy_path_to_clipboard(false)
end 

local function copy_quoted_path()
    copy_path_to_clipboard(true)
end

local os_type = get_os()

if os_type == "Darwin" then
    mp.add_forced_key_binding("Meta+c", "copy_path", copy_path)
    mp.add_forced_key_binding("Meta+C", "copy_quoted_path", copy_quoted_path)
else
    mp.add_forced_key_binding("Ctrl+c", "copy_path", copy_path)
    mp.add_forced_key_binding("Ctrl+C", "copy_quoted_path", copy_quoted_path)
end
