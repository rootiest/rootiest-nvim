--- @module "config.keymaps"
--- This module defines the keymapping operations for the Neovim configuration.
--- The actual keybindings are defined in lua/data/keys.lua
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Keybinds                         │
--          ╰─────────────────────────────────────────────────────────╯

-- All keybinds are defined in lua/data/keys.lua
-- This allows both plugin and general keybinds to
-- be defined in a single central location

-- Load data module
local data = require("data")

-- Add keymapper function
local add_keymap = data.func.add_keymap

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Group Keybinds ━━━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for menu groups
for _, item in ipairs(data.keys.groups) do
  add_keymap(item)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ General Keybinds ━━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for miscellaneous keybinds
for _, item in ipairs(data.keys.misc) do
  add_keymap(item)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━ Telescope Keybinds ━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for telescope symbols
for _, item in ipairs(data.keys.telescope.symbols) do
  add_keymap(item)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Resizing splits ━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for resizing splits
for _, map in ipairs(data.keys.splits.resize) do
  add_keymap(map[1], map[2], map[3], data.types.all_modes)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Moving between splits ━━━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for moving between splits
for _, map in ipairs(data.keys.splits.move) do
  add_keymap(map[1], map[2], map[3], data.types.all_modes)
end

--  ━━━━━━━━━━━━━━━━━━ Swapping buffers between windows ━━━━━━━━━━━━━━━
-- Add keymaps for swapping buffers
for _, map in ipairs(data.keys.splits.swap) do
  add_keymap(map[1], map[2], map[3], data.types.all_modes)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ MultiCursor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for multicursor
for _, item in ipairs(data.keys.multicursor) do
  add_keymap(item)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Overrides ━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for overrides
add_keymap(data.keys.overrides)

-- Replace '...' with '…' (ellipsis) on InsertLeave
data.func.setup_replace_ellipsis(true)

-- Search selected text in visual mode
add_keymap("/", "*", "Search selected text", "v")
