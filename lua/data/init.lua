---@module "data"
--- This module aggregates various data tables used throughout the configuration.
local data = {}

-- Explicitly specify for LSP support
data.keys = require('data.keys')
data.types = require('data.types')
data.func = require('data.func')
data.cmd = require('data.cmd')
data.deps = require('data.deps')
data.dash = require('data.dash')
data.ft = require('data.ft')
data.events = require('data.events')
data.autocmd = require('data.autocmd')
data.cond = require('data.cond')
data.vim = require('data.vim')

-- Generic function to iterate over files in a specified directory and load Lua modules
function data.load_modules_from_dir(directory, module_prefix)
  -- Open the specified directory
  local files = vim.fn.readdir(directory)

  for _, file in ipairs(files) do
    -- Skip init.lua
    if file ~= 'init.lua' and file:match('.*%.lua$') then
      -- Get the module name without the .lua extension
      local module_name = file:sub(1, -5)
      -- Construct the module path
      local module_path = module_prefix .. '.' .. module_name
      -- Load the module if not already explicitly set
      if not _G[module_name] then
        _G[module_name] = require(module_path)
      end
    end
  end
end

-- Example usage
local function read_data_dir()
  -- Getting the root path for the current module directory
  local dir_path = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':h')
  -- Load modules from the data directory
  data.load_modules_from_dir(dir_path, 'data')
end

-- Read the directory and load any additional modules
read_data_dir()

---@alias DataModule table<string, any>

---@type DataModule

return data
