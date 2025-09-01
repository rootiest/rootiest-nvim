---@module "data.deps"
--- This module aggregates various dependencies used throughout the configuration.
--- It provides a centralized way to access dependencies.
--          ╭─────────────────────────────────────────────────────────╮
--          │                      DEPENDENCIES                       │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

M.avante = {
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',
}

M.chatgpt = {
  'MunifTanjim/nui.nvim',
  'nvim-lua/plenary.nvim',
  'folke/trouble.nvim',
  'nvim-telescope/telescope.nvim',
}

M.codecompanion = {
  'nvim-lua/plenary.nvim',
  'nvim-treesitter/nvim-treesitter',
}

--- nvim-cmp dependencies
---@return table The nvim-cmp dependencies
M.cmp = {
  {
    'L3MON4D3/LuaSnip',
    --- Function to build the dependencies
    ---@return string|nil The command to build the dependencies
    build = (function()
      if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
        return
      end
      return 'make install_jsregexp'
    end)(),
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
  },
  {
    'petertriho/cmp-git',
    opts = {},
    --- Function to configure the cmp-git dependency
    ---@return table|nil The cmp-git config
    config = function()
      local cmp = require('cmp')
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git', priority = 50 },
          { name = 'path', priority = 40 },
        }, {
          { name = 'buffer', priority = 50 },
        }),
      })
    end,
  },
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'onsails/lspkind.nvim',
  'hrsh7th/cmp-cmdline',
  'dmitmel/cmp-cmdline-history',
  'teramako/cmp-cmdline-prompt.nvim',
  'mtoohey31/cmp-fish',
  'vim-dadbod-completion',
  {
    'chrisgrieser/cmp_yanky',
    option = {
      onlyCurrentFiletype = false,
    },
  },
  'SergioRibera/cmp-dotenv',
  'hrsh7th/cmp-calc',
  'davidsierradz/cmp-conventionalcommits',
}

--- Gx plugin dependencies
M.gx = {
  'nvim-lua/plenary.nvim',
}

--- Hardtime plugin dependencies
M.hardtime = {
  'MunifTanjim/nui.nvim',
  'nvim-lua/plenary.nvim',
}

--- LazyDev plugin dependencies
M.lazydev = {
  'gonstoll/wezterm-types',
}

--- LazyGit plugin dependencies
M.lazygit = {
  'nvim-lua/plenary.nvim',
}

--- Lualine plugin dependencies
M.lualine = {
  { 'bezhermoso/todos-lualine.nvim' },
  { 'folke/todo-comments.nvim' },
}

--- Minuet plugin dependencies
M.minuet = {
  { 'nvim-lua/plenary.nvim' },
}

--- MusicControls plugin dependencies
M.musiccontrols = {
  'rcarriga/nvim-notify',
}

--- Table for plugins that need Telescope as a dependency
M.needs_telescope = {
  'nvim-telescope/telescope.nvim',
}

--- Table for plugins that need Treesitter as a dependency
M.needs_treesitter = {
  'nvim-treesitter/nvim-treesitter',
}

--- Neotest plugin adapters and dependencies
M.neotest = {
  adapters = {
    'neotest-plenary',
    'neotest-python',
    'neotest-vim-test',
    'neotest-minitest',
    'neotest-bash',
  },
  deps = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'zidhuss/neotest-minitest',
    'rcasia/neotest-bash',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}

--- Recorder plugin dependencies
M.recorder = {
  'rcarriga/nvim-notify',
}

--- nvim-remote plugin dependencies
M.remotenvim = {
  'nvim-lua/plenary.nvim', -- For standard functions
  'MunifTanjim/nui.nvim', -- To build the plugin UI
  'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
}

--- Zenbones plugin dependencies
M.zenbones = {
  'rktjmp/lush.nvim',
}

return M
