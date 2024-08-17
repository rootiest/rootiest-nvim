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
  { -- Gist Tools
    "Rawnly/gist.nvim",
    lazy = true,
    cmd = {
      "GistCreate",
      "GistCreateFromFile",
      "GistsList",
    },
    keys = {
      { -- Create Gist
        "<leader>gnc",
        "<cmd>GistCreate<cr>",
        desc = "Create Gist",
        mode = { "n", "x" },
      },
      { -- Find Gists
        "<leader>gnf",
        "<cmd>GistList<cr>",
        desc = "Find Gists",
      },
    },
    config = true,
  },
  { -- LazyGit
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { -- LazyGit
        "<leader>lg",
        "<cmd>LazyGit<cr>",
        desc = "LazyGit",
      },
    },
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
    cmd = {
      "ThanksAll",
      "ThanksGithubAuth",
      "ThanksGithubLogout",
      "ThanksClearCache",
    },
    opts = {
      star_on_install = false,
    },
  },
  { -- GitLinker
    "linrongbin16/gitlinker.nvim",
    lazy = true,
    cmd = "GitLink",
    opts = {},
    keys = {
      { -- Yank git link
        "<leader>gy",
        "<cmd>GitLink<cr>",
        mode = { "n", "v" },
        desc = "Yank git link",
      },
      { -- Open git link
        "<leader>gY",
        "<cmd>GitLink!<cr>",
        mode = { "n", "v" },
        desc = "Open git link",
      },
    },
  },
  { -- Git Blame
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = function()
      -- Get the current lualine configuration
      local config = require("lualine").get_config()
      local git_blame = require("gitblame")
      local rootilities = require("utils.rootiest")
      -- Define the width limit for displaying the Git blame component
      local width_limit = 180 -- Adjust this value as needed
      -- Add Git-blame to lualine_c section
      table.insert(config.sections.lualine_c, {
        git_blame.get_current_blame_text,
        cond = function() -- Only show the component if the text is available
          return git_blame.is_blame_text_available()
            and rootilities.is_window_wide_enough(width_limit)
        end,
        color = { fg = rootilities.get_fg_color("GitSignsCurrentLineBlame") },
      })
      -- Apply the lualine configuration
      require("lualine").setup(config)
      -- Define git-blame options
      local git_ops = {
        display_virtual_text = 0, -- Disable virtual text
        date_format = "%r", -- Relative date format
        message_when_not_committed = "  Fly, you fools!",
        message_template = "<author> • <date> • <summary>",
      }
      -- Return the git-blame options
      return git_ops
    end,
  },
  { -- Git Graph
    "isakbm/gitgraph.nvim",
    opts = {
      symbols = {
        merge_commit = "",
        commit = "",
        merge_commit_end = "",
        commit_end = "",

        -- Advanced symbols
        GVER = "",
        GHOR = "",
        GCLD = "",
        GCRD = "╭",
        GCLU = "",
        GCRU = "",
        GLRU = "",
        GLRD = "",
        GLUD = "",
        GRUD = "",
        GFORKU = "",
        GFORKD = "",
        GRUDCD = "",
        GRUDCU = "",
        GLUDCD = "",
        GLUDCU = "",
        GLRDCL = "",
        GLRDCR = "",
        GLRUCL = "",
        GLRUCR = "",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          print("selected commit:", commit.hash)
        end,
        on_select_range_commit = function(from, to)
          print("selected range:", from.hash, to.hash)
        end,
      },
    },
    keys = {
      { -- gitgraph_toggle
        "<leader>gm",
        function()
          require("utils.git").gitgraph_toggle()
        end,
        desc = "GitGraph - Toggle",
      },
    },
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
    cmd = {
      "Fugit2",
      "Fugit2Diff",
      "Fugit2Graph",
    },
    keys = {
      { -- Open Fugit
        "<leader>F",
        mode = "n",
        "<cmd>Fugit2<cr>",
      },
    },
  },
}
