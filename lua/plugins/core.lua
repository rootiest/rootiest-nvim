-- -----------------------------------------------------------------------------
-- ---------------------------------- CORE -------------------------------------
-- -----------------------------------------------------------------------------

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
  { -- Edgy
    import = "lazyvim.plugins.extras.ui.edgy",
  },
  { -- Mini-animate
    import = "lazyvim.plugins.extras.ui.mini-animate",
  },
  {
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
