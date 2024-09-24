---@module "plugins.override"
--- This module defines the plugin spec overrides for the Neovim configuration.
--- This is used to prioritize certain plugins over others or to override
--- the default behavior of a core plugin.
---
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Overrides                        │
--          ╰─────────────────────────────────────────────────────────╯

-- Load plugin overrides
return {
  { -- Override build for markdown-preview
    "iamcco/markdown-preview.nvim",
    priority = 1001,
    build = "cd app && yarn install",
  },
  { -- Prioritize dadbod
    "kristijanhusak/vim-dadbod-completion",
    priority = 1001,
    dependencies = "vim-dadbod",
  },
  { -- Prioritize dadbod
    "kristijanhusak/vim-dadbod-ui",
    priority = 1001,
    dependencies = "vim-dadbod",
  },
  { -- Prioritize dadbod
    "tpope/vim-dadbod",
    priority = 1002,
  },
}
