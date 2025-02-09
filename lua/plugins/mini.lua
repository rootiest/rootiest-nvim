---@module "plugins.mini"
--- This module defines the mini plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Mini                           │
--          ╰─────────────────────────────────────────────────────────╯

return {
  {
    'echasnovski/mini.move',
    event = 'VeryLazy',
    opts = {},
  },
  -- { -- Mini Indentscope
  --   'echasnovski/mini.indentscope',
  --   opts = require('data.types').miniindentscope.opts,
  --   init = require('data.types').miniindentscope.init,
  -- },
  -- disable mini.animate cursor
  {
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
    opts = {
      file = {
        ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = {
        dotenv = { glyph = '', hl = 'MiniIconsYellow' },
      },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
