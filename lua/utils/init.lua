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

-- Function to iterate over files in the directory and load them dynamically
local function read_utils_dir()
  -- Getting the root path for the current module directory
  local dir_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

  -- Open the directory
  local files = vim.fn.readdir(dir_path)

  for _, file in ipairs(files) do
    -- Skip init.lua
    if file ~= "init.lua" and file:match(".*%.lua$") then
      -- Get the module name without the .lua extension
      local module_name = file:sub(1, -5)
      -- Load the module if not already explicitly set
      if not utils[module_name] then
        utils[module_name] = require("utils." .. module_name)
      end
    end
  end
end

-- Read the directory to load any additional modules
read_utils_dir()

---@alias UtilsModule table<string, any>

---@type UtilsModule
return utils
