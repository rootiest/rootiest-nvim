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

local plugins = {}

-- Check if lazy.nvim is installed
if pcall(require, 'lazy') then
  -- If lazy.nvim is installed, return an empty table and do nothing
  return plugins
else
  -- If lazy.nvim is not installed and vim.g.ignore_no_lazy is not set, display a warning
  if not vim.g.ignore_no_lazy then
    require('data').func.notify('lazy.nvim is not installed', 'WARNING')
  end

  -- Try to require plugins manually if we are not using lazy.nvim
  local function read_plugins_dir()
    -- Getting the root path for the current module directory
    local dir_path =
      vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':h')
    -- Load modules from the data directory
    require('data').load_modules_from_dir(dir_path, 'plugins')
  end

  -- Read the directory and load any additional modules
  read_plugins_dir()
end

return plugins
