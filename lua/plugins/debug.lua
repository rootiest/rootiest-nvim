--- @module "plugins.debug"
--- This module defines the debug plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Debug                          │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- DAP Core
    import = "lazyvim.plugins.extras.dap.core",
  },
  { -- DAP Neovim Lua Adapter
    import = "lazyvim.plugins.extras.dap.nlua",
  },
  { -- NeoTest
    import = "lazyvim.plugins.extras.test.core",
  },
  { -- Neotest Plenary
    "nvim-neotest/neotest-plenary",
  },
  { -- Neotest
    "nvim-neotest/neotest",
    opts = {
      adapters = data.deps.neotest.adapters,
    },
    dependencies = data.deps.neotest.deps,
  },
  { -- Profiling
    "stevearc/profile.nvim",
  },
}
