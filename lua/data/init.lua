---@module "data"
--- This module aggregates various data tables used throughout the configuration.
local M = {}

-- Explicitly specify for LSP support
M.keys = require("data.keys")
M.types = require("data.types")
M.func = require("data.func")
M.cmd = require("data.cmd")
M.deps = require("data.deps")
M.dash = require("data.dash")

-- Function to iterate over files in the directory
local function read_data_dir()
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
      if not M[module_name] then
        M[module_name] = require("data." .. module_name)
      end
    end
  end
end

-- Read the directory and load any additional modules
read_data_dir()

return M
