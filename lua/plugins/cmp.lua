--- @module "plugins.cmp"
--- This module defines the cmp plugin spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                     Auto Completion                     │
--          ╰─────────────────────────────────────────────────────────╯

local perf = vim.g.cmp_performance_enabled or false
--- Function to return the cmp provider
---@param performance? boolean Whether to use the experimental cmp performance fork
---@return table provider The cmp provider spec
local function cmp_provider(performance)
  if performance then
    return {
      -- Experiemental cmp performance fork
      url = 'https://github.com/iguanacucumber/magazine.nvim',
    }
  else
    return {
      -- Classic cmp
      url = 'hrsh7th/nvim-cmp',
      dev = false,
    }
  end
end

local cmp_repo = cmp_provider(perf)

if vim.g.useblinkcmp then
  if vim.g.cmp_performance_enabled then
    vim.g.lazyvim_blink_main = true
  end

  return {
    {
      'saghen/blink.cmp',
      dependencies = {
        'mikavilpas/blink-ripgrep.nvim',
      },
      opts = {
        enabled = function()
          return not vim.tbl_contains({ 'minifiles' }, vim.bo.filetype)
            and vim.bo.buftype ~= 'prompt'
            and vim.b.completion ~= false
        end,
        completion = {
          menu = {
            auto_show = function(ctx)
              if vim.g.cmp_auto_show ~= false then
                return ctx.mode ~= 'cmdline'
                  or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
              end
              return false
            end,
          },
          list = {
            selection = {
              preselect = function(ctx)
                return ctx.mode ~= 'cmdline'
                  and not require('blink.cmp').snippet_active({ direction = 1 })
              end,
              auto_insert = true,
            },
          },
        },
        snippets = {
          preset = 'luasnip',
        },
        keymap = {
          preset = 'enter',
          ['<C-y>'] = { 'select_and_accept' },
          ['<CR>'] = { 'fallback' },
        },
        cmdline = {
          enabled = true,
          completion = {
            menu = { auto_show = true },
            ghost_text = { enabled = true },
          },
          sources = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == '/' or type == '?' then
              return { 'buffer' }
            end
            -- Commands
            if type == ':' or type == '@' then
              return { 'cmdline' }
            end
            return {}
          end,
          keymap = {
            preset = 'enter',
            ['<C-y>'] = { 'select_and_accept' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<Enter>'] = { 'accept_and_enter', 'fallback' },
          },
        },
        sources = {
          providers = {
            cmdline = {
              min_keyword_length = function(ctx)
                -- when typing a command, only show when the keyword is 2 characters or longer
                if
                  ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil
                then
                  return 2
                end
                return 0
              end,
            },
            ripgrep = {
              module = 'blink-ripgrep',
              name = 'Ripgrep',
              opts = {
                search_casing = '--smart-case',
              },
              transform_items = function(_, items)
                for _, item in ipairs(items) do
                  -- example: append a description to easily distinguish rg results
                  item.labelDetails = {
                    description = '󰡦 ',
                  }
                end
                return items
              end,
            },
          },
          default = {
            'lsp',
            'path',
            'snippets',
            'buffer',
            'ripgrep',
          },
        },
      },
      keys = require('data.keys').blink,
    },
    { -- Blink compat
      'saghen/blink.compat',
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = {},
      version = not vim.g.lazyvim_blink_main and '*',
    },
    { -- Catppuccin integration
      'catppuccin',
      optional = true,
      opts = {
        integrations = { blink_cmp = true },
      },
    },
  }
end

-- Else use nvim-cmp
return {
  { -- cmp
    url = cmp_repo.url,
    build = cmp_repo.build,
    branch = cmp_repo.branch,
    dev = cmp_repo.dev,
    enabled = not vim.g.useblinkcmp,
    event = 'VeryLazy',
    dependencies = require('data.deps').cmp,
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.event:on('menu_opened', function()
        if require('data.cond').neocodeium() == true then
          require('neocodeium').clear()
        end
      end)
      cmp.event:on('menu_closed', function()
        if require('data.cond').neocodeium() == true then
          require('neocodeium.commands').enable()
          require('neocodeium').cycle_or_complete()
        end
      end)
      local border_opts = {
        border = vim.g.completion_borders or 'rounded',
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
              :match('%s')
            == nil
      end
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        window = vim.g.completion_borders == 'rounded' and window_opts or {},
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<Up>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ['<Down>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- If the completion popup is visible, select the next item
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              -- If a snippet can be expanded or jump to the next location, do so
              luasnip.expand_or_jump()
            elseif vim.snippet.active({ direction = 1 }) then
              -- If a snippet is active, jump to the next location
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            elseif has_words_before() then
              -- If there are words before the cursor, complete them
              cmp.complete()
            else
              -- Otherwise, fallback to the default behavior of the Tab key
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
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
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'path', priority = 250 },
          { name = 'buffer', priority = 250 },
          { name = 'cmp_yanky' },
          { name = 'dotenv' },
          { name = 'calc' },
          { name = 'conventionalcommits' },
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          expandable_indicator = true,
          format = function(entry, item)
            local custom_menu_icon = {
              calc = '󰃬 Calculator',
              math = ' Math',
              nerd = ' Glyphs',
              gitmoji = ' Gitmoji',
              emoji = '󰞅 Emoji',
              conventionalcommits = ' Commit Message',
              path = ' Path',
              buffer = '󰓩 Buffer',
              dotenv = ' Dotenv',
              cmp_yanky = '󰅍 Yanked',
            }
            local color_item = require('nvim-highlight-colors').format(
              entry,
              { kind = item.kind }
            )
            item = require('lspkind').cmp_format({
              require('tailwind-tools.cmp').lspkind_format,
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
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }, { name = 'cmp-cmdline-history' }, {
          name = 'cmp-cmdline-prompt',
        }),
      })
      -- Additional setup for cmdline filetype
      cmp.setup.filetype('cmdline', {
        sources = {
          { name = 'cmdline' }, -- Ensure 'cmdline' source is available
          { name = 'path' },
          { name = 'cmp-cmdline-history' },
          { name = 'cmp-cmdline-prompt' },
        },
      })
      -- Input filetype
      cmp.setup.filetype('input', {
        sources = {},
      })
      -- Custom filetype configuration
      cmp.setup.filetype('config', {
        sources = vim.tbl_filter(function(source)
          return source.name ~= 'emoji' and source.name ~= 'gitmoji'
        end, cmp.get_config().sources),
      })
      -- List of filetypes to disable completion
      local disabled_filetypes = require('data.types').cmp
      for _, filetype in ipairs(disabled_filetypes) do
        cmp.setup.filetype(filetype, {
          sources = {},
        })
      end
    end,
  },
}
