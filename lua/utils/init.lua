---@module "utils"
--- This module aggregates various utility functions used across the configuration.
--- It provides access to caching mechanisms, Git utilities, WakaTime statistics, music status, highlighting utilities, and a blinking effect utility.

local cache = require("utils.cache_stats")
local git = require("utils.git")
local wakatime = require("utils.wakatime_stats")
local music = require("utils.music_stats")
local highlight = require("utils.highlight")
local blinky = require("utils.blinky")

---@alias UtilsModule
---| { cache_stats: table, git: table, wakatime_stats: table, music_stats: table, highlight: table, blinky: table }

---@type UtilsModule
local utils = {
  cache_stats = cache,
  git = git,
  wakatime_stats = wakatime,
  music_stats = music,
  highlight = highlight,
  blinky = blinky,
}

return utils
