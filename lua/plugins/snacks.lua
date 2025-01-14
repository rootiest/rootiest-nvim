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

local nostatuscolumn = {
  'folke/snacks.nvim',
  opts = {
    statuscolumn = {
      enabled = false,
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

return P
