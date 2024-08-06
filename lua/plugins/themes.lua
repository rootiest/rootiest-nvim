--          ╭─────────────────────────────────────────────────────────╮
--          │                         Themes                          │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- Tokyonight
    "folke/tokyonight.nvim",
    lazy = false, -- Override
  },
  { -- Catppuccin
    "catppuccin/nvim",
    lazy = false, -- Override
    integrations = {
      indent_blankline = {
        enabled = true,
        scope_color = "mauve",
        colored_indent_levels = false,
      },
    },
  },
  { -- Ayu
    "Shatur/neovim-ayu",
  },
  { -- Dracula
    "Mofiqul/dracula.nvim",
  },
  { -- Eldritch
    "eldritch-theme/eldritch.nvim",
  },
  { -- Github-theme
    "projekt0n/github-nvim-theme",
  },
  { -- Gruvbox
    "ellisonleao/gruvbox.nvim",
  },
  { -- Kanagawa
    "rebelot/kanagawa.nvim",
  },
  { -- Monochrome
    "kdheepak/monochrome.nvim",
  },
  { -- NeoFusion
    "diegoulloao/neofusion.nvim",
  },
  { -- Nord
    "shaunsingh/nord.nvim",
  },
  { -- One Dark Pro
    "olimorris/onedarkpro.nvim",
  },
  { -- Oxocarbon
    "nyoom-engineering/oxocarbon.nvim",
  },
  { -- Paper
    "https://gitlab.com/yorickpeterse/vim-paper.git",
  },
  { -- Rose-Pine
    "rose-pine/neovim",
    name = "rose-pine",
  },
  { -- Umbra
    "LZDQ/umbra.nvim",
  },
  { -- Zenbones
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
  --  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ UTILITIES ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  { -- Transparent
    "xiyaowong/transparent.nvim",
    lazy = true,
    config = true,
    keys = {
      {
        "<leader>wt",
        function()
          require("transparent").toggle()
        end,
        desc = "Toggle Transparency",
      },
    },
  },
  { -- Auto Dark Mode
    "f-person/auto-dark-mode.nvim",
    lazy = true,
    opts = {
      update_interval = 2000,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme(
          require("astral").colortheme or "catppuccin-frappe" or "tokyonight"
        )
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme(
          require("astral").colortheme or "catppuccin-latte" or "tokyonight-day"
        )
      end,
    },
    cond = function() -- Not Using SSH
      local ssh = os.getenv("SSH_TTY") or false
      return not ssh
    end,
  },
}
