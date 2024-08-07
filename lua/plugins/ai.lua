--          ╭─────────────────────────────────────────────────────────╮
--          │                        AI Tools                         │
--          ╰─────────────────────────────────────────────────────────╯
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
    keys = {
      { -- Accept suggestion
        "<c-y>",
        function()
          require("neocodeium").accept()
        end,
        desc = "Accept suggestion",
        mode = "i",
      },
      { -- Accept word
        "<c-w>",
        function()
          require("neocodeium").accept_word()
        end,
        desc = "Accept word",
        mode = "i",
      },
      { -- Accept line
        "<c-l>",
        function()
          require("neocodeium").accept_line()
        end,
        desc = "Accept line",
        mode = "i",
      },
      { -- Cycle or complete (previous)
        "<c-p>",
        function()
          require("neocodeium").cycle_or_complete(-1)
        end,
        desc = "Cycle or complete (previous)",
        mode = "i",
      },
      { -- Cycle or complete (next)
        "<c-n>",
        function()
          require("neocodeium").cycle_or_complete()
        end,
        desc = "Cycle or complete (next)",
        mode = "i",
      },
    },
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
