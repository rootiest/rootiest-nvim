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
-- local add_km = require("which-key").add

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

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Overrides ━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Add keymaps for overrides
add_keymap(data.keys.overrides)

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Custom Mappings ━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Visual mode: Move selected block of text up
add_keymap("K", function()
  data.func.move_visual(true)
end, "Move block of text up", "v")

-- Visual mode: Move selected block of text down
add_keymap("J", function()
  data.func.move_visual(false)
end, "Move block of text down", "v")

-- Test Prompt: Enter your name
add_keymap("<leader>qP", function()
  data.func.InputPrompt("Enter your name: ", function(input)
    if input then
      -- trim whitespace from end of input
      input = input:gsub("%s+$", "")
      print("👋😎 Hello " .. input .. "!")
    else
      print("Input was canceled")
    end
  end)
end, "Test Prompt")
