--- @module "config.profiler"
--- This module configures the profiler for the Neovim configuration.
--- This tool can be used to profile specific modules or all modules.
---
--- The profiler can be toggled with the leader keybinding `d<f1>`
--- or with the `PROF` environment variable.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        PROFILER                         │
--          ╰─────────────────────────────────────────────────────────╯

if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath('data') .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup({
    startup = {
      event = 'VimEnter', -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end
