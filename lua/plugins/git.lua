--- @module "plugins.git"
--- This module defines the git plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                       Git Plugins                       │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Gist Tools
    'Rawnly/gist.nvim',
    lazy = true,
    cmd = require('data.cmd').gist,
    keys = require('data.keys').gist.func,
    config = true,
  },
  { -- Thanks/github-stars
    'jsongerber/thanks.nvim',
    lazy = true,
    cmd = require('data.cmd').thanks,
    opts = require('data.types').thanks.opts,
  },
  { -- GitLinker
    'linrongbin16/gitlinker.nvim',
    lazy = true,
    cmd = require('data.cmd').gitlinker,
    opts = {},
    keys = require('data.keys').gitlinker,
  },
  { -- Git Blame
    'f-person/git-blame.nvim',
    event = 'LazyFile',
    cond = require('data.cond').lualine,
    opts = require('data.types').gitblame.opts,
  },
  { -- Git Graph
    'isakbm/gitgraph.nvim',
    opts = require('data.types').gitgraph.opts,
    keys = require('data.keys').gitgraph,
  },
  { -- Diffview
    'sindrets/diffview.nvim',
    lazy = true,
    cmd = require('data.cmd').diffview,
    opts = require('data.types').diffview.opts,
  },
  { -- Neogit
    'NeogitOrg/neogit',
    opts = {
      graph_style = 'kitty',
    },
  },
  { -- GitSigns
    'lewis6991/gitsigns.nvim',
    opts = function()
      local myopts = {}
      myopts.linehl = vim.g.git_line_hl or false
      myopts.word_diff = vim.g.git_word_hl or false
      return myopts
    end,
  },
}
