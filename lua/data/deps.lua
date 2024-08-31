---@module "data.deps"
--- This module aggregates various dependencies used throughout the configuration.
--- It provides a centralized way to access dependencies.

local M = {}

M.cmp = {
  {
    "L3MON4D3/LuaSnip",
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
  },
  {
    "petertriho/cmp-git",
    opts = {},
    config = function()
      local cmp = require("cmp")
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git", priority = 50 },
          { name = "path", priority = 40 },
        }, {
          { name = "buffer", priority = 50 },
        }),
      })
    end,
  },
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "onsails/lspkind.nvim",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-cmdline",
  "dmitmel/cmp-cmdline-history",
  "teramako/cmp-cmdline-prompt.nvim",
  "mtoohey31/cmp-fish",
  "vim-dadbod-completion",
  {
    "chrisgrieser/cmp_yanky",
    option = {
      onlyCurrentFiletype = false,
    },
  },
  "SergioRibera/cmp-dotenv",
  "hrsh7th/cmp-calc",
  "davidsierradz/cmp-conventionalcommits",
  "Dynge/gitmoji.nvim",
}

M.gx = {
  "nvim-lua/plenary.nvim",
}

M.hardtime = {
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",
}

M.lazygit = {
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
}

M.lualine = {
  { "bezhermoso/todos-lualine.nvim" },
  { "folke/todo-comments.nvim" },
}

M.minuet = {
  { "nvim-lua/plenary.nvim" },
  { "hrsh7th/nvim-cmp" },
}

M.musiccontrols = {
  "rcarriga/nvim-notify",
}

M.needs_telescope = {
  "nvim-telescope/telescope.nvim",
}

M.needs_treesitter = {
  "nvim-treesitter/nvim-treesitter",
}

M.neotest = {
  adapters = {
    "neotest-plenary",
    "neotest-python",
    "neotest-vim-test",
    "neotest-minitest",
    "neotest-bash",
  },
  deps = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "zidhuss/neotest-minitest",
    "rcasia/neotest-bash",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

M.recorder = {
  "rcarriga/nvim-notify",
}

M.remotenvim = {
  "nvim-lua/plenary.nvim", -- For standard functions
  "MunifTanjim/nui.nvim", -- To build the plugin UI
  "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
}

M.zenbones = {
  "rktjmp/lush.nvim",
}

return M
