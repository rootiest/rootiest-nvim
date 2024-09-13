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
    keys = data.keys.gist,
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
    opts = {
      symbols = data.types.gitgraph.symbols(),
      format = {
        timestamp = data.types.gitgraph.timestamp,
        fields = data.types.gitgraph.fields,
      },
      hooks = {
        -- Check diff of a commit
        on_select_commit = function(commit)
          vim.notify("DiffviewOpen " .. commit.hash .. "^!")
          vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
          vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        end,
      },
    },
    keys = data.keys.gitgraph,
  },
  { -- Telescope Git Worktree
    "ThePrimeagen/git-worktree.nvim",
  },
}
