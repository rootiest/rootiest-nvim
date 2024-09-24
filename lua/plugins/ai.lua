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
  { -- ChatGPT
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    enabled = data.cond.chatgpt,
    keys = data.keys.chatgpt.func,
    opts = data.types.chatgpt,
    dependencies = data.deps.chatgpt,
  },
  { -- GP
    "robitx/gp.nvim",
    enabled = data.cond.gp,
    lazy = false,
    opts = data.types.gp,
    keys = data.keys.gp.func,
  },
  { -- Avante
    "yetone/avante.nvim",
    enabled = data.cond.avante,
    event = "VeryLazy",
    lazy = false,
    opts = data.types.avante,
    build = "make",
    dependencies = data.deps.avante,
  },
}
