---@module "plugins.ai"
--- This module defines the AI plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        AI Tools                         │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Neocodeium
    'monkoose/neocodeium',
    event = 'VeryLazy',
    opts = require('data.types').neocodeium.opts,
    keys = require('data.keys').neocodeium,
    cond = require('data.cond').neocodeium,
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  { -- Minuet-AI
    'milanglacier/minuet-ai.nvim',
    dependencies = require('data.deps').minuet,
    opts = { provider = 'openai' },
    cond = require('data.cond').minuet,
  },
  { -- ChatGPT
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    cond = require('data.cond').chatgpt,
    keys = require('data.keys').chatgpt.func,
    opts = require('data.types').chatgpt,
    dependencies = require('data.deps').chatgpt,
  },
  { -- GP
    'robitx/gp.nvim',
    cond = require('data.cond').gp,
    lazy = false,
    opts = require('data.types').gp,
    keys = require('data.keys').gp.func,
  },
  { -- Code-Companion
    'olimorris/codecompanion.nvim',
    dependencies = require('data.deps').codecompanion,
    opts = require('data.types').codecompanion.opts,
    cond = require('data.cond').codecompanion,
    cmd = require('data.cmd').codecompanion,
  },
  { -- Codeium
    'Exafunction/codeium.vim',
    cond = require('data.cond').codeium,
    lazy = true,
    opts = require('data.types').codeium,
    keys = require('data.keys').codeium,
    dependencies = require('data.deps').codeium,
  },
  { -- Avante
    'yetone/avante.nvim',
    cond = require('data.cond').avante,
    lazy = true,
    opts = require('data.types').avante,
    build = 'make',
    dependencies = require('data.deps').avante,
    keys = function()
      -- Add keymaps for Avante group
      for _, item in ipairs(require('data.keys').group.avante) do
        require('data.func').add_keymap(item)
      end
    end,
    cmd = 'Avante',
  },
}
