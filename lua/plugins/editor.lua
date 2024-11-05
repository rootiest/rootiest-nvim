--- @module "plugins.editor"
--- This module defines the editor plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Editor                          │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- Aerial
    import = "lazyvim.plugins.extras.editor.aerial",
  },
  { -- Dial
    import = "lazyvim.plugins.extras.editor.dial",
  },
  { -- Illuminate
    import = "lazyvim.plugins.extras.editor.illuminate",
  },
  { -- Outline
    import = "lazyvim.plugins.extras.editor.outline",
  },
  { -- IncRename
    import = "lazyvim.plugins.extras.editor.inc-rename",
  },
  { -- Treesitter-context
    import = "lazyvim.plugins.extras.ui.treesitter-context",
  },
  { -- Navic
    import = "lazyvim.plugins.extras.editor.navic",
  },
  { -- Refactoring
    import = "lazyvim.plugins.extras.editor.refactoring",
  },
  { -- Trouble
    "folke/trouble.nvim",
    cmd = data.cmd.trouble,
    opts = data.types.trouble.opts,
  },
  { -- Flash
    "folke/flash.nvim",
    opts = data.types.flash,
    keys = data.keys.flash,
  },
  { -- NeoTree
    "nvim-neo-tree/neo-tree.nvim",
    opts = data.types.neotree.opts,
  },
  { -- Arrow
    "otavioschwanck/arrow.nvim",
    opts = data.types.arrow,
  },
  { -- indent-blankline
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
  },
  ---@module "neominimap.config.meta"
  { -- NeoMiniMap
    "Isrothy/neominimap.nvim",
    lazy = false,
    keys = data.keys.minimap.func,
    init = data.types.minimap.init(),
    cond = data.types.minimap.cond(),
  },
  { -- Persistence
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  { -- DeadColumn
    "Bekaboo/deadcolumn.nvim",
    event = "BufEnter",
    cond = data.func.check_global_var("dead_column", true, true),
  },
  { -- Precognition
    "tris203/precognition.nvim",
    lazy = true,
    opts = {},
    keys = data.keys.precog,
  },
  { -- Zen Mode
    "folke/zen-mode.nvim",
    lazy = true,
    opts = data.types.zen,
    keys = data.keys.zen,
  },
  { -- SmoothCursor
    "gen740/SmoothCursor.nvim",
    event = "BufEnter",
    -- lazy = true,
    opts = data.types.smoothcursor,
    enabled = false,
  },
  { -- Smart Scrolloff
    "tonymajestro/smart-scrolloff.nvim",
    event = "VeryLazy",
    cond = data.func.check_global_var("smart_scrolloff", true, true),
    opts = data.types.smartscrolloff,
  },
  { -- Recorder
    "chrisgrieser/nvim-recorder",
    event = "VeryLazy",
    dependencies = data.deps.recorder,
    opts = {},
  },
  { -- Comment Box
    "LudoPinelli/comment-box.nvim",
  },
  { -- Todo Comments
    "folke/todo-comments.nvim",
    opts = data.types.todo.opts,
    cond = data.cond.todo,
    enabled = true,
  },
  { -- Rainbow Delimeters
    "HiPhish/rainbow-delimiters.nvim",
  },
  { -- Colorful window separators
    "nvim-zh/colorful-winsep.nvim",
    enabled = false,
    lazy = true,
    opts = data.types.winsep,
    event = { "WinLeave" },
  },
  { -- Auto Cursorline
    "delphinus/auto-cursorline.nvim",
    cond = data.func.check_global_var("auto_cursorline", true, true),
    opts = data.types.autocursorline,
  },
  { -- Bars N Lines
    "OXY2DEV/bars-N-lines.nvim",
    cond = data.types.barsNlines.enabled,
    lazy = false,
    config = data.types.barsNlines.config,
  },
  { -- UndoTree
    "mbbill/undotree",
    lazy = false,
    config = data.types.undotree,
    keys = data.keys.undotree,
  },
  { -- Noice
    "folke/noice.nvim",
    optional = true,
    opts = data.types.noice,
  },
  { -- Duck
    "tamton-aquib/duck.nvim",
    config = data.types.duck,
  },
  { -- Volt
    "rootiest/volt",
    lazy = true,
  },
  { -- Minty
    "nvchad/minty",
    lazy = true,
  },
  {
    "folke/twilight.nvim",
    opts = data.types.twilight,
  },
  -- { -- vim-footprints
  --   "axlebedev/vim-footprints",
  --   init = function()
  --     vim.g.footprintsColor = "#251519"
  --     vim.g.footprintsTermColor = "208"
  --     vim.g.footprintsEasingFunction = "linear"
  --     vim.g.footprintsHistoryDepth = 20
  --     vim.g.footprintsExcludeFiletypes = { "magit", "nerdtree", "diff" }
  --     vim.g.footprintsEnabledByDefault = 1
  --     vim.g.footprintsOnCurrentLine = 0
  --   end,
  -- },
}
