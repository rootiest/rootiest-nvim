--          ╭─────────────────────────────────────────────────────────╮
--          │                        Keybinds                         │
--          ╰─────────────────────────────────────────────────────────╯
-- Initialize which-key
local wk = require("which-key")
local rootiest = require("config.rootiest")
local smartsplits = require("smart-splits")

local all_modes = { "n", "i", "v", "x", "s", "o", "c", "t" }

-- Helper function to add keymaps with common properties
local function add_keymap(lhs, rhs, desc, modes)
  wk.add({
    {
      lhs,
      rhs = rhs,
      desc = desc,
      mode = modes or "n", -- default to normal mode if not specified
    },
  })
end

-- General Keybinds
add_keymap("<leader>gt", function()
  rootiest.toggle_lazygit_term()
end, "LazyGit Terminal")
add_keymap("yo", function()
  rootiest.yank_line()
end, "Yank Line-text")
add_keymap("<leader>uH", function()
  rootiest.toggle_hardmode()
end, "Toggle Hardmode")
add_keymap("<leader>Y", "<cmd>%y<cr>", "Yank buffer contents")
add_keymap("|", "<cmd>Neotree reveal<cr>", "Neotree reveal")

-- Group Keybinds
wk.add({
  {
    lhs = "<leader>I",
    group = "IconPicker",
    icon = { icon = "󰥸", color = "orange" },
  },
  {
    lhs = "<leader>gn",
    group = "Gists",
    icon = { icon = "", color = "orange" },
  },
  {
    lhs = "<leader>l",
    group = "Lazy",
  },
  {
    "<leader>lv",
    "<cmd>Lazy<cr>",
    desc = "LazyVim",
  },
  {
    "<leader>lx",
    "<cmd>LazyExtras<cr>",
    desc = "LazyExtras",
  },
  {
    lhs = "<leader>m",
    group = "MiniMap",
    icon = { icon = "", color = "yellow" },
  },
  { "<leader>u,", group = "Font" },
})

-- Resizing splits
local resize_splits = {
  {
    "<A-h>",
    function()
      smartsplits.resize_left()
    end,
    "Resize split left",
  },
  {
    "<A-j>",
    function()
      smartsplits.resize_down()
    end,
    "Resize split down",
  },
  {
    "<A-k>",
    function()
      smartsplits.resize_up()
    end,
    "Resize split up",
  },
  {
    "<A-l>",
    function()
      smartsplits.resize_right()
    end,
    "Resize split right",
  },
}

for _, map in ipairs(resize_splits) do
  add_keymap(map[1], map[2], map[3], all_modes)
end

-- Moving between splits
local move_splits = {
  {
    "<C-S-h>",
    function()
      smartsplits.move_cursor_left()
    end,
    "Move cursor left",
  },
  {
    "<C-S-j>",
    function()
      smartsplits.move_cursor_down()
    end,
    "Move cursor down",
  },
  {
    "<C-S-k>",
    function()
      smartsplits.move_cursor_up()
    end,
    "Move cursor up",
  },
  {
    "<C-S-l>",
    function()
      smartsplits.move_cursor_right()
    end,
    "Move cursor right",
  },
  {
    "<C-\\>",
    function()
      smartsplits.move_cursor_previous()
    end,
    "Move cursor to previous split",
  },
}

for _, map in ipairs(move_splits) do
  add_keymap(map[1], map[2], map[3], all_modes)
end

-- Swapping buffers between windows
local swap_buffers = {
  {
    "<A-S-h>",
    function()
      smartsplits.swap_buf_left()
    end,
    "Swap buffer left",
  },
  {
    "<A-S-j>",
    function()
      smartsplits.swap_buf_down()
    end,
    "Swap buffer down",
  },
  {
    "<A-S-k>",
    function()
      smartsplits.swap_buf_up()
    end,
    "Swap buffer up",
  },
  {
    "<A-S-l>",
    function()
      smartsplits.swap_buf_right()
    end,
    "Swap buffer right",
  },
}

for _, map in ipairs(swap_buffers) do
  add_keymap(map[1], map[2], map[3], all_modes)
end
