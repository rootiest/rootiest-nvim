---@module "plugins.statusline.basic"
--- This module defines the basic statusline spec for the Neovim configuration.
--- This option uses the native statusline feature to create a basic statusline
---
--- Activate this module by setting the 'vim.g.statusline' variable to 'basic'
--          ╭─────────────────────────────────────────────────────────╮
--          │                          BASIC                          │
--          ╰─────────────────────────────────────────────────────────╯

-- If basic statusline is not enabled, return an empty table
if vim.g.statusline ~= "basic" then
  return {}
end

-- Set up the basic statusline

---TODO: Write a basic statusline configuration using the
---      native statusline feature.

-- No lazy.nvim plugin necessary
return {}
