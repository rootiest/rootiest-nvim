--- @module "plugins.git"
--- This module defines the git plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                       Git Plugins                       │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- Octo plugin
    import = "lazyvim.plugins.extras.util.octo",
  },
  { -- Gist Tools
    "Rawnly/gist.nvim",
    lazy = true,
    cmd = data.cmd.gist,
    keys = data.keys.gist.func,
    config = true,
  },
  { -- LazyGit
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = data.cmd.lazygit,
    keys = data.keys.lazygit,
    dependencies = data.deps.lazygit,
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  { -- Thanks/github-stars
    "jsongerber/thanks.nvim",
    lazy = true,
    cmd = data.cmd.thanks,
    opts = data.types.thanks.opts,
  },
  { -- GitLinker
    "linrongbin16/gitlinker.nvim",
    lazy = true,
    cmd = data.cmd.gitlinker,
    opts = {},
    keys = data.keys.gitlinker,
  },
  { -- Git Blame
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = data.types.gitblame.opts,
  },
  { -- Git Graph
    "isakbm/gitgraph.nvim",
    opts = data.types.gitgraph.opts,
    keys = data.keys.gitgraph,
  },
  { -- Diffview
    "sindrets/diffview.nvim",
    lazy = false,
    opts = {},
  },
  { -- Neogit
    "NeogitOrg/neogit",
    opts = {
      graph_style = "kitty",
    },
  },
}
