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

local function get_trash_command()
    if is_executable("trash") then
        return "trash"
    elseif is_executable("gio") then
        return "gio trash"
    end
    local msg = "No supported trash command found"
    mp.osd_message(msg)
    mp.msg.error(msg)
    return false
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

local function is_file(path)
    local file = io.open(path, "r")
    if file then
        io.close(file) 
        return true
    end
    local msg = "Not a file: " .. path
    mp.osd_message(msg)
    mp.msg.error(msg)
    return false
end

local function update_playlist()
    local curr = mp.get_property_number("playlist-pos", 0)
    local last = mp.get_property_number("playlist-count", 0) - 1
    if curr < last then
        mp.command("playlist-remove current")
    else
        mp.command("playlist-prev")
        mp.command("playlist-remove " .. last)
    end
end

local function move_to_trash(path)
    local cmd = get_trash_command()
    if not (cmd) then
        return false
    end
    local handle = io.popen(cmd .. " " .. shell_quote(realpath(path)) .. " 2>&1", "r")
    local err = handle:read()
    handle:close()
    if err then
        local msg = "Failed to move to trash: " .. path
        mp.osd_message(msg)
        mp.msg.error(err) 
        return false
    end
    local msg = "Moved to trash: " .. path
    mp.osd_message(msg)
    mp.msg.warn(msg) 
    return true
end

local function trash()
    local path = mp.get_property_osd("path")
    if is_file(path) and move_to_trash(path) then
        update_playlist()
    end
end

local os_type = get_os()

if os_type == "Darwin" then
  mp.add_forced_key_binding("Meta+BS", "trash", trash)
else
  mp.add_forced_key_binding("Ctrl+Del", "trash", trash)
end
