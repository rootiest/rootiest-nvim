--          ╭─────────────────────────────────────────────────────────╮
--          │                         Coding                          │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- Mason-lspconfig
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },
  { -- Yanky
    import = "lazyvim.plugins.extras.coding.yanky",
  },
  { -- Mini Surround
    import = "lazyvim.plugins.extras.coding.mini-surround",
  },
  { -- VSCode
    import = "lazyvim.plugins.extras.vscode",
  },
  { -- G-code
    "wilriker/gcode.vim",
  },
  { -- Mini Align
    "echasnovski/mini.align",
    event = "InsertEnter",
    config = function()
      require("mini.align").setup()
    end,
  },
  { -- Alternate
    "ton/vim-alternate",
    lazy = true,
    ft = { "cpp", "h", "hpp", "c" },
    keys = {
      { -- Toggle Alternate
        "<leader>a",
        "<cmd>Alternate<cr>",
        desc = "Toggle Alternate",
      },
    },
  },
  { -- Highlight colors
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  { -- Tailwind
    "luckasRanarison/tailwind-tools.nvim",
    lazy = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}, -- your configuration
  },
  { -- Substitute
    "gbprod/substitute.nvim",
    lazy = true,
    opts = {
      yank_substituted_text = false,
      preserve_cursor_position = true,
    },
    keys = {
      { -- Substitute operator in normal mode
        "x",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute operator",
      },
      { -- Substitute line in normal mode
        "xx",
        function()
          require("substitute").line()
        end,
        desc = "Substitute line",
      },
      { -- Substitute end of line in normal mode
        "X",
        function()
          require("substitute").eol()
        end,
        desc = "Substitute end of line",
      },
      { -- Substitute visual selection in visual mode
        "x",
        function()
          require("substitute").visual()
        end,
        desc = "Substitute visual selection",
        mode = "x",
      },
      { -- Substitute visual selection in visual mode
        "<leader>r",
        function()
          require("substitute").visual()
        end,
        desc = "Substitute",
        mode = "x",
      },
    },
  },
  { -- mini.splitjoin
    "echasnovski/mini.splitjoin",
    event = "InsertEnter",
    opts = {
      mappings = {
        toggle = "gJ",
      },
    },
  },
}
