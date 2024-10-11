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
  {
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
    opts = {},
    keys = data.keys.zen,
  },
  { -- SmoothCursor
    "gen740/SmoothCursor.nvim",
    event = "BufEnter",
    -- lazy = true,
    opts = data.types.smoothcursor,
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
  },
  { -- Rainbow Delimeters
    "HiPhish/rainbow-delimiters.nvim",
  },
  { -- Colorful window separators
    "nvim-zh/colorful-winsep.nvim",
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
    config = function()
      -- Layout
      vim.g.undotree_ShortIndicators = 0
      vim.g.undotree_SplitWidth = 32
      -- Set focus to the tree when it's toggled
      vim.g.undotree_SetFocusWhenToggle = 1
      -- Set up tree shape
      vim.g.undotree_TreeNodeShape = ""
      vim.g.undotree_TreeVertShape = ""
      vim.g.undotree_TreeSplitShape = ""
      vim.g.undotree_TreeReturnShape = ""
      -- Hide helpline
      vim.g.undotree_HelpLine = 0
      -- Hide diff panel
      vim.g.undotree_DiffAutoOpen = 0
    end,
    keys = data.keys.undotree,
  },
  { -- NumberToggle
    "sitiom/nvim-numbertoggle",
  },
  { -- Noice
    "folke/noice.nvim",
    optional = true,
    opts = data.types.noice,
  },
  { -- Duck
    "tamton-aquib/duck.nvim",
    config = function()
      local add_km = data.func.add_keymap
      add_km({
        lhs = "<leader>uD",
        group = "Duck",
        icon = { icon = "󰇥", color = "yellow" },
      })
      add_km({
        "<leader>uDd",
        function()
          require("duck").hatch()
        end,
        desc = "Hatch",
      })
      add_km({
        "<leader>uDk",
        function()
          require("duck").cook()
        end,
        desc = "Cook",
      })
      add_km({
        "<leader>uDa",
        function()
          require("duck").cook_all()
        end,
        desc = "Cook All",
      })
    end,
  },
  {
    "rootiest/volt",
    lazy = true,
  },
  { "nvchad/minty", lazy = true },
}
