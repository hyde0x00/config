local mp = require 'mp'

local function get_os()
    local handle = io.popen("uname", "r")
    local result = handle:read()
    handle:close()
    return result:gsub("%s+", "")
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

local function open_file_manager()
    local path = mp.get_property_osd("path")
    if not is_file(path) then
        return false
    end
    local msg = "Opening file manager..."
    mp.osd_message(msg)
    local os_type = get_os()
    if os_type == "Darwin" then
        cmd = "open -R"
    else
        cmd = "nautilus"
    end
    os.execute(cmd .. " " .. shell_quote(path) .. " &>/dev/null &")
end

local os_type = get_os()

if os_type == "Darwin" then
    mp.add_forced_key_binding("Meta+o", "open_file_manager", open_file_manager)
else
    mp.add_forced_key_binding("Ctrl+o", "open_file_manager", open_file_manager)
end
