---@module "plugins.terminal"
--- This module defines the terminal plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Terminals                        │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Smart-Splits
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    build = require('data.types').smart_splits.build(),
    -- cond = not require('data.func').is_ghostty(),
  },
  { -- Kitty-Runner
    'jghauser/kitty-runner.nvim',
    cond = require('data.func').is_kitty(),
  },
  { -- Kitty-Scrollback
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = require('data.cmd').kitty_scrollback,
    event = { 'User KittyScrollbackLaunch' },
    version = '*',
    config = function() -- Using Kitty-Scrollback
      if require('data.func').is_kitty_scrollback() then
        require('kitty-scrollback').setup()
      end
    end,
    cond = require('data.func').is_kitty_scrollback(),
  },
  { -- Nekifoch
    'NeViRAIDE/nekifoch.nvim',
    lazy = true,
    cmd = require('data.cmd').nekifoch,
    opts = {
      kitty_conf_path = vim.env.HOME .. '/.kittyoverrides',
    },
    keys = require('data.keys').nekifoch,
    cond = require('data.func').is_kitty(),
  },
  { -- WezTerm
    'willothy/wezterm.nvim',
    config = true,
    cond = require('data.func').is_wezterm(),
  },
  { -- Tmux
    'aserowy/tmux.nvim',
    config = function()
      return require('tmux').setup()
    end,
    cond = require('data.func').is_tmux(),
  },
}
