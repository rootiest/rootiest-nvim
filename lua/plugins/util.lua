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
    opts = data.types.autosave,
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
    opts = data.types.codesnap,
    cmd = data.cmd.codesnap,
    keys = data.keys.codesnap,
  },
  { -- Kulala
    "mistweaverco/kulala.nvim",
    ft = data.types.kulala.ft,
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
      bufname = "qalc",
      set_ft = "qalc",
      yank_default_register = "+",
      diagnostics = {
        underline = true,
        virtual_text = true,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
      },
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
    enabled = data.func.check_global_var("encourage", true, true),
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
    config = data.types.suda,
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
  { -- Floating Help
    "Tyler-Barham/floating-help.nvim",
    opts = {
      width = 0.8, -- Whole numbers are columns/rows
      height = 0.9, -- Decimals are a percentage of the editor
      position = "C", -- NW,N,NW,W,C,E,SW,S,SE (C==center)
      border = "rounded", -- rounded,double,single
    },
    cmd = {
      "FloatingHelp",
      "FloatingHelpClose",
      "FloatingHelpToggle",
    },
    init = function()
      vim.g.floating_help = true
      -- Only replace cmds, not search; only replace the first instance
      --- Replace commands in the form of 'cabbr <abbrev> <expansion>'
      ---@param abbrev string The abbreviation to replace
      ---@param expansion string The expansion to replace it with
      local function cmd_abbrev(abbrev, expansion)
        local cmd = "cabbr "
          .. abbrev
          .. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
          .. expansion
          .. '" : "'
          .. abbrev
          .. '")<CR>'
        vim.cmd(cmd)
      end
      -- Replace native help commands with floating help
      cmd_abbrev("h", "FloatingHelp")
      cmd_abbrev("help", "FloatingHelp")
      cmd_abbrev("helpc", "FloatingHelpClose")
      cmd_abbrev("helpclose", "FloatingHelpClose")
    end,
  },
  { -- Timer
    "alex-popov-tech/timer.nvim",
  },
}
