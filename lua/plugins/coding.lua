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
      "chrisgrieser/cmp_yanky",
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
  {
    "shellRaining/hlchunk.nvim",
    event = "BufEnter",
    config = function()
      local cb = function()
        if vim.g.colors_name == "tokyonight" then
          return "#806d9c"
        elseif vim.g.colors_name:find("catppuccin") then
          local catpalette = require("catppuccin.palettes").get_palette()
          return catpalette.green
        elseif vim.g.colors_name == "monochrome" then
          return "#CCCCCC"
        elseif vim.g.colors_name == "gruvbox" then
          return "#a9b665"
        elseif vim.g.colors_name == "dracula" then
          return "#50fa7b"
        elseif vim.g.colors_name == "onedark" then
          return "#98C379"
        elseif vim.g.colors_name == "nightfox" then
          return "#98C379"
        elseif vim.g.colors_name == "nord" then
          return "#81A1C1"
        elseif vim.g.colors_name == "kanagawa" then
          return "#73C8AD"
        elseif vim.g.colors_name == "everforest" then
          return "#8FBCBB"
        elseif vim.g.colors_name == "github_dark" then
          return "#FFFFFF"
        elseif vim.g.colors_name == "github_light" then
          return "#3f3f3f"
        elseif vim.g.colors_name == "neofusion" then
          return "#420ADD"
        else
          return "#7581FF"
        end
      end
      require("hlchunk").setup({
        chunk = {
          style = {
            { fg = cb },
          },
          enable = true,
        },
        indent = {
          enable = function()
            if vim.g.colors_name == "monochrome" then
              return false
            else
              return true
            end
          end,
        },
      })
    end,
  },
  {
    "ton/vim-alternate",
    event = "VeryLazy",
  },
}
