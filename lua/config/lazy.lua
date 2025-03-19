---@module "config.lazy"
--- This module bootstraps Lazy.nvim.
--- Lazy is a plugin manager for Neovim.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Lazy                           │
--          ╰─────────────────────────────────────────────────────────╯
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ PLUGINS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local plugin_specs = {
  { -- LazyVim
    'LazyVim/LazyVim',
    priority = 900,
    opts = require('data.types').lazyvim.opts,
  },
  {
    import = 'lazyvim.plugins', -- LazyVim Core Plugins
  },
  { -- VSCode
    import = 'lazyvim.plugins.extras.vscode',
  },
  { import = 'lvplugs' }, -- LazyVim Plugins
  { import = 'plugins' }, -- General Plugins
}

-- Automatically import all subdirectories of `lua/plugins`
local plugin_dirs = vim.fn.glob('~/.config/nvim/lua/plugins/*', true, true)
for _, dir in ipairs(plugin_dirs) do
  if vim.fn.isdirectory(dir) == 1 then
    table.insert( -- Add directory to the plugin import table
      plugin_specs,
      { import = 'plugins.' .. vim.fn.fnamemodify(dir, ':t') }
    )
  end
end

-- Initialize Lazy plugin manager
require('lazy').setup({
  spec = plugin_specs,
  rocks = {
    hererocks = vim.g.use_luarocks,
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    fallback = true,
  },
  install = {
    missing = true,
    colorscheme = {
      -- 'ex-catppuccin-mocha',
      'catppuccin-mocha',
      'tokyonight',
      'default',
    },
  },
  defaults = {
    lazy = true,
    version = nil,
    event = 'VeryLazy',
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true,
    frequency = 3600,
    check_pinned = false,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      disabled_plugins = require('data.types').lazy.disabled_plugins,
    },
  },
  profiling = {
    loader = true,
    require = true,
  },
  ui = {
    border = 'rounded',
    title = ' Plugin Manager ',
  },
})
