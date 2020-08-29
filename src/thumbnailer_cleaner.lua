-- File by automatata

-- Remove thumbnail directories added by this mpv instance. Parallel instances' thumbnails are
-- preserved, unless the file was also opened by this instance.

ON_WINDOWS = (package.config:sub(1,1) ~= '/')

local directories_count = 0
local directory_set = {} -- Guard duplicates
local remove_directory_cmd = ON_WINDOWS -- To append dirs
    and { "run", "cmd", "/c", "rd", "/s/q" }
    or  { "run", "rm", "-rf" }

local function record_directory(dir)
    if dir ~= nil and dir ~= "" and not directory_set[dir] then
        directories_count = directories_count + 1
        directory_set[dir] = true
        table.insert(remove_directory_cmd, dir)
    end
end

local function remove_directories()
    if directories_count > 0 then
        mp.command_native(remove_directory_cmd)
    end
end

mp.register_script_message("mpv_thumbnail_script-directory", record_directory)

mp.register_event("shutdown", remove_directories)
