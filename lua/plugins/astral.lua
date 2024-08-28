--          ╭─────────────────────────────────────────────────────────╮
--          │                      Astral Plugin                      │
--          ╰─────────────────────────────────────────────────────────╯
return {
  {
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
    -- dev = true, -- Use local codebase
  },
}
