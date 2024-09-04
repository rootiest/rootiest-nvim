---@module "config.lazy"
--- This module bootstraps Lazy.nvim.
--- Lazy is a plugin manager for Neovim.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Lazy                           │
--          ╰─────────────────────────────────────────────────────────╯
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
  {
    "LazyVim/LazyVim", -- LazyVim
    import = "lazyvim.plugins", -- LazyVim Core Plugins
  },
  { import = "plugins" }, -- General Plugins
}

-- Automatically import all subdirectories of `lua/plugins`
local plugin_dirs = vim.fn.glob("~/.config/nvim/lua/plugins/*", true, true)
for _, dir in ipairs(plugin_dirs) do
  if vim.fn.isdirectory(dir) == 1 then
    table.insert( -- Add directory to the plugin import table
      plugin_specs,
      { import = "plugins." .. vim.fn.fnamemodify(dir, ":t") }
    )
  end
end

require("lazy").setup({
  spec = plugin_specs,
  defaults = {
    lazy = false,
    version = false,
    event = "VeryLazy",
  },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  profiling = {
    loader = true,
    require = true,
  },
  ui = {
    border = "rounded",
    title = " Plugin Manager ",
  },
})
