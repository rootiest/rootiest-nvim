--          ╭─────────────────────────────────────────────────────────╮
--          │                     WakaTime Stats                      │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

require("utils.cache_stats")
local cache_file = os.getenv("HOME") .. "/.cache/wakatime_cache.txt"

local last_known_value = ""

local function read_cache()
  local file = io.open(cache_file, "r")
  if file then
    local content = file:read("*a")
    file:close()
    last_known_value = content
    return content
  end
  return last_known_value
end

local function get_wakatime_today()
  local result = read_cache()
  if not result or result:match("^%s*$") then
    return last_known_value
  end

  if
    result:match("command not found")
    or result:match("No such file or directory")
  then
    return last_known_value
  end

  return result:match("^%s*(.-)%s*$") -- Trim any whitespace
end

function M.get_today()
  return get_wakatime_today()
end

function M.get_icon()
  local text = M.get_today()
  if text ~= "" then
    return "󱦺  " -- Default icon
  else
    return "" -- No icon
  end
end

function M.get_icon_with_text()
  local icon = M.get_icon()
  local text = M.get_today()
  if icon ~= "" or text ~= "" then
    return icon .. text -- Combine icon and text
  else
    return "" -- No text or icon
  end
end

function M.get_total_minutes()
  local wakatime_string = M.get_today()
  if wakatime_string == "" then
    return 0 -- Return 0 if there's no data
  end

  local hours, mins = wakatime_string:match("(%d+)%s*hrs?%s*(%d+)%s*mins?")
  if not hours then
    mins = wakatime_string:match("(%d+)%s*mins?")
    hours = 0
  end

  hours = tonumber(hours) or 0
  mins = tonumber(mins) or 0

  return (hours * 60) + mins
end

function M.get_color()
  local total_minutes = M.get_total_minutes()
  local rootilities = require("utils.rootiest") -- Adjust according to your actual setup

  if total_minutes >= 60 then
    return { fg = rootilities.get_fg_color("GitSignsAdd") }
  elseif total_minutes >= 30 then
    return { fg = rootilities.get_fg_color("GitSignsChange") }
  else
    return { fg = rootilities.get_fg_color("GitSignsDelete") }
  end
end

return M
