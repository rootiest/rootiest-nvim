--          ╭─────────────────────────────────────────────────────────╮
--          │                        AI Tools                         │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  {
    -- Neocodeium
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
      manual = false,
      silent = true,
      debounce = false,
    },
    keys = data.keys.neocodeium,
  },
  { -- Copilot
    import = "lazyvim.plugins.extras.coding.copilot",
    cond = function()
      return vim.g.aitool == "copilot"
    end,
  },
  { -- Tabnine
    import = "lazyvim.plugins.extras.coding.tabnine",
    cond = function()
      return vim.g.aitool == "tabnine"
    end,
  },
  { -- Minuet-AI
    "milanglacier/minuet-ai.nvim",
    dependencies = data.deps.minuet,
    config = function()
      require("minuet").setup({ provider = "openai" })
    end,
    cond = function()
      return vim.g.aitool == "minuet"
    end,
  },
}
