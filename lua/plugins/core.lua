--          ╭─────────────────────────────────────────────────────────╮
--          │                          Core                           │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- LazyVim
    "LazyVim/LazyVim",
    opts = {
      colorscheme = vim.g.my_colorscheme or "catppuccin-mocha",
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
      options = data.types.bufferline,
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
