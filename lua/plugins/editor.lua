--          ╭─────────────────────────────────────────────────────────╮
--          │                         Editor                          │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- Aerial
    import = "lazyvim.plugins.extras.editor.aerial",
  },
  { -- Dial
    import = "lazyvim.plugins.extras.editor.dial",
  },
  { -- Harpoon
    import = "lazyvim.plugins.extras.editor.harpoon2",
  },
  { -- Illuminate
    import = "lazyvim.plugins.extras.editor.illuminate",
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  { -- indent-blankline
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
  },
  { -- Outline
    import = "lazyvim.plugins.extras.editor.outline",
  },
  { -- FoldNav
    "domharries/foldnav.nvim",
    lazy = true,
    keys = {
      {
        "<C-h>",
        function()
          require("foldnav").goto_start()
        end,
      },
      {
        "<C-j>",
        function()
          require("foldnav").goto_next()
        end,
      },
      {
        "<C-k>",
        function()
          require("foldnav").goto_prev_start()
        end,
      },
      {
        "<C-l>",
        function()
          require("foldnav").goto_end()
        end,
      },
    },
  },
  { -- CodeWindow
    "gorbit99/codewindow.nvim",
    event = "BufEnter",
    config = function()
      require("codewindow").setup({
        auto_enable = true,
        exclude_filetypes = { "help", "dashboard" },
        minimap_width = 16,
        width_multiplier = 3,
        screen_bounds = "background",
        window_border = "none",
        relative = "win",
      })
      require("codewindow").apply_default_keybinds()
    end,
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
    keys = {
      {
        "zk",
        function()
          require("config.rootiest").toggle_precognition()
        end,
        desc = "Toggle Precognition",
      },
    },
  },
  { -- Zen Mode
    "folke/zen-mode.nvim",
    --event = "VeryLazy",
    lazy = true,
    opts = {},
    keys = {
      { -- Toggle ZenMode
        "<leader>z",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Toggle ZenMode",
      },
    },
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
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {},
  },
  { -- Comment Box
    "LudoPinelli/comment-box.nvim",
  },
}
