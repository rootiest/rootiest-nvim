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

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ General Keybinds ━━━━━━━━━━━━━━━━━━━━━━━

-- Add keymaps for miscellaneous keybinds
for _, item in ipairs(data.keys.misc) do
  add_keymap(item)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Group Keybinds ━━━━━━━━━━━━━━━━━━━━━━━━

-- Add keymaps for menu groups
for _, item in ipairs(data.keys.groups) do
  add_keymap(item)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Resizing splits ━━━━━━━━━━━━━━━━━━━━━━━━━━━

for _, map in ipairs(data.keys.splits.resize) do
  add_keymap(map[1], map[2], map[3], data.types.all_modes)
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Moving between splits ━━━━━━━━━━━━━━━━━━━━━━━━

for _, map in ipairs(data.keys.splits.move) do
  add_keymap(map[1], map[2], map[3], data.types.all_modes)
end

--  ━━━━━━━━━━━━━━━━━━ Swapping buffers between windows ━━━━━━━━━━━━━━━

for _, map in ipairs(data.keys.splits.swap) do
  add_keymap(map[1], map[2], map[3], data.types.all_modes)
end
