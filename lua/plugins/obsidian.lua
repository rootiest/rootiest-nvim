return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      'BufReadPre ' .. vim.fn.expand('~' .. '/vaults/Rootiest Notes/*.md'),
      'BufNewFile ' .. vim.fn.expand('~' .. '/vaults/Rootiest Notes/*.md'),
    },
    cmd = 'Obsidian',
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
    },
    opts = {
      completion = {
        nvim_cmp = false,
        blink = true,
        min_chars = 2,
      },
      picker = {
        name = 'snacks.pick',
      },
      workspaces = {
        {
          name = 'Rootiest Notes',
          path = '~/vaults/Rootiest Notes',
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
      -- ui = {
      --   enable = false,
      -- },
    },
  },
  {
    'arakkkkk/kanban.nvim',
    ft = 'markdown',
    opts = {
      markdown = {
        description_folder = './tasks/', -- Path to save the file corresponding to the task.
        list_head = '## ',
      },
    },
  },
  {
    'marcocofano/excalidraw.nvim',
    lazy = false,
  },
}
