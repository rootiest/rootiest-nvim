--- @module "plugins.editor"
--- This module defines the editor plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Editor                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Illuminate
    'ehpi/vim-illuminate',
    opts = require('data.types').illuminate.opts,
  },
  { -- Grug-Far
    'MagicDuck/grug-far.nvim',
    opts = require('data.types').grug_far.opts,
  },
  { -- Trouble
    'folke/trouble.nvim',
    lazy = true,
    event = 'LazyFile',
    cmd = require('data.cmd').trouble,
    opts = require('data.types').trouble.opts,
  },
  { -- Flash
    'folke/flash.nvim',
    opts = require('data.types').flash,
    keys = require('data.keys').flash,
  },
  { -- NeoTree
    'nvim-neo-tree/neo-tree.nvim',
    opts = require('data.types').neotree.opts,
    cond = require('data.cond').neotree,
  },
  { -- Arrow
    'otavioschwanck/arrow.nvim',
    lazy = true,
    event = 'User LazyFileOpen',
    opts = require('data.types').arrow,
  },
  ---@module "neominimap.config.meta"
  { -- NeoMiniMap
    'Isrothy/neominimap.nvim',
    lazy = false,
    -- event = 'User LazyFileOpen',
    keys = require('data.keys').minimap.func,
    init = require('data.types').minimap.init(),
    cond = require('data.types').minimap.cond(),
  },
  { -- Persistence
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
  },
  { -- DeadColumn
    'Bekaboo/deadcolumn.nvim',
    event = 'BufEnter',
    cond = require('data.func').check_global_var('dead_column', true, true),
  },
  { -- Precognition
    'tris203/precognition.nvim',
    lazy = true,
    opts = {},
    keys = require('data.keys').precog,
  },
  { -- Smart Scrolloff
    'tonymajestro/smart-scrolloff.nvim',
    lazy = true,
    event = 'LazyFile',
    cond = require('data.func').check_global_var('smart_scrolloff', true, true),
    opts = require('data.types').smartscrolloff,
  },
  { -- Recorder
    'chrisgrieser/nvim-recorder',
    lazy = true,
    dependencies = require('data.deps').recorder,
    keys = require('data.keys').recorder,
  },
  { -- Comment Box
    'LudoPinelli/comment-box.nvim',
    lazy = false,
  },
  { -- Todo Comments
    'folke/todo-comments.nvim',
    opts = require('data.types').todo.opts,
    cond = require('data.cond').todo,
    enabled = true,
  },
  -- { -- Rainbow Delimeters
  --   'HiPhish/rainbow-delimiters.nvim',
  -- },
  -- { -- Colorful window separators
  --   'nvim-zh/colorful-winsep.nvim',
  --   enabled = false,
  --   lazy = true,
  --   opts = require('data.types').winsep,
  --   event = { 'WinLeave' },
  -- },
  { -- Auto Cursorline
    'delphinus/auto-cursorline.nvim',
    cond = require('data.func').check_global_var('auto_cursorline', true, true),
    opts = require('data.types').autocursorline,
  },
  { -- Bars N Lines
    'OXY2DEV/bars-N-lines.nvim',
    cond = require('data.types').barsNlines.enabled,
    lazy = false,
    config = require('data.types').barsNlines.config,
  },
  { -- UndoTree
    'mbbill/undotree',
    lazy = false,
    config = require('data.types').undotree,
    keys = require('data.keys').undotree,
  },
  { -- Noice
    'folke/noice.nvim',
    optional = true,
    opts = require('data.types').noice,
  },
  -- { -- Duck
  --   'tamton-aquib/duck.nvim',
  --   config = require('data.types').duck,
  -- },
  { -- Smear Cursor
    'sphamba/smear-cursor.nvim',
    event = 'VeryLazy',
    enabled = function() -- Allow kitty and neovide to use native features
      return not require('data.func').is_neovide()
        and not require('data.func').is_kitty()
    end,
    opts = require('data.types').smearcursor,
    keys = require('data.keys').smearcursor,
  },
  -- { -- Unimpaired
  --   'tpope/vim-unimpaired',
  --   config = true,
  -- },
  -- { -- Vim-dirtytalk
  --   'psliwka/vim-dirtytalk',
  --   build = ':DirtytalkUpdate',
  --   init = require('data.types').dirtytalk.init,
  -- },
  -- { -- Academic
  --   'ficcdaf/academic.nvim',
  --   -- optional: only load for certain filetypes
  --   ft = require('data.ft').academic,
  -- },
  -- { -- Vim-cool
  --   'romainl/vim-cool',
  --   lazy = false,
  -- },
}
