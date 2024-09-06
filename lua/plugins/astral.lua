--- @module "plugins.astral"
--- This module defines the astral plugin spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                      Astral Plugin                      │
--          ╰─────────────────────────────────────────────────────────╯
return { -- Astral
  "rootiest/astral.nvim",
  version = "*", -- Pin to GitHub releases
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
  dev = true, -- Use local codebase
}
