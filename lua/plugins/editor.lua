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
  { -- Trouble
    "folke/trouble.nvim",
    cmd = data.cmd.trouble,
    opts = data.types.trouble.opts,
  },
  { -- Flash
    "folke/flash.nvim",
    opts = {
      modes = { char = { jump_labels = true } },
    },
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
    opts = {
      cursor = "",
    },
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
    dependencies = data.deps.recorder,
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
    opts = data.types.todo.opts,
  },
  { -- Rainbow Delimeters
    "HiPhish/rainbow-delimiters.nvim",
  },
  { -- Colorful window separators
    "nvim-zh/colorful-winsep.nvim",
    lazy = true,
    opts = {
      only_line_seq = false,
      symbols = data.types.colorful_winsep.symbols,
      no_exec_files = data.types.colorful_winsep.no_exec_files,
    },
    event = { "WinLeave" },
  },
  { -- Auto Cursorline
    "delphinus/auto-cursorline.nvim",
    enabled = data.func.check_global_var("auto_cursorline", true, true),
    opts = {
      wait_ms = 2000,
    },
  },
  { -- Bars N Lines
    "OXY2DEV/bars-N-lines.nvim",
    enabled = data.types.barsNlines.enabled,
    lazy = false,
    config = data.types.barsNlines.config,
  },
  { -- UndoTree Telescope extension
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    opts = function()
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>uU", "<cmd>Telescope undo<cr>")
      return {
        extensions = {
          undo = {},
        },
      }
    end,
  },
  { -- UndoTree
    "mbbill/undotree",
    config = function()
      data.func.add_keymap(
        "<leader>uu",
        "<cmd>UndotreeToggle<cr>",
        "Toggle UndoTree"
      )
    end,
  },
  { -- NumberToggle
    "sitiom/nvim-numbertoggle",
  },
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      presets = { inc_rename = true },
    },
  },
}
