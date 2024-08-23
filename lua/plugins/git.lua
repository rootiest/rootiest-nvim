--          ╭─────────────────────────────────────────────────────────╮
--          │                       Git Plugins                       │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Git UI
    import = "lazyvim.plugins.extras.util.gitui",
  },
  { -- Octo plugin
    import = "lazyvim.plugins.extras.util.octo",
  },
  { -- DiffView
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = require("data.cmd").diffview,
  },
  { -- Gist Tools
    "Rawnly/gist.nvim",
    lazy = true,
    cmd = require("data.cmd").gist,
    keys = require("data.keys").gist,
    config = true,
  },
  { -- LazyGit
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = require("data.cmd").lazygit,
    keys = require("data.keys").lazygit,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  { -- Thanks/github-stars
    "jsongerber/thanks.nvim",
    lazy = true,
    cmd = require("data.cmd").thanks,
    opts = {
      star_on_install = false,
    },
  },
  { -- GitLinker
    "linrongbin16/gitlinker.nvim",
    lazy = true,
    cmd = require("data.cmd").gitlinker,
    opts = {},
    keys = require("data.keys").gitlinker,
  },
  { -- Git Blame
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = function()
      -- Get the current lualine configuration
      local config = require("lualine").get_config()
      local git_blame = require("gitblame")
      local utils = require("utils.rootiest")
      -- Define the width limit for displaying the Git blame component
      local width_limit = 180 -- Adjust this value as needed
      -- Add Git-blame to lualine_c section
      table.insert(config.sections.lualine_c, {
        git_blame.get_current_blame_text,
        cond = function() -- Only show if text is available
          return git_blame.is_blame_text_available()
            and utils.is_window_wide_enough(width_limit)
        end,
        color = { fg = utils.get_fg_color("GitSignsCurrentLineBlame") },
      })
      -- Apply the lualine configuration
      require("lualine").setup(config)
      -- Return the git-blame options
      return require("data.types").gitblame
    end,
  },
  { -- Git Graph
    "isakbm/gitgraph.nvim",
    opts = {
      symbols = require("data.types").gitgraph.symbols(),
      format = {
        timestamp = require("data.types").gitgraph.timestamp,
        fields = require("data.types").gitgraph.fields,
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
    keys = require("data.keys").gitgraph,
  },
  { -- FuGit
    "SuperBo/fugit2.nvim",
    opts = {
      width = 100,
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      {
        "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
        dependencies = { "stevearc/dressing.nvim" },
      },
    },
    cmd = require("data.cmd").fugit,
    keys = require("data.keys").fugit,
  },
}
