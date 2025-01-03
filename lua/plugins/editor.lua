--- @module "plugins.editor"
--- This module defines the editor plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Editor                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Aerial
    import = 'lazyvim.plugins.extras.editor.aerial',
  },
  { import = 'lazyvim.plugins.extras.ui.smear-cursor' },
  { -- Dial
    import = 'lazyvim.plugins.extras.editor.dial',
  },
  { -- Illuminate
    import = 'lazyvim.plugins.extras.editor.illuminate',
  },
  { -- Illuminate
    'ehpi/vim-illuminate',
    opts = {
      providers = {
        -- Disable LSP proovider due to deprecation warnings
        -- 'lsp',
        'treesitter',
        'regex',
      },
    },
  },
  { -- Outline
    import = 'lazyvim.plugins.extras.editor.outline',
  },
  { -- IncRename

    import = 'lazyvim.plugins.extras.editor.inc-rename',
  },
  { -- Treesitter-context
    import = 'lazyvim.plugins.extras.ui.treesitter-context',
  },
  { -- Navic
    import = 'lazyvim.plugins.extras.editor.navic',
  },
  { -- Refactoring
    import = 'lazyvim.plugins.extras.editor.refactoring',
  },
  { -- Grug-Far
    'MagicDuck/grug-far.nvim',
    opts = {
      engines = {
        astgrep = {
          path = 'ast-grep',
        },
      },
      engine = 'ripgrep',
    },
  },
  { -- Trouble
    'folke/trouble.nvim',
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
  },
  { -- Arrow
    'otavioschwanck/arrow.nvim',
    opts = require('data.types').arrow,
  },
  { -- indent-blankline
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    lazy = true,
  },
  ---@module "neominimap.config.meta"
  { -- NeoMiniMap
    'Isrothy/neominimap.nvim',
    lazy = false,
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
  { -- Zen Mode
    'folke/zen-mode.nvim',
    lazy = true,
    opts = require('data.types').zen,
    keys = require('data.keys').zen,
  },
  { -- Smart Scrolloff
    'tonymajestro/smart-scrolloff.nvim',
    event = 'VeryLazy',
    cond = require('data.func').check_global_var('smart_scrolloff', true, true),
    opts = require('data.types').smartscrolloff,
  },
  { -- Recorder
    'chrisgrieser/nvim-recorder',
    event = 'VeryLazy',
    dependencies = require('data.deps').recorder,
    opts = {},
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
  { -- Rainbow Delimeters
    'HiPhish/rainbow-delimiters.nvim',
  },
  { -- Colorful window separators
    'nvim-zh/colorful-winsep.nvim',
    enabled = false,
    lazy = true,
    opts = require('data.types').winsep,
    event = { 'WinLeave' },
  },
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
  { -- Duck
    'tamton-aquib/duck.nvim',
    config = require('data.types').duck,
  },
  { -- Twilight
    'folke/twilight.nvim',
    opts = require('data.types').twilight,
  },
  { -- Smear Cursor
    'sphamba/smear-cursor.nvim',
    event = 'VeryLazy',
    enabled = function() -- Allow kitty and neovide to use native features
      return not require('data.func').is_neovide()
        and not require('data.func').is_kitty()
    end,
    opts = require('data.types').smearcursor,
    specs = {
      -- disable mini.animate cursor
      {
        'echasnovski/mini.animate',
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },
  { -- Neoscroll
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    enabled = function() -- Allow kitty and neovide to use native features
      return not require('data.func').is_neovide()
        and not require('data.func').is_kitty()
    end,
    opts = {},
  },
  { -- Unimpaired
    'tpope/vim-unimpaired',
    config = true,
  },
  { -- Vim-dirtytalk
    'psliwka/vim-dirtytalk',
    build = ':DirtytalkUpdate',
    init = function()
      vim.cmd('set spelllang=en,programming')
    end,
  },
  { -- Academic
    'ficcdaf/academic.nvim',
    -- optional: only load for certain filetypes
    ft = { 'markdown', 'tex' },
  },
}
