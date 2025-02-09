--- @module "plugins.core"
--- This module defines the core plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Core                           │
--          ╰─────────────────────────────────────────────────────────╯

return {
  -- require("config.rocks").plugin_spec,
  { -- Bufferline
    'akinsho/bufferline.nvim',
    cond = require('data.types').bufferline.enabled,
    opts = require('data.types').bufferline.opts,
  },
  { -- Which-Key
    'folke/which-key.nvim',
    lazy = true,
    opts = require('data.types').whichkey.opts,
  },
}
