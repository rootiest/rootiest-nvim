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
  -- { -- LazyGit
  --   'kdheepak/lazygit.nvim',
  --   lazy = true,
  --   cmd = require('data.cmd').lazygit,
  --   keys = require('data.keys').lazygit,
  --   dependencies = require('data.deps').lazygit,
  --   config = function()
  --     if
  --       require('data.func').check_global_var('use_telescope', true, false)
  --     then
  --       require('telescope').load_extension('lazygit')
  --     end
  --   end,
  -- },
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
    opts = {},
  },
  { -- Neogit
    'NeogitOrg/neogit',
    opts = {
      graph_style = 'kitty',
    },
  },
}
