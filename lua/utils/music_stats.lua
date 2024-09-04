--          ╭─────────────────────────────────────────────────────────╮
--          │                       Music Stats                       │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

require("utils.cache_stats")
local cache_file = vim.fs.joinpath(_G.cache_stats_dir, "music_cache.txt")

local separator = "␟"
local last_known_value = ""

--- Function to read the cache file
---@return string content The content of the cache file
local function read_cache()
  local file = io.open(cache_file, "r")
  if file then
    local content = file:read("*a")
    file:close()
    last_known_value = content -- Update the last known value
    return content
  end
  return last_known_value -- Return last known value if file cannot be read
end

--- Function to parse the cache file
---@return string artist The artist
---@return string title The title
---@return string album The album
---@return string status The play status
---@return string volume The volume level
---@return string loop The loop state
---@return string shuffle The shuffle state
local function parse_cache()
  local content = read_cache()
  if
    not content
    or content:match("No players found")
    or content:match("^%s*$")
  then
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

--- Function to get the play status
---@return string status The play status
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

--- --- Function to get the current stats
---@return string artist The artist
---@return string title The title
---@return string album The album
---@return string status The play status
---@return string volume The volume level
---@return string loop The loop state
---@return string shuffle The shuffle state
function M.get_current()
  return parse_cache()
end

--- Function to get the music icon
---@return string icon The music icon
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

--- Function to get the music title
---@return string title The music title
function M.get_title()
  local _, title = parse_cache()
  return title
end

--- Function to get the music artist
---@return string artist The music artist
function M.get_artist()
  local artist = parse_cache()
  return artist
end

--- Function to get the music album
---@return string album The music album
function M.get_album()
  local _, _, album = parse_cache()
  return album
end

--- Function to get the music volume
---@return number volume The music volume
function M.get_volume()
  local _, _, _, _, volume = parse_cache()
  return tonumber(volume) or 0.0
end

--- Function to get the music shuffle state
---@return boolean shuffle The music shuffle state
function M.is_shuffle()
  local _, _, _, _, _, _, shuffle = parse_cache()
  return shuffle == "On"
end

--- Function to get the music loop state
---@return boolean loop The music loop state
function M.is_loop()
  local _, _, _, _, _, loop = parse_cache()
  return loop ~= "None" and loop ~= "false"
end

--- Function to remove parentheses and their contents
---@param text string The text to remove parentheses from
---@return string text The text with parentheses removed
---@return integer count The number of parentheses removed
local function remove_parentheses(text)
  return text:gsub("%b()", "")
end

--- Function to abbreviate common words or phrases
---@param text string The text to abbreviate
---@return string text The abbreviated text
local function abbreviate(text)
  local replacements = {
    ["feat%.?%s"] = "ft. ",
    ["and%s"] = "& ",
    ["versus%s"] = "vs ",
    ["Original Mix%s"] = "Orig. Mix ",
  }
  for long, short in pairs(replacements) do
    text = text:gsub("%f[%a]" .. long, short) -- Match only at word boundaries
  end
  return text
end

--- Function to strip unnecessary words or phrases
---@param text string The text to strip
---@return string text The stripped text
---@return integer count The number of instances removed
local function strip_redundant(text)
  local redundant_phrases =
    { "Radio Edit", "Extended Version", "Remix", "Instrumental", "Live" }
  for _, phrase in ipairs(redundant_phrases) do
    text = text:gsub(phrase, "")
  end
  return text:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1") -- Clean up any extra spaces
end

--- Function to limit the number of words in the text
---@param text string The text to limit
---@param max_words integer The maximum number of words
---@return string text The limited text
local function limit_words(text, max_words)
  local words = vim.split(text, "%s+")
  if #words > max_words then
    return table.concat(vim.list_slice(words, 1, max_words), " ") .. "..."
  end
  return text
end

--- Function to remove duplicate words
---@param text string The text to remove duplicates from
---@return string text The text with duplicates removed
local function remove_duplicates(text)
  local seen = {}
  local result = {}
  for word in text:gmatch("%S+") do
    if not seen[word:lower()] then
      table.insert(result, word)
      seen[word:lower()] = true
    end
  end
  return table.concat(result, " ")
end

--- Function to shorten the text
---@param text string The text to shorten
---@return string text The shortened text
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

--- Function to simplify text
---@param text string The text to simplify
---@return string text The simplified text
local function simplify_text(text)
  text = remove_parentheses(text)
  text = strip_redundant(text)
  text = abbreviate(text)
  text = shorten_text(text) -- Apply shortening based on delimiters
  text = limit_words(text, 7) -- Adjust max words as needed
  text = remove_duplicates(text)
  return text
end

--- Function to format the icon with text
---@param icon string The icon
---@param artist string The artist
---@param title string The title
---@return string formatted_icon_with_text The formatted icon and text
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

--- Function to get the icon with text
---@return string icon_with_text The icon and text
function M.get_icon_with_text()
  local icon = M.get_icon()
  local title = M.get_title()
  local artist = M.get_artist()
  local status = M.get_status()

  if status ~= "playing" and status ~= "paused" then
    return ""
  end

  -- Apply the simplification methods
  title = simplify_text(title)
  artist = simplify_text(artist)
  -- if title/artist are empty, return empty string
  if title == "" and artist == "" then
    return ""
  end

  return format_icon_with_text(icon, artist, title)
end

return M
