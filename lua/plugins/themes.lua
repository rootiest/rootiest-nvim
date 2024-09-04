--- @module "plugins.themes"
--- This module defines the themes plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Themes                          │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

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
    opts = data.types.catppuccin,
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
    dependencies = data.deps.zenbones,
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
    opts = data.types.auto_dark_mode,
    cond = not data.func.is_ssh(),
  },
  { -- Highlight colors
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = data.types.hightlight_colors,
  },
}
