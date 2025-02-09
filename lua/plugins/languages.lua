--- @module "plugins.languages"
--- This module defines the languages plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Languages                        │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Jinja
    'armyers/Vim-Jinja2-Syntax',
  },
  { -- Render-markdown
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = false,
    opts = {
      heading = {
        -- Determins if a border is added above and below headings
        border = true,
        above = '▂',
        -- Used below heading for border
        below = '🮂',
      },
      file_types = { 'markdown', 'Avante' },
    },
    ft = { 'markdown', 'Avante' },
  },
  { -- MarkView
    'OXY2DEV/markview.nvim',
    ft = { 'markdown', 'Avante' },
    opts = function()
      local presets = require('markview.presets')
      return {
        checkboxes = presets.checkboxes.nerd,
        headings = presets.headings.simple,
      }
    end,
  },
  { -- Markdown Preview
    'iamcco/markdown-preview.nvim',
    cmd = require('data.cmd').markdown_preview,
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  { -- WezTerm Types
    'gonstoll/wezterm-types',
    dev = true,
  },
  -- { -- Flutter-tools
  --   'akinsho/flutter-tools.nvim',
  --   lazy = false,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'stevearc/dressing.nvim', -- optional for vim.ui.select
  --   },
  --   opts = {},
  -- },
}
