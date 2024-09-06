--- @module "plugins.core"
--- This module defines the core plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Core                           │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  require("config.rocks").plugin_spec,
  { -- LazyVim
    "LazyVim/LazyVim",
    priority = 900,
    opts = data.types.lazyvim.opts,
  },
  { -- Bufferline
    "akinsho/bufferline.nvim",
    enabled = data.types.bufferline.enabled,
    opts = data.types.bufferline.opts,
  },
  { -- Which-Key
    "folke/which-key.nvim",
    lazy = true,
    opts = data.types.whichkey.opts,
  },
}
