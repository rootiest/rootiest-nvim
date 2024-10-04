--- @module "plugins.coding"
--- This module defines the coding plugins spec for the Neovim configuration.
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
  { -- luasnip
    import = "lazyvim.plugins.extras.coding.luasnip",
  },
  { -- nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    opts = data.types.treesitter.opts,
  },
  { -- nvim-lspconfig
    "neovim/nvim-lspconfig",
    opts = data.types.lspconfig.opts,
  },
  { -- Yanky
    import = "lazyvim.plugins.extras.coding.yanky",
  },
  { -- Yanky
    "gbprod/yanky.nvim",
    opts = {
      preserve_cursor_position = {
        enabled = false,
      },
    },
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
  { -- Markdown Preview
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
  },
  { -- Comment
    "numToStr/Comment.nvim",
    opts = {
      opleader = {
        line = "gC",
      },
    },
  },
}
