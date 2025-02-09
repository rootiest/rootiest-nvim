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
    cond = require('data.cond').treesitter,
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
  },
  -- { -- G-code
  --   'wilriker/gcode.vim',
  -- },
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
  -- { -- Fast Action
  --   'Chaitanyabsprip/fastaction.nvim',
  --   opts = {},
  -- },
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
    config = function()
          },
        },
      })
    end,
  },
  -- { -- Vim-Shebang
  --   'vitalk/vim-shebang',
  --   lazy = true,
  -- },
  -- {
  --   'oskarrrrrrr/symbols.nvim',
  --   lazy = true,
  --   cmd = require('data.cmd').symbols,
  --   config = require('data.types').symbols.config,
  -- },
  -- { -- Treesitter-endwise
  --   'RRethy/nvim-treesitter-endwise',
  --   lazy = true,
  -- },
}
