---@module "utils"
--- This module aggregates various utility functions used across the configuration.
--- It provides access to caching mechanisms, Git utilities, WakaTime statistics, music status, highlight utilities, and a blinking effect utility.

local utils = {}

-- Explicitly specify modules for LSP support
utils.cache_stats = require("utils.cache_stats")
utils.git = require("utils.git")
utils.wakatime_stats = require("utils.wakatime_stats")
utils.music_stats = require("utils.music_stats")
utils.highlight = require("utils.highlight")
utils.blinky = require("utils.blinky")
utils.indentor = require("utils.indentor")

---@alias UtilsModule table<string, any>

---@type UtilsModule
return utils
