--          ╭─────────────────────────────────────────────────────────╮
--          │                    Telescope Plugins                    │
--          ╰─────────────────────────────────────────────────────────╯
---@module "plugins.telescope"
--- This module defines the telescope plugins specs for the Neovim configuration.

local data = require("data")

local P = { -- Define Telescope Plugins Specs
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
  { -- Telescope All Recent
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
  { -- Telescope Spell checker
    "matkrin/telescope-spell-errors.nvim",
    lazy = true,
    cmd = data.cmd.spell_errors,
    config = function()
      require("telescope").load_extension("spell_errors")
    end,
    dependencies = data.deps.needs_telescope,
  },
  { -- Telescope symbols
    "nvim-telescope/telescope-symbols.nvim",
    config = function() end,
    keys = data.keys.telescope.symbols,
    lazy = false,
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
  { -- Telescope Lazy
    "nvim-telescope/telescope.nvim",
    dependencies = "tsakirist/telescope-lazy.nvim",
    keys = data.keys.telescope.lazy,
  },
  { -- Telescope Luasnip
    "benfowler/telescope-luasnip.nvim",
    module = "telescope._extensions.luasnip", -- if you wish to lazy-load
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },
  { -- Telescope Git Worktree
    "ThePrimeagen/git-worktree.nvim",
  },
  { -- UndoTree Telescope extension
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    opts = function()
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>uU", "<cmd>Telescope undo<cr>")
      return {
        extensions = {
          undo = {},
        },
      }
    end,
  },
}

return P
