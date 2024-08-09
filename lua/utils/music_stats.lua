--          ╭─────────────────────────────────────────────────────────╮
--          │                       Music Stats                       │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

require("utils.cache_stats")
local cache_file = os.getenv("HOME") .. "/.cache/music_cache.txt"

local separator = "␟"
local last_known_value = ""

-- Function to read the cache file
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

-- Parse the cached music data
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
  return parse_cache()
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

-- Function to remove text inside parentheses, including the parentheses themselves
local function remove_parentheses(text)
  return text:gsub("%b()", "")
end

-- Function to abbreviate common words or phrases
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

-- Function to strip unnecessary words or phrases
local function strip_redundant(text)
  local redundant_phrases =
    { "Radio Edit", "Extended Version", "Remix", "Instrumental", "Live" }
  for _, phrase in ipairs(redundant_phrases) do
    text = text:gsub(phrase, "")
  end
  return text:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1") -- Clean up any extra spaces
end

-- Function to limit the number of words in the text
local function limit_words(text, max_words)
  local words = vim.split(text, "%s+")
  if #words > max_words then
    return table.concat(vim.list_slice(words, 1, max_words), " ") .. "..."
  end
  return text
end

-- Function to remove duplicate words
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

-- Function to shorten text based on delimiters
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

-- Combine all simplification functions
local function simplify_text(text)
  text = remove_parentheses(text)
  text = strip_redundant(text)
  text = abbreviate(text)
  text = shorten_text(text) -- Apply shortening based on delimiters
  text = limit_words(text, 7) -- Adjust max words as needed
  text = remove_duplicates(text)
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
  local status = M.get_status()

  if status ~= "playing" and status ~= "paused" then
    return ""
  end

  -- Apply the simplification methods
  title = simplify_text(title)
  artist = simplify_text(artist)

  return format_icon_with_text(icon, artist, title)
end

return M
