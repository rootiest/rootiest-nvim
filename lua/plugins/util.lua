-- -----------------------------------------------------------------------------
-- -------------------------------- UTILITIES ----------------------------------
-- -----------------------------------------------------------------------------

return {
  { -- Project management
    import = "lazyvim.plugins.extras.util.project",
    opts = { manual_mode = false },
  },
  { -- Chezmoi
    import = "lazyvim.plugins.extras.util.chezmoi",
  },
  { -- Dotfiles plugins
    import = "lazyvim.plugins.extras.util.dot",
  },
  { -- Git UI
    import = "lazyvim.plugins.extras.util.gitui",
  },
  { -- Octo plugin
    import = "lazyvim.plugins.extras.util.octo",
  },
  { -- Wakatime
    "wakatime/vim-wakatime",
    cond = function()
      if
        vim.fn.readfile(vim.fn.stdpath("config") .. "/.wakatime")[1]
        == "true"
      then
        return true
      end
    end,
  },
  { -- Link following
    "chrishrb/gx.nvim",
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  { -- Auto-save
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({})
    end,
  },
  { -- User is bored
    "mikesmithgh/ugbi",
    event = "VeryLazy",
  },
  { -- Ripgrep substitute
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
  },
  { -- Gist Tools
    "Rawnly/gist.nvim",
    event = "VeryLazy",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true,
  },
  { -- Unception
    "samjwill/nvim-unception",
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
  { -- 🍎 Icon Picker
    "ziontee113/icon-picker.nvim",
    event = "InsertEnter",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
  },
  { -- LazyGit
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { -- Codesnap
    "mistricky/codesnap.nvim",
    event = "InsertEnter",
    build = "make",
    opts = {
      save_path = "~/Pictures/Screenshots/",
      has_breadcrumbs = true,
      show_workspace = true,
      bg_theme = "default",
      watermark = "Rootiest Snippets",
      code_font_family = "Iosevka NF",
      code_font_size = 12,
    },
  },
  { -- Kulala
    "mistweaverco/kulala.nvim",
    event = "InsertEnter",
    config = function()
      require("kulala").setup()
    end,
  },
  { -- Fugitive
    "tpope/vim-fugitive",
    event = "InsertEnter",
    dependencies = { "tpope/vim-rhubarb" },
  },
  { -- Thanks/github-stars
    "jsongerber/thanks.nvim",
    config = {
      star_on_install = false,
    },
  },
  { -- Hardtime
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = function()
      if
        vim.fn.readfile(vim.fn.stdpath("config") .. "/.hardtime")[1]
        == "true"
      then
        return { enabled = true }
      else
        return { enabled = false }
      end
    end,
  },
  { -- GitLinker
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      {
        "<leader>gy",
        "<cmd>GitLink<cr>",
        mode = { "n", "v" },
        desc = "Yank git link",
      },
      {
        "<leader>gY",
        "<cmd>GitLink!<cr>",
        mode = { "n", "v" },
        desc = "Open git link",
      },
    },
  },
}
