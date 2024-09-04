---@module "plugins.terminal"
--- This module defines the terminal plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Terminals                        │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- Smart-Splits
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    build = data.types.smart_splits.build(),
  },
  { -- Image Renderer
    "3rd/image.nvim",
    ft = data.types.image,
    config = function()
      require("image").setup()
    end,
    cond = function()
      -- Disable image rendering in Neovide
      -- or when vim.g.useimage = false
      if vim.g.useimage == false then
        return false
      end
      return not vim.g.neovide
    end,
  },
  { -- ToggleTerm
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    keys = data.keys.toggleterm,
    config = function()
      require("toggleterm").setup(data.types.toggleterm)
    end,
  },
  { -- Kitty-Runner
    "jghauser/kitty-runner.nvim",
    cond = data.func.is_kitty(),
  },
  { -- Kitty-Scrollback
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = data.cmd.kitty_scrollback,
    event = { "User KittyScrollbackLaunch" },
    version = "*",
    config = function() -- Using Kitty-Scrollback
      if data.func.is_kitty_scrollback() then
        require("kitty-scrollback").setup()
      end
    end,
    cond = data.func.is_kitty_scrollback(),
  },
  { -- Nekifoch
    "NeViRAIDE/nekifoch.nvim",
    lazy = true,
    cmd = data.cmd.nekifoch,
    opts = {
      kitty_conf_path = vim.env.HOME .. "/.kittyoverrides",
    },
    keys = data.keys.nekifoch,
    cond = data.func.is_kitty(),
  },
  { -- WezTerm
    "willothy/wezterm.nvim",
    config = true,
    cond = data.func.is_wezterm(),
  },
  { -- Tmux
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
    cond = data.func.is_tmux(),
  },
}
