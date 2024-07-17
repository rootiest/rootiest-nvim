-- -----------------------------------------------------------------------------
-- -------------------------------- UTILITIES ----------------------------------
-- -----------------------------------------------------------------------------

return {
  {
    import = "lazyvim.plugins.extras.util.project",
    opts = { manual_mode = false },
  },
  { import = "lazyvim.plugins.extras.util.chezmoi" },
  { import = "lazyvim.plugins.extras.util.dot" },
  { import = "lazyvim.plugins.extras.util.gitui" },
  { import = "lazyvim.plugins.extras.util.octo" },
  {
    "chrishrb/gx.nvim",
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({})
    end,
  },
  {
    "mikesmithgh/ugbi",
    event = "VeryLazy",
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
  },
  {
    "Rawnly/gist.nvim",
    event = "VeryLazy",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true,
  },
  {
    "samjwill/nvim-unception",
    lazy = false,
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
  {
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
  {
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
  {
    "mistweaverco/kulala.nvim",
    event = "InsertEnter",
    config = function()
      require("kulala").setup()
    end,
  },
}
