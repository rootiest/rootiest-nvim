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
  table.insert(P, nostatuscolumn)
end

return P
