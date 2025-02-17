--- @module "plugins.themes"
--- This module defines the themes plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Themes                          │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Catppuccin
    'catppuccin/nvim',
    lazy = false, -- Override
    priority = 1000,
    name = 'catppuccin',
    opts = require('data.types').catppuccin,
  },
  --  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Alternate Themes ━━━━━━━━━━━━━━━━━━━━━━━
  -- { -- Tokyonight
  --   'folke/tokyonight.nvim',
  --   lazy = true, -- Override
  --   name = 'tokyonight',
  --   opts = require('data.types').tokyonight.opts,
  -- },
  -- { -- Monoglow
  --   'wnkz/monoglow.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  -- {
  --   'aileot/ex-colors.nvim',
  --   lazy = true,
  --   cmd = 'ExColors',
  --   opts = {
  --     colors_dir = vim.fn.stdpath('config') .. '/colors',
  --   },
  -- },
  -- { -- Ayu
  --   'Shatur/neovim-ayu',
  --   lazy = true,
  --   name = 'ayu',
  -- },
  -- { -- Dracula
  --   'Mofiqul/dracula.nvim',
  --   lazy = true,
  --   name = 'dracula',
  -- },
  -- { -- Eldritch
  --   'eldritch-theme/eldritch.nvim',
  --   lazy = true,
  --   name = 'eldritch',
  -- },
  -- { -- Flow
  --   '0xstepit/flow.nvim',
  --   lazy = true,
  --   name = 'flow',
  -- },
  -- { -- Github-theme
  --   'projekt0n/github-nvim-theme',
  --   lazy = true,
  --   name = 'github-nvim-theme',
  -- },
  -- { -- Gruvbox
  --   'ellisonleao/gruvbox.nvim',
  --   lazy = true,
  --   name = 'gruvbox',
  -- },
  -- { -- Kanagawa
  --   'rebelot/kanagawa.nvim',
  --   lazy = true,
  --   name = 'kanagawa',
  -- },
  -- { -- Monochrome
  --   'kdheepak/monochrome.nvim',
  --   lazy = true,
  --   name = 'monochrome',
  -- },
  -- { -- NeoFusion
  --   'diegoulloao/neofusion.nvim',
  --   lazy = true,
  --   name = 'neofusion',
  -- },
  -- { -- Nord
  --   'shaunsingh/nord.nvim',
  --   lazy = true,
  --   name = 'nord',
  -- },
  -- { -- One Dark Pro
  --   'olimorris/onedarkpro.nvim',
  --   lazy = true,
  --   name = 'onedarkpro',
  -- },
  -- { -- Oxocarbon
  --   'nyoom-engineering/oxocarbon.nvim',
  --   lazy = true,
  --   name = 'oxocarbon',
  -- },
  -- { -- Paper
  --   'https://gitlab.com/yorickpeterse/vim-paper.git',
  --   lazy = true,
  --   name = 'vim-paper',
  -- },
  -- { -- Rose-Pine
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   lazy = true,
  -- },
  -- { -- Umbra
  --   'LZDQ/umbra.nvim',
  --   lazy = true,
  --   name = 'umbra',
  -- },
  -- { -- Vim-Dim (ANSI16 colors)
  --   'jeffkreeftmeijer/vim-dim',
  --   lazy = true,
  --   name = 'dim',
  -- },
  -- { -- Vim-noctua (ANSI16 colors)
  --   'noahfrederick/vim-noctu',
  --   lazy = true,
  --   name = 'noctu',
  -- },
  -- { -- Zenbones
  --   'zenbones-theme/zenbones.nvim',
  --   name = 'zenbones',
  --   lazy = true,
  --   dependencies = require('data.deps').zenbones,
  -- },
  --  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ UTILITIES ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  { -- Auto Dark Mode
    'f-person/auto-dark-mode.nvim',
    lazy = true,
    opts = require('data.types').auto_dark_mode,
    cond = require('data.cond').auto_dark_mode,
  },
}
