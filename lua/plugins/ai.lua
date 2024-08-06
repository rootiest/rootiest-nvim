--          ╭─────────────────────────────────────────────────────────╮
--          │                        AI Tools                         │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- Neocodeium
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
      manual = false,
      silent = true,
      debounce = false,
    },
    init = function()
      vim.keymap.set("i", "<c-y>", function()
        require("neocodeium").accept()
      end)
      vim.keymap.set("i", "<c-w>", function()
        require("neocodeium").accept_word()
      end)
      vim.keymap.set("i", "<c-l>", function()
        require("neocodeium").accept_line()
      end)
      vim.keymap.set("i", "<c-p>", function()
        require("neocodeium").cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<c-n>", function()
        require("neocodeium").cycle_or_complete()
      end)
    end,
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
    dependencies = { { "nvim-lua/plenary.nvim" }, { "hrsh7th/nvim-cmp" } },
    config = function()
      require("minuet").setup({ provider = "openai" })
    end,
    cond = function()
      return vim.g.aitool == "minuet"
    end,
  },
}
