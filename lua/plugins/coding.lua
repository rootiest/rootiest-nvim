-- -----------------------------------------------------------------------------
-- --------------------------------- CODING ------------------------------------
-- -----------------------------------------------------------------------------

return {
  {
    import = "lazyvim.plugins.extras.coding.codeium",
    cond = function()
      if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.aitool") == 1 then
        if
          vim.fn.readfile(vim.fn.stdpath("config") .. "/.aitool")[1]
          == "codeium"
        then
          return true
        end
      end
    end,
  },
  {
    import = "lazyvim.plugins.extras.coding.copilot",
    cond = function()
      if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.aitool") == 1 then
        if
          vim.fn.readfile(vim.fn.stdpath("config") .. "/.aitool")[1]
          == "copilot"
        then
          return true
        end
      end
    end,
  },
  {
    import = "lazyvim.plugins.extras.coding.tabnine",
    cond = function()
      if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.aitool") == 1 then
        if
          vim.fn.readfile(vim.fn.stdpath("config") .. "/.aitool")[1]
          == "tabnine"
        then
          return true
        end
      end
    end,
  },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.vscode" },
  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup()
    end,
  },
  { -- Emoji completion
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
    dependencies = { "hrsh7th/cmp-emoji" },
  },
  { -- Supertab completion
    -- Use <tab> for completion and snippets
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    opts = {
      yank_substituted_text = false,
      preserve_cursor_position = true,
      highlight_substituted_text = {
        enabled = false,
      },
    },
  },
  {
    "vim-scripts/AnsiEsc.vim",
    lazy = true,
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
