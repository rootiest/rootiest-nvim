--- @module "plugins.languages"
--- This module defines the languages plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Languages                        │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- JSON
    import = 'lazyvim.plugins.extras.lang.json',
  },
  { -- Markdown
    import = 'lazyvim.plugins.extras.lang.markdown',
  },
  { -- Toml
    import = 'lazyvim.plugins.extras.lang.toml',
  },
  { -- Git
    import = 'lazyvim.plugins.extras.lang.git',
  },
  { -- Python
    import = 'lazyvim.plugins.extras.lang.python',
  },
  { -- Yaml
    import = 'lazyvim.plugins.extras.lang.yaml',
  },
  { -- clangd
    import = 'lazyvim.plugins.extras.lang.clangd',
  },
  { -- cmake
    import = 'lazyvim.plugins.extras.lang.cmake',
  },
  { -- Docker
    import = 'lazyvim.plugins.extras.lang.docker',
  },
  { -- Java
    import = 'lazyvim.plugins.extras.lang.java',
  },
  { -- Sql
    import = 'lazyvim.plugins.extras.lang.sql',
  },
  { -- Rust
    import = 'lazyvim.plugins.extras.lang.rust',
  },
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
  {
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
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  { -- WezTerm Types
    'gonstoll/wezterm-types',
    dev = true,
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {},
  },
}
