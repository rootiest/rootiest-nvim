--          ╭─────────────────────────────────────────────────────────╮
--          │                        Utilities                        │
--          ╰─────────────────────────────────────────────────────────╯
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
    lazy = true,
    cmd = { "Browse" },
    keys = {
      { -- Open URL/Link
        "gx",
        "<cmd>Browse<cr>",
        mode = { "n", "x" },
        desc = "Open URL/Link",
      },
    },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  { -- Auto-save
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      execution_message = {
        enabled = false,
      },
    },
  },
  { -- Ripgrep substitute
    "chrisgrieser/nvim-rip-substitute",
    event = "InsertEnter",
    cmd = "RipSubstitute",
    keys = {
      { -- Rip Substitute
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = "Rip Substitute",
      },
    },
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
  { -- Unception
    "samjwill/nvim-unception",
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
  { -- 🍎 Icon Picker
    "ziontee113/icon-picker.nvim",
    lazy = true,
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
    keys = {
      { -- Pick Icon
        "<leader>Ii",
        "<cmd>IconPickerNormal<cr>",
        desc = "Pick Icon",
      },
      { -- Yank Icon
        "<leader>Iy",
        "<cmd>IconPickerYank<cr>",
        desc = "Yank Icon",
      },
      { -- Insert Icon in insert mode
        "<C-.>",
        "<cmd>IconPickerInsert<cr>",
        desc = "Insert Icon",
        mode = "i",
      },
    },
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
    keys = {
      {
        "<leader>lg",
        "<cmd>LazyGit<cr>",
        desc = "LazyGit",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { -- Codesnap
    "mistricky/codesnap.nvim",
    lazy = true,
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
    cmd = {
      "CodeSnap",
      "CodeSnapSave",
      "CodeSnapHighlight",
      "CodeSnapASCII",
    },
    keys = {
      { -- Save selected code snapshot into clipboard
        "<leader>cy",
        "<cmd>CodeSnap<cr>",
        desc = "Save selected code snapshot into clipboard",
        mode = "x",
      },
      { -- Save selected code snapshot in ~/Pictures
        "<leader>cs",
        "<cmd>CodeSnapSave<cr>",
        desc = "Save selected code snapshot in ~/Pictures",
        mode = "x",
      },
      { -- Highlight and snapshot selected code into clipboard
        "<leader>ch",
        "<cmd>CodeSnapHighlight<cr>",
        desc = "Highlight and snapshot selected code into clipboard",
        mode = "x",
      },
      { -- Save ASCII code snapshot into clipboard
        "<leader>ci",
        "<cmd>CodeSnapASCII<cr>",
        desc = "Save ASCII code snapshot into clipboard",
        mode = "x",
      },
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
        "<C-s>",
        function()
          require("caps-word").toggle()
        end,
        desc = "Toggle CapsWord",
        mode = { "i", "n" },
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
  { -- Qalc
    "Apeiros-46B/qalc.nvim",
    cmd = {
      "Qalc",
      "QalcAttach",
      "QalcYank",
    },
    keys = {
      { "<leader>qc", "<cmd>Qalc<cr>", desc = "Qalc" },
    },
    opts = {
      set_ft = "qalc",
    },
  },
  { -- Remote-nvim
    "amitds1997/remote-nvim.nvim",
    lazy = true,
    version = "*", -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  },
}
