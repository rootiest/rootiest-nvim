---@module "plugins"
--- This module defines the plugins for the Neovim configuration.
---
--- If lazy.nvim is installed, this module returns an empty table
--- to defer plugin management to lazy.nvim.
---
--- If lazy.nvim is not installed, the module loads each
--- Lua file in the `plugins` directory.
---
--- Note:
--- A warning will be triggered if lazy.nvim is not installed unless
--- the variable `vim.g.ignore_no_lazy` is set to `true`.
--
--          ╭─────────────────────────────────────────────────────────╮
--          │                        PLUGINS DATA                     │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Check if lazy.nvim is installed
if pcall(require, "lazy") then
  -- If lazy.nvim is installed, return an empty table and do nothing
  return M
else
  -- If lazy.nvim is not installed and vim.g.ignore_no_lazy is not set, display a warning
  if not vim.g.ignore_no_lazy then
    require("data").func.notify("lazy.nvim is not installed", "WARNING")
  end

  -- Function to iterate over files in the directory and load them dynamically
  local function read_plugins_dir()
    -- Get the root path for the plugins directory
    local dir_path =
      vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

    -- Open the directory
    local files = vim.fn.readdir(dir_path)

    for _, file in ipairs(files) do
      -- Skip init.lua
      if file ~= "init.lua" and file:match(".*%.lua$") then
        -- Get the module name without the .lua extension
        local plugin_name = file:sub(1, -5)
        -- Load the plugin configuration file
        require("plugins." .. plugin_name)
      end
    end
  end

  -- Read the directory and load plugin configuration files when lazy.nvim is not installed
  read_plugins_dir()
end

return M
