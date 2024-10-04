--- @module "plugins.cmp"
--- This module defines the cmp plugin spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                     Auto Completion                     │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")
local perf = vim.g.cmp_performance_enabled or false
--- Function to return the cmp provider
---@param performance? boolean Whether to use the experimental cmp performance fork
---@return table provider The cmp provider spec
local function cmp_provider(performance)
  if performance then
    return {
      url = "yioneko/nvim-cmp",
      -- Experiemental cmp performance fork
      dev = true,
      branch = "perf-up",
      build = "git clone -b perf-up https://github.com/yioneko/nvim-cmp.git ~/projects/nvim-cmp/",
    }
  end
  return {
    -- Classic cmp
    url = "hrsh7th/nvim-cmp",
    dev = false,
  }
end
local cmp_repo = cmp_provider(perf)
return { -- cmp
  url = cmp_repo.url,
  build = cmp_repo.build,
  branch = cmp_repo.branch,
  dev = cmp_repo.dev,
  event = "VeryLazy",
  dependencies = data.deps.cmp,
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.event:on("menu_opened", function()
      if data.cond.neocodeium() == true then
        require("neocodeium").clear()
      end
    end)
    cmp.event:on("menu_closed", function()
      if data.cond.neocodeium() == true then
        require("neocodeium.commands").enable()
        require("neocodeium").cycle_or_complete()
      end
    end)
    local border_opts = {
      border = vim.g.completion_borders or "rounded",
    }
    local window_opts = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    }
    luasnip.config.setup({})
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
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      window = vim.g.completion_borders == "rounded" and window_opts or {},
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
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- cmp.confirm({ select = true })
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
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
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
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
        { name = "nerd", priority = 9997 },
        { name = "gitmoji", priority = 9998 },
        { name = "emoji", priority = 9999 },
        { name = "math", priority = 9999 },
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        expandable_indicator = true,
        format = function(entry, item)
          local custom_menu_icon = {
            calc = "󰃬 Calculator",
            math = " Math",
            nerd = " Glyphs",
            gitmoji = " Gitmoji",
            emoji = "󰞅 Emoji",
            conventionalcommits = " Commit Message",
            path = " Path",
            buffer = "󰓩 Buffer",
            dotenv = " Dotenv",
            cmp_yanky = " History",
          }
          local color_item =
            require("nvim-highlight-colors").format(entry, { kind = item.kind })
          item = require("lspkind").cmp_format({
            require("tailwind-tools.cmp").lspkind_format,
          })(entry, item)
          if color_item.abbr_hl_group then
            item.kind_hl_group = color_item.abbr_hl_group
            item.kind = color_item.abbr
          end
          -- if entry.source.name is in the custom_menu_icon table, match its icon
          if custom_menu_icon[entry.source.name] then
            item.kind = custom_menu_icon[entry.source.name]
          end
          return item
        end,
      },
    })
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }, { name = "cmp-cmdline-history" }, {
        name = "cmp-cmdline-prompt",
      }),
    })
    -- Additional setup for cmdline filetype
    cmp.setup.filetype("cmdline", {
      sources = {
        { name = "cmdline" }, -- Ensure 'cmdline' source is available
        { name = "path" },
        { name = "cmp-cmdline-history" },
        { name = "cmp-cmdline-prompt" },
      },
    })
    -- Input filetype
    cmp.setup.filetype("input", {
      sources = {},
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
}
