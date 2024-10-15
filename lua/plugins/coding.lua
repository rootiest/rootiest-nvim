--- @module "plugins.coding"
--- This module defines the coding plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Coding                          │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- Mason-lspconfig
    "williamboman/mason-lspconfig.nvim",
    opts = data.types.mason_lsp_config.opts,
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
    opts = data.types.yanky,
  },
  { -- VSCode
    import = "lazyvim.plugins.extras.vscode",
  },
  { -- Neogen
    import = "lazyvim.plugins.extras.coding.neogen",
  },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
        -- Load the wezterm types when the `wezterm` module is required
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
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
  { -- Comment
    "numToStr/Comment.nvim",
    opts = data.types.comment,
  },
  { -- Fast Action
    "Chaitanyabsprip/fastaction.nvim",
    opts = {},
  },
}
