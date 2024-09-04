---@module "plugins.statusline.none"
--- This module sets up the no-statusline optional mode for the Neovim configuration.
--- This option disables the statusline entirely for a more minimalistic appearance.
---
--- Activate this module by setting the 'vim.g.statusline' variable to 'none'
--          ╭─────────────────────────────────────────────────────────╮
--          │                         No Statusline                     │
--          ╰─────────────────────────────────────────────────────────╯

if vim.g.statusline ~= "none" then
  return {}
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ NO-STATUSLINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Set up the no-statusline
vim.o.laststatus = 0

-- No lazy.nvim plugin necessary
return {}
