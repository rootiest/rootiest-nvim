---@module "plugins.mini"
--- This module defines the mini plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Mini                           │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- mini.move
    'echasnovski/mini.move',
    event = 'VeryLazy',
    opts = {},
  },
  { -- disable mini.animate cursor
    'echasnovski/mini.animate',
    optional = true,
    opts = {
      cursor = { enable = false },
    },
  },
  { -- mini.align
    'echasnovski/mini.align',
    event = 'InsertEnter',
    config = function()
      require('mini.align').setup()
    end,
  },
  { -- mini.splitjoin
    'echasnovski/mini.splitjoin',
    event = 'InsertEnter',
    opts = {
      mappings = require('data.keys').splitjoin,
    },
  },
  { -- mini.surround
    'echasnovski/mini.surround',
    opts = {},
  },
  { -- mini.files
    'echasnovski/mini.files',
    opts = require('data.types').minifiles.opts,
    keys = require('data.keys').minifiles,
    config = require('data.types').minifiles.config,
  },
  { -- mini.icons
    'echasnovski/mini.icons',
    lazy = true,
    opts = require('data.types').miniicons.opts,
    init = require('data.types').miniicons.init,
  },
  { -- mini.hipatterns
    'echasnovski/mini.hipatterns',
    version = false,
    event = 'VeryLazy',
    opts = function()
      local hipatterns = require('mini.hipatterns')
      return {
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
}
