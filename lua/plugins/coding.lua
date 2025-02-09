--- @module "plugins.coding"
--- This module defines the coding plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Coding                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Mason-lspconfig
    'williamboman/mason-lspconfig.nvim',
    opts = require('data.types').mason_lsp_config.opts,
  },
  { -- nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    opts = require('data.types').treesitter.opts,
    lazy = true,
    event = 'LazyFile',
    cond = function()
      -- Only load for editable buffers
      return vim.bo.buftype == '' and not vim.bo.readonly
    end,
  },
  { -- nvim-lspconfig
    'neovim/nvim-lspconfig',
    opts = require('data.types').lspconfig.opts,
  },
  { -- Yanky
    'gbprod/yanky.nvim',
    requires = { 'kkharji/sqlite.lua' },
    opts = require('data.types').yanky,
    keys = require('data.keys').yanky,
  },
  {
    'folke/lazydev.nvim',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
        -- Load the wezterm types when the `wezterm` module is required
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
  { -- G-code
    'wilriker/gcode.vim',
  },
  { -- Alternate
    'ton/vim-alternate',
    lazy = true,
    ft = require('data.types').alternate,
    keys = require('data.keys').alternate,
  },
  { -- Tailwind
    'luckasRanarison/tailwind-tools.nvim',
    lazy = true,
    dependencies = require('data.deps').needs_treesitter,
    opts = {},
  },
  { -- Substitute
    'gbprod/substitute.nvim',
    lazy = true,
    opts = require('data.types').substitute,
    keys = require('data.keys').substitute,
  },
  { -- Comment
    'numToStr/Comment.nvim',
    opts = require('data.types').comment,
  },
  { -- Fast Action
    'Chaitanyabsprip/fastaction.nvim',
    opts = {},
  },
  { -- Matchup
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  { -- EasyAlign
    'junegunn/vim-easy-align',
    keys = require('data.keys').easyalign,
  },
  { -- Vim-Shebang
    'vitalk/vim-shebang',
    lazy = false,
  },
  {
    'oskarrrrrrr/symbols.nvim',
    cmd = require('data.cmd').symbols,
    config = function()
      local r = require('symbols.recipes')
      require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, {
        sidebar = {
          auto_peek = false,
          show_guide_lines = true,
          chars = {
            folded = '',
            unfolded = '',
            guide_vert = '',
            guide_middle_item = '',
            guide_last_item = '',
          },
          preview = {
            show_always = true,
          },
        },
      })
    end,
  },
  { -- Treesitter-endwise
    'RRethy/nvim-treesitter-endwise',
    lazy = false,
    priority = 1000,
  },
}
