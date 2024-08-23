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
  { -- Ollama Copilot
    "Faywyn/llama-copilot.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = require("data.types").ollama_copilot,
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
    ft = require("data.types").alternate,
    keys = require("data.keys").alternate,
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
    opts = {},
  },
  { -- Substitute
    "gbprod/substitute.nvim",
    lazy = true,
    opts = require("data.types").substitute,
    keys = require("data.keys").substitute,
  },
  { -- mini.splitjoin
    "echasnovski/mini.splitjoin",
    event = "InsertEnter",
    opts = {
      mappings = require("data.keys").splitjoin,
    },
  },
}
