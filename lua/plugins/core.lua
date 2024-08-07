--          ╭─────────────────────────────────────────────────────────╮
--          │                          Core                           │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- LazyVim
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
  { -- Mini-animate
    import = "lazyvim.plugins.extras.ui.mini-animate",
  },
  { -- Bufferline
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant",
      },
    },
  },
  { -- Which-Key
    "folke/which-key.nvim",
    lazy = true,
    opts = {
      preset = "modern",
      win = {
        wo = {
          winblend = 10,
        },
      },
    },
  },
}
