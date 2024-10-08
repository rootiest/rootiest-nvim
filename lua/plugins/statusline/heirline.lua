--- @module "plugins.statusline.heirline"
--- This module defines the heirline plugin spec for the Neovim configuration.
--- This option uses the heirline plugin to create a statusline for Neovim
---
--- Activate this module by setting the 'vim.g.statusline' variable to 'heirline'
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Heirline                         │
--          ╰─────────────────────────────────────────────────────────╯

local data = require("data")

return {
  {
    "rebelot/heirline.nvim",
    cond = data.func.check_global_var("statusline", "heirline", "lualine"),
    event = "UIEnter",
    opts = {},
  },
}
