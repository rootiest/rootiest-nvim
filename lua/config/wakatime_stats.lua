-- -----------------------------------------------------------------------------
-- ----------------------------- WAKATIME-STATS --------------------------------
-- -----------------------------------------------------------------------------

local M = {}
local cache_file = os.getenv("HOME") .. "/.cache/wakatime_cache.txt"

local function read_cache()
  local file = io.open(cache_file, "r")
  if file then
    local content = file:read("*a")
    file:close()
    return content
  end
  return "Error: Cache file not found"
end

local function get_wakatime_today()
  local result = read_cache()
  if not result or result == "" then
    return ""
  end

  -- Handle common error messages
  if
    result:match("command not found")
    or result:match("No such file or directory")
  then
    return "Error: wakatime-cli not found"
  end

  return result:match("^%s*(.-)%s*$") -- Trim any whitespace
end

function M.get_today()
  return get_wakatime_today()
end

function M.get_icon()
  local text = M.get_today()
  if text and text:match("Error:") then
    return "󰥕 " -- Icon for error or issue
  else
    return "󱦺 " -- Default icon
  end
end

function M.get_icon_with_text()
  return M.get_icon() .. " " .. (M.get_today() or "Loading...")
end

function M.get_total_minutes()
  local wakatime_string = M.get_today()
  if not wakatime_string or wakatime_string:match("Error:") then
    return 0 -- Return 0 if there's an error in the wakatime string
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

return M
