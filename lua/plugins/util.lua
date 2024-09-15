--- @module "plugins.util"
--- This module defines the utility plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Utilities                        │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- Chezmoi
    import = "lazyvim.plugins.extras.util.chezmoi",
  },
  { -- Dotfiles plugins
    import = "lazyvim.plugins.extras.util.dot",
  },
  { -- Wakatime
    "wakatime/vim-wakatime",
    cond = vim.g.usewakatime,
  },
  { -- Link following
    "chrishrb/gx.nvim",
    lazy = true,
    cmd = data.cmd.gx,
    keys = data.keys.gx,
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = data.deps.gx,
    config = true,
  },
  { -- Auto-save
    "okuuva/auto-save.nvim",
    enabled = data.func.check_global_var("auto_save", true, true),
    cmd = data.cmd.autosave,
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
    cmd = data.cmd.ripsub,
    keys = data.keys.ripsub,
  },
  { -- Unception
    "samjwill/nvim-unception",
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
  { -- Codesnap
    "mistricky/codesnap.nvim",
    enabled = data.func.check_global_var("codesnap", true, true),
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
    cmd = data.cmd.codesnap,
    keys = data.keys.codesnap,
  },
  { -- Kulala
    "mistweaverco/kulala.nvim",
    ft = { "http", "https", "ftp", "ftps" },
    opts = {},
  },
  { -- Hardtime
    "m4xshen/hardtime.nvim",
    dependencies = data.deps.hardtime,
    opts = function()
      return { enabled = vim.g.usehardtime }
    end,
  },
  { -- CapsWord
    "dmtrKovalenko/caps-word.nvim",
    lazy = true,
    opts = {},
    keys = data.keys.capsword,
  },
  { -- Music Controls
    "AntonVanAssche/music-controls.nvim",
    enabled = data.func.check_global_var("usemusic", true, true),
    dependencies = data.deps.musiccontrols,
    opts = {
      default_player = "YoutubeMusic",
    },
  },
  { -- Qalc
    "Apeiros-46B/qalc.nvim",
    cmd = data.cmd.qalc,
    keys = data.keys.qalc,
    opts = {
      set_ft = "qalc",
    },
  },
  { -- Remote-nvim
    "amitds1997/remote-nvim.nvim",
    lazy = true,
    version = "*", -- Pin to GitHub releases
    dependencies = data.deps.remotenvim,
    config = true,
  },
  { -- Encourage
    "r-cha/encourage.nvim",
    config = true,
  },
  { -- Helpview
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = data.deps.needs_treesitter,
  },
  { -- Suda
    "lambdalisue/vim-suda",
    cmd = data.cmd.suda,
    config = function()
      vim.g.suda_smart_edit = 1
      vim.cmd("let g:suda#prompt = '   Enter Sudo Password  '")
    end,
  },
  { -- Spell checker
    "matkrin/telescope-spell-errors.nvim",
    lazy = true,
    cmd = data.cmd.spell_errors,
    config = function()
      require("telescope").load_extension("spell_errors")
    end,
    dependencies = data.deps.needs_telescope,
  },
  { -- Pigeon
    "Pheon-Dev/pigeon",
    config = data.types.pigeon,
  },
  { -- Discord Presence
    "andweeb/presence.nvim",
    opts = {
      enable_line_number = true,
    },
  },
  { -- Telescope Cmdline
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jonarrien/telescope-cmdline.nvim",
    },
    keys = data.keys.telescope.cmdline,
    opts = data.types.telescope.cmdline,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("cmdline")
    end,
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      -- optional, if using telescope for vim.ui.select
      "stevearc/dressing.nvim",
    },
    opts = {
      default = {
        disable = true, -- disable any unkown pickers (recommended)
        use_cwd = true, -- differentiate scoring for each picker based on cwd
        sorting = "frecency", -- sorting: options: 'recent' and 'frecency'
      },
    },
  },
  { -- Telescope symbols
    "nvim-telescope/telescope-symbols.nvim",
    config = function() end,
    keys = data.keys.telescope.symbols,
  },
  { -- Telescope Toggleterm
    "ryanmsnyder/toggleterm-manager.nvim",
    dependencies = {
      "akinsho/nvim-toggleterm.lua",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
    },
    config = true,
    keys = data.keys.telescope.toggleterm,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "tsakirist/telescope-lazy.nvim",
    keys = data.keys.telescope.lazy,
  },
}
