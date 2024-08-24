local cache = require("utils.cache_stats")
local git = require("utils.git")
local wakatime = require("utils.wakatime_stats")
local music = require("utils.music_stats")
local highlight = require("utils.highlight")
local rootiest = require("utils.rootiest")

return {
  cache_stats = cache,
  git = git,
  wakatime_stats = wakatime,
  music_stats = music,
  highlight = highlight,
  rootiest = rootiest,
}
