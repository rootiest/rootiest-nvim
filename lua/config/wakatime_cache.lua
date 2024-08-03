-- -----------------------------------------------------------------------------
-- ----------------------------- WAKATIME-CACHE --------------------------------
-- -----------------------------------------------------------------------------

local M = {}
local cache = {
  value = nil,
  timestamp = 0,
}
local cache_duration = 60 -- Cache duration in seconds

local function get_wakatime_today()
  local result = vim.call("system", "~/.wakatime/wakatime-cli --today 2>&1")
  if not result or result == "" then
    return "Error: Unable to read wakatime-cli output"
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
  local current_time = os.time()
  if current_time - cache.timestamp > cache_duration then
    cache.value = get_wakatime_today()
    cache.timestamp = current_time
  end
  return cache.value
end

function M.get_icon()
  local text = M.get_today()
  if text and text:match("Error:") then
    return "󰥕 " -- Icon for error or issue
  else
    return "󱦺 " -- Default icon
  end
end

return M
