--          ╭─────────────────────────────────────────────────────────╮
--          │                     Auto Completion                     │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      {
        "petertriho/cmp-git",
        opts = {},
        config = function()
          local cmp = require("cmp")
          cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
              { name = "git", priority = 50 },
              { name = "path", priority = 40 },
            }, {
              { name = "buffer", priority = 50 },
            }),
          })
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim",
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
    -- :
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local neocodeium = require("neocodeium")
      local commands = require("neocodeium.commands")

      cmp.event:on("menu_opened", function()
        neocodeium.clear()
      end)

      cmp.event:on("menu_closed", function()
        commands.enable()
        neocodeium.cycle_or_complete()
      end)

      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }
      local window_opts = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      }
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        window = vim.g.completion_round_borders_enabled and window_opts or {},
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<Up>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<Down>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<Tab>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "path", priority = 250 },
          { name = "buffer", priority = 250 },
          { name = "cmp_yanky" },
          { name = "dotenv" },
          { name = "calc" },
          { name = "conventionalcommits" },
          { name = "gitmoji" },
          { name = "emoji" },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          expandable_indicator = true,
          format = function(entry, item)
            local color_item = require("nvim-highlight-colors").format(
              entry,
              { kind = item.kind }
            )
            item = require("lspkind").cmp_format({
              require("tailwind-tools.cmp").lspkind_format,
            })(entry, item)
            if color_item.abbr_hl_group then
              item.kind_hl_group = color_item.abbr_hl_group
              item.kind = color_item.abbr
            end
            return item
          end,
        },
      })

      -- Custom filetype configuration
      cmp.setup.filetype("config", {
        sources = vim.tbl_filter(function(source)
          return source.name ~= "emoji" and source.name ~= "gitmoji"
        end, cmp.get_config().sources),
      })

      -- List of filetypes to disable completion
      local disabled_filetypes = data.types.cmp
      for _, filetype in ipairs(disabled_filetypes) do
        cmp.setup.filetype(filetype, {
          sources = {},
        })
      end
    end,
  },
}
