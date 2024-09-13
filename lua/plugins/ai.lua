---@module "plugins.ai"
--- This module defines the AI plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        AI Tools                         │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- Neocodeium
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = data.types.neocodeium.opts,
    keys = data.keys.neocodeium,
    enabled = data.cond.neocodeium,
  },
  { -- Codeium
    import = "lazyvim.plugins.extras.coding.codeium",
    cond = data.cond.codeium,
  },
  { -- Copilot
    import = "lazyvim.plugins.extras.coding.copilot",
    cond = data.cond.copilot,
  },
  { -- Tabnine
    import = "lazyvim.plugins.extras.coding.tabnine",
    cond = data.cond.tabnine,
  },
  { -- Minuet-AI
    "milanglacier/minuet-ai.nvim",
    dependencies = data.deps.minuet,
    opts = { provider = "openai" },
    enabled = data.cond.minuet,
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  {
    "robitx/gp.nvim",
    opts = {},
  },
}
