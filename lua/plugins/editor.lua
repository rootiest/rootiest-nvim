-- -----------------------------------------------------------------------------
-- --------------------------------- EDITOR ------------------------------------
-- -----------------------------------------------------------------------------

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
  { -- Outline
    import = "lazyvim.plugins.extras.editor.outline",
  },
  { -- Telescope
    import = "lazyvim.plugins.extras.editor.telescope",
  },
  { -- FoldNav
    "domharries/foldnav.nvim",
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
  { -- Which-Key
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      win = {
        wo = {
          winblend = 10,
        },
      },
    },
  },
  { -- CodeWindow
    "gorbit99/codewindow.nvim",
    event = "InsertEnter",
    config = function()
      require("codewindow").setup({
        active_in_terminals = false, -- Should the minimap activate for terminal buffers
        auto_enable = true, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
        exclude_filetypes = { "help", "dashboard" }, -- Choose certain filetypes to not show minimap on
        max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
        max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
        minimap_width = 10, -- The width of the text part of the minimap
        use_lsp = true, -- Use the builtin LSP to show errors and warnings
        use_treesitter = true, -- Use nvim-treesitter to highlight the code
        use_git = true, -- Show small dots to indicate git additions and deletions
        width_multiplier = 4, -- How many characters one dot represents
        z_index = 1, -- The z-index the floating window will be on
        show_cursor = true, -- Show the cursor position in the minimap
        screen_bounds = "background", -- How the visible area is displayed, "lines": lines above and below, "background": background color
        window_border = "none", -- The border style of the floating window (accepts all usual options)
        relative = "win", -- What will be the minimap be placed relative to, "win": the curre
        events = {
          "TextChanged",
          "InsertLeave",
          "DiagnosticChanged",
          "FileWritePost",
        }, -- Events that update the code window
      })
      require("codewindow").apply_default_keybinds()
    end,
  },
  { -- Persistence
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  { -- Remote-nvim
    "amitds1997/remote-nvim.nvim",
    lazy = true,
    version = "*", -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  },
  { -- DeadColumn
    "Bekaboo/deadcolumn.nvim",
    event = "InsertEnter",
    config = function()
      require("deadcolumn").setup({
        scope = "line", ---@type string|fun(): integer
        ---@type string[]|fun(mode: string): boolean
        modes = function(mode)
          return mode:find("^[ictRss\x13]") ~= nil
        end,
        blending = {
          threshold = 0.9,
          colorcode = "#737895",
          hlgroup = { "Normal", "bg" },
        },
        warning = {
          alpha = 0.4,
          offset = 0,
          colorcode = "#f27b82",
          hlgroup = { "Error", "bg" },
        },
        extra = {
          ---@type string?
          follow_tw = "80",
        },
      })
      vim.cmd(":set colorcolumn=120")
    end,
  },
  { -- Precognition
    "tris203/precognition.nvim",
    lazy = true,
    opts = {},
  },
  { -- Zen Mode
    "folke/zen-mode.nvim",
    --event = "VeryLazy",
    lazy = true,
    opts = {},
  },
  { -- SmoothCursor
    "gen740/SmoothCursor.nvim",
    event = "InsertEnter",
    lazy = true,
    config = function()
      require("smoothcursor").setup({
        type = "default",
        cursor = "",
        texthl = "SmoothCursor",
        fancy = {
          enable = true, -- enable fancy mode
          head = { cursor = "" },
          body = {},
          tail = { false }, -- false to disable fancy tail
        },
        matrix = { -- Loaded when 'type' is set to "matrix"
          head = {
            cursor = require("smoothcursor.matrix_chars"),
            texthl = {
              "SmoothCursor",
            },
          },
          body = {
            length = 6, -- Specifies the length of the cursor body
            cursor = require("smoothcursor.matrix_chars"),
            texthl = {
              "SmoothCursorGreen",
            },
          },
          tail = {
            texthl = {
              "SmoothCursor",
            },
          },
          unstop = false,
        },
        autostart = true, -- Automatically start SmoothCursor
        always_redraw = true, -- Redraw the screen on each update
        flyin_effect = "bottom", -- Choose "bottom" or "top" for flying effect
        speed = 25, -- Max speed is 100 to stick with your current position
        intervals = 35, -- Update intervals in milliseconds
        priority = 10, -- Set marker priority
        timeout = 3000, -- Timeout for animations in milliseconds
        threshold = 3, -- Animate only if cursor moves more than this many lines
        max_threshold = 2000, -- If you move more than this many lines, don't animate (if `nil`, deactivate check)
        disable_float_win = false, -- Disable in floating windows
      })
      -- Define last cursor position icon
      vim.fn.sign_define("smoothcursor_n", { text = "" })
      vim.fn.sign_define("smoothcursor_v", { text = " " })
      vim.fn.sign_define("smoothcursor_V", { text = "" })
      vim.fn.sign_define("smoothcursor_i", { text = "" })
      vim.fn.sign_define("smoothcursor_�", { text = "" })
      vim.fn.sign_define("smoothcursor_R", { text = "󰊄" })
    end,
  },
}
