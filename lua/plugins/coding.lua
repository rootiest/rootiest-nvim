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
  },
  { -- Yanky
    'gbprod/yanky.nvim',
    requires = { 'kkharji/sqlite.lua' },
    opts = require('data.types').yanky,
    keys = require('data.keys').yanky,
  },
  {
    'folke/lazydev.nvim',
    opts = require('data.types').lazydev.opts,
    dependencies = require('data.deps').lazydev,
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
  { -- Matchup
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  { -- EasyAlign
    'junegunn/vim-easy-align',
    lazy = true,
    keys = require('data.keys').easyalign,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    cond = require('data.cond').tiny_inline_diagnostic,
    config = require('data.types').tiny_inline_diagnostic.config,
  },
}
