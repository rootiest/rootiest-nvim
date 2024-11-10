--          ╭─────────────────────────────────────────────────────────╮
--          │                        Overrides                        │
--          ╰─────────────────────────────────────────────────────────╯

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Keymap Overrides ━━━━━━━━━━━━━━━━━━━━━━━

-- Add keymapper function
local add_keymap = require("data.func").add_keymap

-- Add keymaps for overrides
add_keymap(require("data.keys").overrides)

-- Replace '...' with '…' (ellipsis) on InsertLeave
require("data.func").setup_replace_ellipsis(true)

-- Search selected text in visual mode
add_keymap("/", "*<Esc>", "Search selected text", "v")

-- Use modern cipher instead of rot13
add_keymap(require("data.keys").cipher.hex)

-- Help keybinds
for _, item in ipairs(require("data.keys").help) do
  add_keymap(item)
end

-- Remap Command Mode List
require("data.keys").cmd_mode()

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Additional Overrides ━━━━━━━━━━━━━━━━━━━━━

if vim.g.is_termux then
  if require("data.func").is_installed("neominimap") then
    -- Disable NeoMiniMap
    vim.cmd("Neominimap off")
  end
end
