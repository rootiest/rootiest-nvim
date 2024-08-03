-- -----------------------------------------------------------------------------
-- ------------------------------ MUSIC-CURREN ---------------------------------
-- -----------------------------------------------------------------------------T

local M = {}
local cache = {
  text = "", -- Default to empty string to handle initial state
  timestamp = 0,
}
local cache_duration = 1 -- Cache duration in seconds

-- List of players to ignore
local ignored_players = {
  "firefox",
  "kdeconnect",
  "plasma-browser-integration",
}

local function get_ignored_players_string()
  return table.concat(ignored_players, ",")
end

local function get_music_current()
  local ignored_players_str = get_ignored_players_string()
  local cmd = string.format(
    "playerctl --ignore-player %s metadata --format '{{ artist }} - {{ title }}' 2>/dev/null",
    ignored_players_str
  )

  local result = vim.call("system", cmd)

  if not result then
    return "" -- Return empty string for no music
  end

  -- Check for "No players found" message
  if result:match("No players found") then
    return "" -- Return empty string for no music
  end

  local artist_title = result:match("^(.-)%s*$") -- Trim any whitespace
  return artist_title or "" -- Return empty string if no artist/title
end

local function get_music_icon()
  local ignored_players_str = get_ignored_players_string()
  local cmd = string.format(
    "playerctl --ignore-player %s status 2>/dev/null",
    ignored_players_str
  )

  local result = vim.call("system", cmd)

  if not result then
    return "󰓃 " -- Default icon for music stopped
  end

  -- Determine the icon based on the player status
  if result:match("Playing") then
    return "󰝚 " -- Icon for music playing
  elseif result:match("Paused") then
    return "󰝛 " -- Icon for music paused
  else
    return "󰓃 " -- Default icon for music stopped
  end
end

function M.get_current()
  local current_time = os.time()
  if current_time - cache.timestamp > cache_duration then
    cache.text = get_music_current()
    cache.timestamp = current_time
  end
  return cache.text
end

function M.get_icon()
  return get_music_icon()
end

return M
