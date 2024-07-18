-- -----------------------------------------------------------------------------
-- --------------------------------- EDITOR ------------------------------------
-- -----------------------------------------------------------------------------

return {
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.dial" },
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  { import = "lazyvim.plugins.extras.editor.outline" },
  { import = "lazyvim.plugins.extras.editor.telescope" },
  {
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
  {
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
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "amitds1997/remote-nvim.nvim",
    event = "VeryLazy",
    version = "*", -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  },
  {
    "Bekaboo/deadcolumn.nvim",
    event = "VeryLazy",
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
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
  },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
