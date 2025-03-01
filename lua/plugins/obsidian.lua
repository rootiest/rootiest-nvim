return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    'BufReadPre ' .. vim.fn.expand('~' .. '/vaults/rootiest/*.md'),
    'BufNewFile ' .. vim.fn.expand('~' .. '/vaults/rootiest/*.md'),
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'rootiest',
        path = '~/vaults/rootiest',
      },
    },
    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
      substitutions = {
        yesterday = function()
          return os.date('%Y-%m-%d', os.time() - 86400)
        end,
      },
    },
    ui = {
      enable = false,
    },
  },
}
