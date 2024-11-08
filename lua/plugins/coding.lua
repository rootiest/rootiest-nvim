--- @module "plugins.coding"
--- This module defines the coding plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Coding                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Mason-lspconfig
    "williamboman/mason-lspconfig.nvim",
    opts = require("data.types").mason_lsp_config.opts,
  },
  { -- luasnip
    import = "lazyvim.plugins.extras.coding.luasnip",
  },
  { -- nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    opts = require("data.types").treesitter.opts,
  },
  { -- nvim-lspconfig
    "neovim/nvim-lspconfig",
    opts = require("data.types").lspconfig.opts,
  },
  { -- Yanky
    import = "lazyvim.plugins.extras.coding.yanky",
  },
  { -- Yanky
    "gbprod/yanky.nvim",
    requires = { "kkharji/sqlite.lua" },
    opts = require("data.types").yanky,
    keys = require("data.keys").yanky,
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
    ft = require("data.types").alternate,
    keys = require("data.keys").alternate,
  },
  { -- Tailwind
    "luckasRanarison/tailwind-tools.nvim",
    lazy = true,
    dependencies = require("data.deps").needs_treesitter,
    opts = {},
  },
  { -- Substitute
    "gbprod/substitute.nvim",
    lazy = true,
    opts = require("data.types").substitute,
    keys = require("data.keys").substitute,
  },
  { -- Comment
    "numToStr/Comment.nvim",
    opts = require("data.types").comment,
  },
  { -- Fast Action
    "Chaitanyabsprip/fastaction.nvim",
    opts = {},
  },
  { -- Matchup
    "andymass/vim-matchup",
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  { -- EasyAlign
    "junegunn/vim-easy-align",
    keys = require("data.keys").easyalign,
  },
  { -- Vim-Shebang
    "vitalk/vim-shebang",
    lazy = false,
  },
}
