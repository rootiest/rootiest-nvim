--- @module "plugins.debug"
--- This module defines the debug plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Debug                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Neotest Plenary
    'nvim-neotest/neotest-plenary',
  },
  { -- Neotest
    'nvim-neotest/neotest',
    opts = {
      adapters = require('data.deps').neotest.adapters,
    },
    dependencies = require('data.deps').neotest.deps,
  },
  { -- Profiling
    'stevearc/profile.nvim',
  },
}
