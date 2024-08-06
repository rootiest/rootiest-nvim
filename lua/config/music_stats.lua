-- -----------------------------------------------------------------------------
-- ------------------------------- MUSIC-STATS ---------------------------------
-- -----------------------------------------------------------------------------

local M = {}
local cache_file = os.getenv("HOME") .. "/.cache/music_cache.txt"
local separator = "␟"

-- Function to read the cache file
local function read_cache()
  local file = io.open(cache_file, "r")
  if file then
    local content = file:read("*a")
    file:close()
    return content
  end
  return ""
end

-- Parse the cached music data
local function parse_cache()
  local content = read_cache()
  if not content or content:match("No players found") then
    return "", "", "", "", "", "", ""
  end
  local pattern = "^(.-)%s*"
    .. separator
    .. "%s*(.-)%s*"
    .. separator
    .. "%s*(.-)%s*"
    .. separator
    .. "%s*(.-)%s*"
    .. separator
    .. "%s*(.-)%s*"
    .. separator
    .. "%s*(.-)%s*"
    .. separator
    .. "%s*(.-)%s*$"
  local artist, title, album, status, volume, loop, shuffle =
    content:match(pattern)
  return artist or "",
    title or "",
    album or "",
    status or "",
    volume or "",
    loop or "",
    shuffle or ""
end

function M.get_status()
  local _, _, _, status = parse_cache()
  if status:match("Playing") then
    return "playing"
  elseif status:match("Paused") then
    return "paused"
  else
    return "stopped"
  end
end

function M.get_current()
  return parse_cache() -- Just return title for simplicity
end

function M.get_icon()
  local _, _, _, status = parse_cache()
  if status == "Playing" then
    return "󰝚 "
  elseif status == "Paused" then
    return "󰝛 "
  else
    return "󰓃 "
  end
end

function M.get_title()
  local _, title = parse_cache()
  return title
end

function M.get_artist()
  local artist = parse_cache()
  return artist
end

function M.get_album()
  local _, _, album = parse_cache()
  return album
end

function M.get_volume()
  local _, _, _, _, volume = parse_cache()
  return tonumber(volume) or 0.0
end

function M.is_shuffle()
  local _, _, _, _, _, _, shuffle = parse_cache()
  return shuffle == "On"
end

function M.is_loop()
  local _, _, _, _, _, loop = parse_cache()
  return loop ~= "None" and loop ~= "false"
end

local function shorten_text(text)
  if #text <= 25 then
    return text
  end

  local delimiters = { ",", "-", ":" }
  for _, delimiter in ipairs(delimiters) do
    local parts = vim.split(text, delimiter)
    if #parts > 1 then
      local first_part = parts[1]
      local second_part = table.concat(vim.list_slice(parts, 2), delimiter)
      if #first_part > #second_part then
        return second_part
      else
        return first_part
      end
    end
  end

  return text
end

local function format_icon_with_text(icon, artist, title)
  if artist and #artist > 25 then
    return icon .. " " .. title
  elseif title and #title > 25 then
    return icon .. " " .. title
  elseif title and artist and #title <= 25 then
    return icon .. " " .. artist .. " - " .. title
  else
    return icon .. " " .. (title or artist or "No music")
  end
end

function M.get_icon_with_text()
  local icon = M.get_icon()
  local title = M.get_title()
  local artist = M.get_artist()
  local status = M.get_status() -- Assuming there's a function to get the music status

  if status ~= "playing" and status ~= "paused" then
    return "" -- Return empty string if the status is neither "Playing" nor "Paused"
  end

  title = shorten_text(title)
  artist = shorten_text(artist)

  return format_icon_with_text(icon, artist, title)
end

return M
