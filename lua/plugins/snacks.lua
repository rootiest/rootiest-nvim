--          ╭─────────────────────────────────────────────────────────╮
--          │                         Snacks                          │
--          ╰─────────────────────────────────────────────────────────╯

local P = {}

-- Snacks statuscolumn
local statuscolumn = {
  'folke/snacks.nvim',
  opts = {
    statuscolumn = {
      enabled = true,
      left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
      right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = true, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      refresh = 50, -- refresh at most every 50ms
    },
  },
}

-- No StatusColumn
local nostatuscolumn = {
  'folke/snacks.nvim',
  opts = {
    statuscolumn = {
      enabled = false,
    },
  },
}

-- Snacks IndentScope
local indentscope = {
  'folke/snacks.nvim',
  opts = {
    indent = {
      indent = {
        enabled = false,
        only_scope = true,
      },
      animate = {
        enabled = vim.fn.has('nvim-0.10') == 1,
        style = 'up_down',
      },
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = '│',
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = true,
        -- only show chunk scopes in the current window
        only_current = false,
        priority = 200,
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for chunk scopes
        char = {
          corner_top = '╭',
          corner_bottom = '',
          horizontal = '─',
          vertical = '│',
          arrow = '',
        },
      },
    },
  },
}

-- Snacks Profiler
local profiler = {
  {
    'folke/snacks.nvim',
    opts = function()
      -- Toggle the profiler
      Snacks.toggle.profiler():map('<leader>qp')
      -- Toggle the profiler highlights
      Snacks.toggle.profiler_highlights():map('<leader>qh')
    end,
    keys = {
      {
        '<leader>qb',
        function()
          Snacks.profiler.scratch()
        end,
        desc = 'Profiler Scratch Bufer',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    cond = require('data.cond').lualine,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, Snacks.profiler.status())
    end,
  },
}

---@class PickerList
---@field row2idx fun(self: PickerList, row: integer): integer
---@field _move fun(self: PickerList, index: integer, a: boolean, b: boolean): nil

---@class SnacksPicker
---@field list PickerList

--- flash_on_picker
---Use the flash.nvim plugin in Snacks picker
---@param picker SnacksPicker The picker instance to interact with.
local flash_on_picker = function(picker)
  require('flash').jump({
    pattern = '^',
    label = { after = { 0, 0 } },
    search = {
      mode = 'search',
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
            ~= 'snacks_picker_list'
        end,
      },
    },
    action = function(match)
      local idx = picker.list:row2idx(match.pos[1])
      picker.list:_move(idx, true, true)
      -- you can also add auto confirm here
    end,
  })
end

local vscode_layout = {
  preview = true,
  layout = {
    backdrop = false,
    row = 1,
    width = 0.5,
    min_width = 80,
    height = 0.8,
    border = 'none',
    box = 'vertical',
    {
      win = 'input',
      height = 1,
      border = 'rounded',
      title = '{source} {live} {flags}',
      title_pos = 'center',
    },
    { win = 'list', border = 'hpad' },
    { win = 'preview', title = '{preview}', border = 'rounded' },
  },
}

local picker = {
  {
    'folke/snacks.nvim',
    opts = {
      picker = {
        sources = {
          explorer = {
            jump = { close = true },
            auto_close = true,
            layout = { preset = 'sidebar' },
            -- ignored = true, -- Show .ignore/.gitignore files
            -- hidden = true, -- Show hidden files
          },
        },
        layouts = {
          -- default = vscode_layout,
          vscode = vscode_layout,
          ivy = {
            layout = {
              box = 'vertical',
              backdrop = false,
              row = -1,
              width = 0.8,
              height = 0.4,
              border = 'top',
              title = ' {title} {live} {flags}',
              title_pos = 'left',
              { win = 'input', height = 1, border = 'bottom' },
              {
                box = 'horizontal',
                { win = 'list', width = 0.4, border = 'none' },
                {
                  win = 'preview',
                  title = '{preview}',
                  width = 0.6,
                  border = 'left',
                },
              },
            },
          },
          left = { preset = 'sidebar', layout = { position = 'left' } },
          right = { preset = 'sidebar', layout = { position = 'right' } },
          top = { preset = 'ivy', layout = { position = 'top' } },
          bottom = { preset = 'ivy', layout = { position = 'bottom' } },
        },
        actions = {
          flash = flash_on_picker,
        },
        win = {
          input = {
            keys = {
              ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
              ['s'] = { 'flash' },
            },
          },
        },
      },
    },
  },
}

local image = {
  {
    'folke/snacks.nvim',
    opts = {
      image = {
        enabled = true,
      },
    },
  },
}

if
  require('data.func').check_global_var('statuscolumn', 'snacks', 'native')
then
  -- Add Snacks statuscolumn
  table.insert(P, statuscolumn)
else
  -- Use native statuscolumn
  vim.opt.statuscolumn = '%=%{v:relnum?v:relnum:v:lnum} '
  table.insert(P, nostatuscolumn)
end

table.insert(P, indentscope)

table.insert(P, profiler)

table.insert(P, picker)

table.insert(P, image)

return P
