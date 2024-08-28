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
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        symbols = { -- Configure symbols mode
          win = {
            type = "split", -- split window
            relative = "win", -- relative to current window
            position = "right", -- right side
            size = 0.3, -- 30% of the window
          },
        },
      },
    },
  },
  { -- Flash
    "folke/flash.nvim",
    opts = {
      modes = { char = { jump_labels = true } },
    },
  },
  { -- Arrow
    "otavioschwanck/arrow.nvim",
    opts = data.types.arrow,
  },
  { -- indent-blankline
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
  },
  { -- FoldNav
    "domharries/foldnav.nvim",
    lazy = true,
    keys = data.keys.foldnav,
  },
  ---@module "neominimap.config.meta"
  { -- NeoMiniMap
    "Isrothy/neominimap.nvim",
    enabled = true,
    lazy = false,
    keys = data.keys.minimap,
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
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("smoothcursor").setup({})
    end,
  },
  { -- Smart Scrolloff
    "tonymajestro/smart-scrolloff.nvim",
    event = "VeryLazy",
    opts = {
      scrolloff_percentage = 0.25,
    },
  },
  { -- Recorder
    "chrisgrieser/nvim-recorder",
    event = "VeryLazy",
    dependencies = "rcarriga/nvim-notify",
    opts = {},
  },
  { -- Comment Box
    "LudoPinelli/comment-box.nvim",
  },
  { -- vim-visual-multi
    "mg979/vim-visual-multi",
  },
  { -- Todo Comments
    "folke/todo-comments.nvim",
    opts = {
      keywords = data.types.todo.keywords,
    },
  },
  { -- Rainbow Delimeters
    "HiPhish/rainbow-delimiters.nvim",
  },
}
