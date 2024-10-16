--          ╭─────────────────────────────────────────────────────────╮
--          │                    Telescope Plugins                    │
--          ╰─────────────────────────────────────────────────────────╯
---@module "plugins.telescope"
--- This module defines the telescope plugins specs for the Neovim configuration.

local data = require("data")

local P = { -- Define Telescope Plugins Specs
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
  { -- Telescope Heading
    "crispgm/telescope-heading.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          heading = {
            treesitter = true,
          },
        },
      })
      require("telescope").load_extension("heading")
    end,
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
  { -- Telescope Software Licenses
    "chip/telescope-software-licenses.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("software-licenses")
    end,
  },
  { -- Telescope Conventional Commits
    "olacin/telescope-cc.nvim",
    config = function()
      require("telescope").load_extension("conventional_commits")
    end,
  },
  { -- Telescope File Browser
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    keys = data.keys.telescope.filebrowser,
  },
  { -- Cheatsheet
    "doctorfree/cheatsheet.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "Cheatsheet",
    config = function()
      local ctactions = require("cheatsheet.telescope.actions")
      require("cheatsheet").setup({
        bundled_cheetsheets = {
          enabled = {
            "default",
            "lua",
            "markdown",
            "regex",
            "netrw",
            "unicode",
          },
          disabled = { "nerd-fonts" },
        },
        bundled_plugin_cheatsheets = {
          enabled = {
            "auto-session",
            "goto-preview",
            "octo.nvim",
            "telescope.nvim",
            "vim-easy-align",
            "vim-sandwich",
          },
          disabled = { "gitsigns" },
        },
        include_only_installed_plugins = true,
        telescope_mappings = {
          ["<CR>"] = ctactions.select_or_fill_commandline,
          ["<A-CR>"] = ctactions.select_or_execute,
          ["<C-Y>"] = ctactions.copy_cheat_value,
          ["<C-E>"] = ctactions.edit_user_cheatsheet,
        },
      })
      require("telescope").load_extension("cheatsheet")
    end,
  },
  { -- Telescope Git Diffs
    "paopaol/telescope-git-diffs.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  },
  { -- Fzf Lua
    "ibhagwan/fzf-lua",
    opts = {},
  },
}

if require("data.func").check_global_var("use_telescope", false, true) then
  P = { { import = "lazyvim.plugins.extras.editor.fzf" } }
end

if require("data.func").check_global_var("use_fzf_lua", true, false) then
  table.insert(P, 1, { import = "lazyvim.plugins.extras.editor.fzf" })
  table.insert(P, 2, { "ibhagwan/fzf-lua", lazy = false, opts = {} })
end

return P
