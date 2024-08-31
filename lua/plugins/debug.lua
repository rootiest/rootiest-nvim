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
  { "nvim-neotest/neotest-plenary" },
  {
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
