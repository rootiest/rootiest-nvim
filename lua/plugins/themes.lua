--          ╭─────────────────────────────────────────────────────────╮
--          │                         Themes                          │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- Tokyonight
    "folke/tokyonight.nvim",
    lazy = true, -- Override
    name = "tokyonight",
    opts = {
      style = "night",
    },
  },
  { -- Catppuccin
    "catppuccin/nvim",
    lazy = false, -- Override
    priority = 1000,
    name = "catppuccin",
    background = { -- :h background
      light = "latte",
      dark = "frappe",
    },
    integrations = {
      indent_blankline = {
        enabled = true,
        scope_color = "mauve",
        colored_indent_levels = true,
      },
      grug_far = true,
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = "mauve",
      },
      neotree = true,
      noice = true,
      nvim_surround = true,
      octo = true,
      overseer = true,
      rainbow_delimiters = true,
      which_key = true,
    },
  },
  { -- Ayu
    "Shatur/neovim-ayu",
    lazy = true,
    name = "ayu",
  },
  { -- Dracula
    "Mofiqul/dracula.nvim",
    lazy = true,
    name = "dracula",
  },
  { -- Eldritch
    "eldritch-theme/eldritch.nvim",
    lazy = true,
    name = "eldritch",
  },
  { -- Flow
    "0xstepit/flow.nvim",
    lazy = true,
    name = "flow",
  },
  { -- Github-theme
    "projekt0n/github-nvim-theme",
    lazy = true,
    name = "github-nvim-theme",
  },
  { -- Gruvbox
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    name = "gruvbox",
  },
  { -- Kanagawa
    "rebelot/kanagawa.nvim",
    lazy = true,
    name = "kanagawa",
  },
  { -- Monochrome
    "kdheepak/monochrome.nvim",
    lazy = true,
    name = "monochrome",
  },
  { -- NeoFusion
    "diegoulloao/neofusion.nvim",
    lazy = true,
    name = "neofusion",
  },
  { -- Nord
    "shaunsingh/nord.nvim",
    lazy = true,
    name = "nord",
  },
  { -- One Dark Pro
    "olimorris/onedarkpro.nvim",
    lazy = true,
    name = "onedarkpro",
  },
  { -- Oxocarbon
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    name = "oxocarbon",
  },
  { -- Paper
    "https://gitlab.com/yorickpeterse/vim-paper.git",
    lazy = true,
    name = "vim-paper",
  },
  { -- Rose-Pine
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  { -- Umbra
    "LZDQ/umbra.nvim",
    lazy = true,
    name = "umbra",
  },
  { -- Zenbones
    "zenbones-theme/zenbones.nvim",
    name = "zenbones",
    lazy = true,
    dependencies = { "rktjmp/lush.nvim" },
  },
  --  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ UTILITIES ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  { -- Transparent
    "xiyaowong/transparent.nvim",
    lazy = true,
    keys = data.keys.transparent,
    cmd = data.cmd.transparent,
  },
  { -- Auto Dark Mode
    "f-person/auto-dark-mode.nvim",
    lazy = true,
    opts = {
      update_interval = 2000,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme(
          require("astral").colortheme or "catppuccin-mocha" or "tokyonight"
        )
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme(
          require("astral").colortheme or "catppuccin-latte" or "tokyonight-day"
        )
      end,
    },
    cond = not data.func.is_ssh(),
  },
}
