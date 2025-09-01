---@module "plugins.mini"
--- This module defines the mini plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Mini                           │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- mini.move
    'nvim-mini/mini.move',
    event = 'VeryLazy',
    opts = {},
  },
  { -- disable mini.animate cursor
    'nvim-mini/mini.animate',
    optional = true,
    opts = {
      cursor = { enable = false },
    },
  },
  { -- mini.align
    'nvim-mini/mini.align',
    event = 'InsertEnter',
    config = function()
      require('mini.align').setup()
    end,
  },
  { -- mini.splitjoin
    'nvim-mini/mini.splitjoin',
    event = 'InsertEnter',
    opts = {
      mappings = require('data.keys').splitjoin,
    },
  },
  { -- mini.surround
    'nvim-mini/mini.surround',
    opts = {},
  },
  { -- mini.files
    'nvim-mini/mini.files',
    opts = require('data.types').minifiles.opts,
    keys = require('data.keys').minifiles,
    config = require('data.types').minifiles.config,
  },
  { -- mini.icons
    'nvim-mini/mini.icons',
    lazy = true,
    opts = require('data.types').miniicons.opts,
    init = require('data.types').miniicons.init,
  },
}
