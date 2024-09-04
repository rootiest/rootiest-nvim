---@module "utils.wakatime_stats"
--- This module provides functions to retrieve wakatime statistics from the cache file.
--          ╭─────────────────────────────────────────────────────────╮
--          │                     WakaTime Stats                      │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

require("utils.cache_stats")
local cache_file = vim.fs.joinpath(_G.cache_stats_dir, "wakatime_cache.txt")

-- Local variable to store the last known value
local last_known_value = ""

--- Function to read the cache file
---@return string content The content of the cache file
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

--- Function to get the wakatime today cache
---@return string status The wakatime today cache
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

--- Function to get the wakatime today status
---@return string status The wakatime today status
function M.get_today()
  local text = get_wakatime_today()
  -- Check if it starts with "0 hrs " and remove it
  text = text:gsub("^0 hrs%s*", "")
  return text
end

--- Function to get the wakatime today icon
---@return string icon The wakatime today icon
function M.get_icon()
  local text = M.get_today()
  if text ~= "" then
    return "󱦺  " -- Default icon
  else
    return "" -- No icon
  end
end

--- Function to get the wakatime today icon and text
---@return string icon_and_text The wakatime today icon and text
function M.get_icon_with_text()
  local icon = M.get_icon()
  local text = M.get_today()
  if icon ~= "" or text ~= "" then
    return icon .. text -- Combine icon and text
  else
    return "" -- No text or icon
  end
end

--- Function to get the total minutes
---@return number total_minutes The total minutes
function M.get_total_minutes()
  local wakatime_string = M.get_today()
  if wakatime_string == "" then
    return 0 -- Return 0 if there's no data
  end
  -- Extract hours and minutes from the wakatime string
  local hours, mins = wakatime_string:match("(%d+)%s*hrs?%s*(%d+)%s*mins?")
  if not hours then
    mins = wakatime_string:match("(%d+)%s*mins?")
    hours = 0
  end
  -- Convert hours and minutes to total minutes
  hours = tonumber(hours) or 0
  mins = tonumber(mins) or 0
  return (hours * 60) + mins
end

--- Function to get the color based on the total minutes
---@return table color The color based on the total minutes
function M.get_color()
  local total_minutes = M.get_total_minutes()
  local utils = require("data").func
  if total_minutes >= 60 then
    return { fg = utils.get_fg_color("GitSignsAdd") }
  elseif total_minutes >= 30 then
    return { fg = utils.get_fg_color("GitSignsChange") }
  else
    return { fg = utils.get_fg_color("GitSignsDelete") }
  end
end

return M
