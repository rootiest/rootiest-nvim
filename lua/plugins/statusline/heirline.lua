--- @module "plugins.statusline.heirline"
--- This module defines the heirline plugin spec for the Neovim configuration.
--- This option uses the heirline plugin to create a statusline for Neovim
---
--- Activate this module by setting the 'vim.g.statusline' variable to 'heirline'
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Heirline                         │
--          ╰─────────────────────────────────────────────────────────╯

return {
  {
    "rebelot/heirline.nvim",
    cond = require("data.func").check_global_var(
      "statusline",
      "heirline",
      "lualine"
    ),
    event = "UIEnter",
    opts = {},
  },
}
