--- @module "plugins.util"
--- This module defines the utility plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Utilities                        │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Wakatime
    'wakatime/vim-wakatime',
    cond = vim.g.usewakatime,
    lazy = true,
    event = 'LazyFile',
  },
  { -- Link following
    'chrishrb/gx.nvim',
    lazy = true,
    cmd = require('data.cmd').gx,
    keys = require('data.keys').gx,
    init = require('data.types').gx.init,
    dependencies = require('data.deps').gx,
    config = true,
  },
  { -- Codesnap
    'mistricky/codesnap.nvim',
    cond = require('data.func').check_global_var('codesnap', true, true),
    lazy = true,
    build = 'make',
    opts = require('data.types').codesnap,
    cmd = require('data.cmd').codesnap,
    keys = require('data.keys').codesnap,
  },
  { -- Kulala
    'mistweaverco/kulala.nvim',
    ft = require('data.types').kulala.ft,
    opts = {},
  },
  { -- Hardtime
    'm4xshen/hardtime.nvim',
    lazy = true,
    event = 'LazyFile',
    cond = require('data.func').check_global_var('usehardtime', true, true),
    build = 'make',
    dependencies = require('data.deps').hardtime,
    opts = require('data.types').hardtime.opts,
  },
  { -- CapsWord
    'dmtrKovalenko/caps-word.nvim',
    lazy = true,
    opts = {},
    keys = require('data.keys').capsword,
  },
  { -- Music Controls
    'AntonVanAssche/music-controls.nvim',
    cond = require('data.func').check_global_var('usemusic', true, true),
    dependencies = require('data.deps').musiccontrols,
    opts = {
      default_player = 'YoutubeMusic',
    },
  },
  { -- Qalc
    'Apeiros-46B/qalc.nvim',
    lazy = true,
    cmd = require('data.cmd').qalc,
    keys = require('data.keys').qalc,
    opts = require('data.types').qalc.opts,
  },
  { -- Remote-nvim
    'amitds1997/remote-nvim.nvim',
    lazy = true,
    version = '*', -- Pin to GitHub releases
    dependencies = require('data.deps').remotenvim,
    config = true,
  },
  { -- Encourage
    'r-cha/encourage.nvim',
    cond = require('data.func').check_global_var('encourage', true, true),
    config = true,
  },
  { -- Helpview
    'OXY2DEV/helpview.nvim',
    ft = 'help',
    dependencies = require('data.deps').needs_treesitter,
  },
  { -- Suda
    'lambdalisue/vim-suda',
    lazy = true,
    cmd = require('data.cmd').suda,
    config = require('data.types').suda,
  },
  { -- Discord Presence
    'IogaMaster/neocord',
    event = 'LazyFile',
    lazy = true,
    cond = require('data.func').check_global_var('usediscord', true, true),
    opts = require('data.types').neocord.opts,
  },
  { -- Floating Help
    'Tyler-Barham/floating-help.nvim',
    lazy = true,
    opts = require('data.types').floating_help.opts,
    cmd = require('data.cmd').floating_help,
    init = require('data.types').floating_help.init,
    cond = require('data.cond').floating_help,
  },
  { -- Multicursor
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    lazy = true,
    event = 'User LazyFileOpen',
    config = require('data.types').multicursor.config,
  },
  { -- showkeys
    'nvchad/showkeys',
    lazy = true,
    cmd = 'ShowkeysToggle',
    opts = require('data.types').showkeys.opts,
  },
  { -- Oil
    'stevearc/oil.nvim',
    opts = {},
    lazy = true,
    cond = require('data.func').check_global_var('useoil', true, true),
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  },
  { -- Utlities Framework
    'jrop/u.nvim',
    lazy = true,
  },
  { -- yazi
    'mikavilpas/yazi.nvim',
    lazy = true,
    cmd = 'Yazi',
    cond = require('data.cond').yazi,
  },
}
