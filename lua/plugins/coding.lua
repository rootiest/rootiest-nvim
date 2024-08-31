--          ╭─────────────────────────────────────────────────────────╮
--          │                         Coding                          │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- Mason-lspconfig
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
  { -- Yanky
    import = "lazyvim.plugins.extras.coding.yanky",
  },
  { -- VSCode
    import = "lazyvim.plugins.extras.vscode",
  },
  { -- Neogen
    import = "lazyvim.plugins.extras.coding.neogen",
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
    ft = data.types.alternate,
    keys = data.keys.alternate,
  },
  { -- Tailwind
    "luckasRanarison/tailwind-tools.nvim",
    lazy = true,
    dependencies = data.deps.needs_treesitter,
    opts = {},
  },
  { -- Substitute
    "gbprod/substitute.nvim",
    lazy = true,
    opts = data.types.substitute,
    keys = data.keys.substitute,
  },
  { -- mini.splitjoin
    "echasnovski/mini.splitjoin",
    event = "InsertEnter",
    opts = {
      mappings = data.keys.splitjoin,
    },
  },
  { -- mini-surround
    "echasnovski/mini.surround",
    opts = {},
    keys = data.keys.surround,
  },
}
