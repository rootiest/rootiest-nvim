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
    cond = data.cond.neocodeium,
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
    cond = data.cond.minuet,
  },
  { -- ChatGPT
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    cond = data.cond.chatgpt,
    keys = data.keys.chatgpt.func,
    opts = data.types.chatgpt,
    dependencies = data.deps.chatgpt,
  },
  { -- GP
    "robitx/gp.nvim",
    cond = data.cond.gp,
    lazy = false,
    opts = data.types.gp,
    keys = data.keys.gp.func,
  },
  { -- Avante
    "yetone/avante.nvim",
    cond = data.cond.avante,
    event = "VeryLazy",
    lazy = false,
    opts = data.types.avante,
    build = "make",
    dependencies = data.deps.avante,
    keys = function()
      -- Add keymaps for Avante group
      for _, item in ipairs(data.keys.group.avante) do
        data.func.add_keymap(item)
      end
    end,
  },
}
