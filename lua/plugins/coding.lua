-- -----------------------------------------------------------------------------
-- --------------------------------- CODING ------------------------------------
-- -----------------------------------------------------------------------------

return {
  { -- Mason-lspconfig
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },
  { -- Codeium
    import = "lazyvim.plugins.extras.coding.codeium",
    opts = {
      enable_chat = true,
    },
    cond = function()
      return vim.g.aitool == "codeium"
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
    lazy = true,
    ft = { "cpp", "h", "hpp", "c" },
    keys = {
      { -- Toggle Alternate
        "<leader>a",
        "<cmd>Alternate<cr>",
        desc = "Toggle Alternate",
      },
    },
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
    event = "BufEnter",
    config = function()
      require("colorizer").setup()
    end,
  },
  { -- Substitute
    "gbprod/substitute.nvim",
    lazy = true,
    opts = {
      yank_substituted_text = false,
      preserve_cursor_position = true,
    },
    keys = {
      { -- Substitute operator in normal mode
        "x",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute operator",
      },
      { -- Substitute line in normal mode
        "xx",
        function()
          require("substitute").line()
        end,
        desc = "Substitute line",
      },
      { -- Substitute end of line in normal mode
        "X",
        function()
          require("substitute").eol()
        end,
        desc = "Substitute end of line",
      },
      { -- Substitute visual selection in visual mode
        "x",
        function()
          require("substitute").visual()
        end,
        desc = "Substitute visual selection",
        mode = "x",
      },
      {
        "<leader>r",
        function()
          require("substitute").visual()
        end,
        desc = "Substitute",
        mode = "x",
      },
    },
  },
  { -- mini.splitjoin
    "echasnovski/mini.splitjoin",
    event = "InsertEnter",
    opts = {
      mappings = {
        toggle = "gJ",
      },
    },
  },
}
