--          ╭─────────────────────────────────────────────────────────╮
--          │                          Debug                          │
--          ╰─────────────────────────────────────────────────────────╯
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
      adapters = {
        "neotest-plenary",
        "neotest-python",
        "neotest-vim-test",
        "neotest-minitest",
        "neotest-bash",
      },
    },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "zidhuss/neotest-minitest",
      "rcasia/neotest-bash",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { -- Profiling
    "stevearc/profile.nvim",
  },
}
