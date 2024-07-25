-- -----------------------------------------------------------------------------
-- --------------------------------- CODING ------------------------------------
-- -----------------------------------------------------------------------------
local rootiest = require("rootiest")

return {
  { -- Codeium
    import = "lazyvim.plugins.extras.coding.codeium",
    cond = function()
      return rootiest.using_aitool("codeium")
    end,
  },
  { -- Copilot
    import = "lazyvim.plugins.extras.coding.copilot",
    cond = function()
      return rootiest.using_aitool("copilot")
    end,
  },
  { -- Tabnine
    import = "lazyvim.plugins.extras.coding.tabnine",
    cond = function()
      return rootiest.using_aitool("tabnine")
    end,
  },
  { -- Minuet-AI
    "milanglacier/minuet-ai.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" }, { "hrsh7th/nvim-cmp" } },
    config = function()
      require("minuet").setup({ provider = "openai" })
    end,
    cond = function()
      return rootiest.using_aitool("minuet")
    end,
  },
  { -- Yanky
    import = "lazyvim.plugins.extras.coding.yanky",
  },
  { -- Mini Surround
    import = "lazyvim.plugins.extras.coding.mini-surround",
  },
  { -- VSCode
    import = "lazyvim.plugins.extras.vscode",
  },
  { -- Mini Align
    "echasnovski/mini.align",
    event = "InsertEnter",
    config = function()
      require("mini.align").setup()
    end,
  },
  { -- Alternate
    "ton/vim-alternate",
    ft = { "cpp", "h", "hpp", "c" },
  },
  { -- Completion
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, { name = "cmp_yanky" })
      table.insert(opts.sources, { name = "dotenv" })
      table.insert(opts.sources, { name = "calc" })
      table.insert(opts.sources, { name = "conventionalcommits" })
      table.insert(opts.sources, { name = "gitmoji" })
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
        },
      })
    end,
    dependencies = {
      "hrsh7th/cmp-emoji",
      {
        "chrisgrieser/cmp_yanky",
        option = {
          onlyCurrentFiletype = false,
        },
      },
      "SergioRibera/cmp-dotenv",
      "hrsh7th/cmp-calc",
      "davidsierradz/cmp-conventionalcommits",
      "Dynge/gitmoji.nvim",
    },
  },
  { -- Colorizer
    "norcalli/nvim-colorizer.lua",
    event = "InsertEnter",
    config = function()
      require("colorizer").setup()
    end,
  },
  { -- Substitute
    "gbprod/substitute.nvim",
    event = "InsertEnter",
    opts = {
      yank_substituted_text = false,
      preserve_cursor_position = true,
    },
  },
}
