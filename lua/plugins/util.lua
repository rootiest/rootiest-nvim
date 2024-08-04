-- -----------------------------------------------------------------------------
-- -------------------------------- UTILITIES ----------------------------------
-- -----------------------------------------------------------------------------

-- Function to convert RGB to hexadecimal
local function rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

local function get_fg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local fg = hl.fg
  if fg then
    return rgb_to_hex({
      bit.rshift(bit.band(fg, 0xFF0000), 16),
      bit.rshift(bit.band(fg, 0x00FF00), 8),
      bit.band(fg, 0x0000FF),
    })
  end
  return nil
end

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
    cond = vim.g.usewakatime,
  },
  { -- Link following
    "chrishrb/gx.nvim",
    event = "VeryLazy",
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  { -- Auto-save
    "Pocco81/auto-save.nvim",
    event = "BufEnter",
  },
  { -- User is bored
    "mikesmithgh/ugbi",
    event = "InsertEnter",
  },
  { -- Ripgrep substitute
    "chrisgrieser/nvim-rip-substitute",
    event = "InsertEnter",
    cmd = "RipSubstitute",
  },
  { -- Gist Tools
    "Rawnly/gist.nvim",
    event = "InsertEnter",
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
  { -- Thanks/github-stars
    "jsongerber/thanks.nvim",
    event = "VeryLazy",
    opts = {
      star_on_install = false,
    },
  },
  { -- Hardtime
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = function()
      return { enabled = vim.g.usehardtime }
    end,
  },
  { -- GitLinker
    "linrongbin16/gitlinker.nvim",
    lazy = true,
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
  { -- CapsWord
    "dmtrKovalenko/caps-word.nvim",
    lazy = true,
    opts = {},
    keys = {
      {
        mode = { "i", "n" },
        "<C-s>",
        "<cmd>lua require('caps-word').toggle()<CR>",
      },
    },
  },
  { -- Music Controls
    "AntonVanAssche/music-controls.nvim",
    dependencies = { "rcarriga/nvim-notify" },
    opts = {
      default_player = "YoutubeMusic",
    },
  },
  { -- Git Blame
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = function()
      -- Get the current lualine configuration
      local config = require("lualine").get_config()
      local git_blame = require("gitblame")
      -- Add Git-blame to lualine_c section
      table.insert(config.sections.lualine_c, {
        git_blame.get_current_blame_text,
        cond = git_blame.is_blame_text_available,
        color = { fg = get_fg_color("GitSignsCurrentLineBlame") },
      })

      -- Apply the new configuration
      require("lualine").setup(config)
    end,
  },
}
