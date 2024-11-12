--- @module "plugins.git"
--- This module defines the git plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                       Git Plugins                       │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Octo plugin
    import = 'lazyvim.plugins.extras.util.octo',
  },
  { -- Gist Tools
    'Rawnly/gist.nvim',
    lazy = true,
    cmd = require('data.cmd').gist,
    keys = require('data.keys').gist.func,
    config = true,
  },
  { -- LazyGit
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = require('data.cmd').lazygit,
    keys = require('data.keys').lazygit,
    dependencies = require('data.deps').lazygit,
    config = function()
      require('telescope').load_extension('lazygit')
    end,
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
    event = 'VeryLazy',
    opts = require('data.types').gitblame.opts,
  },
  { -- Git Graph
    'isakbm/gitgraph.nvim',
    opts = require('data.types').gitgraph.opts,
    keys = require('data.keys').gitgraph,
  },
  { -- Diffview
    'sindrets/diffview.nvim',
    lazy = false,
    opts = {},
  },
  { -- Neogit
    'NeogitOrg/neogit',
    opts = {
      graph_style = 'kitty',
    },
  },
}
