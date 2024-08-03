-- -----------------------------------------------------------------------------
-- ------------------------------ MUSIC-STATS ----------------------------------
-- -----------------------------------------------------------------------------

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

  if not result or result:match("No players found") then
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

local function get_music_metadata(field)
  local ignored_players_str = get_ignored_players_string()
  local cmd = string.format(
    "playerctl --ignore-player %s metadata --format '{{ %s }}' 2>/dev/null",
    ignored_players_str,
    field
  )

  local result = vim.call("system", cmd)

  if not result or result:match("No players found") then
    return "" -- Return empty string for no music or missing metadata
  end

  local metadata = result:match("^(.-)%s*$") -- Trim any whitespace
  return metadata or "" -- Return empty string if no metadata
end

local function get_player_property(property)
  local ignored_players_str = get_ignored_players_string()
  local cmd = string.format(
    "playerctl --ignore-player %s %s 2>/dev/null",
    ignored_players_str,
    property
  )

  local result = vim.call("system", cmd)

  if not result then
    return nil -- Return nil for no property value
  end

  return result:match("^(.-)%s*$") -- Trim any whitespace
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

function M.get_title()
  return get_music_metadata("title")
end

function M.get_artist()
  return get_music_metadata("artist")
end

function M.get_album()
  return get_music_metadata("album")
end

function M.is_shuffle()
  return get_player_property("shuffle") == "on"
end

function M.is_loop()
  return get_player_property("loop") == "true"
end

return M
