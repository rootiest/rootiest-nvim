-- -----------------------------------------------------------------------------
-- --------------------------------- CODING ------------------------------------
-- -----------------------------------------------------------------------------

return {
  {
    import = "lazyvim.plugins.extras.coding.codeium",
    cond = function()
      if
        vim.fn.readfile(vim.fn.stdpath("config") .. "/.aitool")[1]
        == "codeium"
      then
        return true
      end
    end,
  },
  {
    import = "lazyvim.plugins.extras.coding.copilot",
    cond = function()
      if
        vim.fn.readfile(vim.fn.stdpath("config") .. "/.aitool")[1]
        == "copilot"
      then
        return true
      end
    end,
  },
  {
    import = "lazyvim.plugins.extras.coding.tabnine",
    cond = function()
      if
        vim.fn.readfile(vim.fn.stdpath("config") .. "/.aitool")[1]
        == "tabnine"
      then
        return true
      end
    end,
  },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.vscode" },
  {
    "echasnovski/mini.align",
    event = "InsertEnter",
    config = function()
      require("mini.align").setup()
    end,
  },
  { -- Emoji completion
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
  {
    "norcalli/nvim-colorizer.lua",
    event = "InsertEnter",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "gbprod/substitute.nvim",
    event = "InsertEnter",
    opts = {
      yank_substituted_text = false,
      preserve_cursor_position = true,
      highlight_substituted_text = {
        enabled = false,
      },
    },
  },
}
