--- @module "plugins.coding"
--- This module defines the coding plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Coding                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
  -- { import = "lazyvim.plugins.extras.coding.blink" },
  { -- Mason-lspconfig
    'williamboman/mason-lspconfig.nvim',
    opts = require('data.types').mason_lsp_config.opts,
  },
  { -- luasnip
    import = 'lazyvim.plugins.extras.coding.luasnip',
  },
  { -- nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    opts = require('data.types').treesitter.opts,
  },
  { -- nvim-lspconfig
    'neovim/nvim-lspconfig',
    opts = require('data.types').lspconfig.opts,
  },
  { -- Yanky
    import = 'lazyvim.plugins.extras.coding.yanky',
  },
  { -- Yanky
    'gbprod/yanky.nvim',
    requires = { 'kkharji/sqlite.lua' },
    opts = require('data.types').yanky,
    keys = require('data.keys').yanky,
  },
  { -- Neogen
    import = 'lazyvim.plugins.extras.coding.neogen',
  },
  {
    'folke/lazydev.nvim',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
        -- Load the wezterm types when the `wezterm` module is required
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
  { -- G-code
    'wilriker/gcode.vim',
  },
  { -- Alternate
    'ton/vim-alternate',
    lazy = true,
    ft = require('data.types').alternate,
    keys = require('data.keys').alternate,
  },
  { -- Tailwind
    'luckasRanarison/tailwind-tools.nvim',
    lazy = true,
    dependencies = require('data.deps').needs_treesitter,
    opts = {},
  },
  { -- Substitute
    'gbprod/substitute.nvim',
    lazy = true,
    opts = require('data.types').substitute,
    keys = require('data.keys').substitute,
  },
  { -- Comment
    'numToStr/Comment.nvim',
    opts = require('data.types').comment,
  },
  { -- Fast Action
    'Chaitanyabsprip/fastaction.nvim',
    opts = {},
  },
  { -- Matchup
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  { -- EasyAlign
    'junegunn/vim-easy-align',
    keys = require('data.keys').easyalign,
  },
  { -- Vim-Shebang
    'vitalk/vim-shebang',
    lazy = false,
  },
  {
    'oskarrrrrrr/symbols.nvim',
    cmd = { 'Symbols', 'SymbolsToggle', 'SymbolsOpen', 'SymbolsClose' },
    config = function()
      local r = require('symbols.recipes')
      require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, {
        sidebar = {
          auto_peek = false,
          show_guide_lines = true,
          chars = {
            folded = '',
            unfolded = '',
            guide_vert = '',
            guide_middle_item = '',
            guide_last_item = '',
          },
          preview = {
            show_always = true,
          },
        },
      })
    end,
  },
  { -- Treesitter-endwise
    'RRethy/nvim-treesitter-endwise',
    lazy = false,
    priority = 1000,
  },
  {
    'philosofonusus/ecolog.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp', -- Optional, for autocompletion support
    },
    -- Optionally reccommend adding keybinds (I use them personally)
    keys = function()
      if pcall(require, 'which-key') then
        require('which-key').add({ lhs = '<leader>qe', group = 'Ecolog' })
        return {
          { '<leader>qeg', '<cmd>EcologGoto<cr>', desc = 'Go to env file' },
          { '<leader>qes', '<cmd>EcologSelect<cr>', desc = 'Switch env file' },
          {
            '<leader>qep',
            '<cmd>EcologPeek<cr>',
            desc = 'Ecolog peek variable',
          },
        }
      end
    end,
    lazy = false,
    opts = {
      -- Enables shelter mode for sensitive values
      shelter = {
        configuration = {
          partial_mode = false, -- Disables partial mode see shelter configuration below
          mask_char = '*', -- Character used for masking
        },
        modules = {
          cmp = true, -- Mask values in completion
          peek = false, -- Mask values in peek view
          files = false, -- Mask values in files
          telescope = false, -- Mask values in telescope
        },
      },
      path = vim.fn.getcwd(), -- Path to search for .env files
      preferred_environment = 'development', -- Optional: prioritize specific env files
    },
  },
}
