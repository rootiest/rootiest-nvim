--- @module "plugins.astral"
--- This module defines the astral plugin spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                      Astral Plugin                      │
--          ╰─────────────────────────────────────────────────────────╯
return { -- Astral
  "rootiest/astral.nvim",
  version = "*", -- Pin to GitHub releases
  enabled = require("data.func").check_global_var("use_astral", true, true),
  opts = {
    fallback_themes = {
      "catppuccin-macchiato",
      "catppuccin-frappe",
      "tokyonight",
      "kanagawa",
      "monochrome",
      "default",
    },
  },
  dev = vim.g.rootiest_dev or false, -- Use local codebase
}
