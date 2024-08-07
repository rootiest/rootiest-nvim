--          ╭─────────────────────────────────────────────────────────╮
--          │                        Keybinds                         │
--          ╰─────────────────────────────────────────────────────────╯
-- Initialize which-key
local wk = require("which-key")
wk.add({
  { -- Open LazyGit in terminal
    "<leader>gt",
    rhs = function()
      require("config.rootiest").toggle_lazygit_term()
    end,
    desc = "LazyGit Terminal",
  },
  -- Icon Picker group
  {
    mode = "n",
    lhs = "<leader>I",
    group = "IconPicker",
    icon = { icon = "󰥸", color = "orange" },
  },
  -- Gists group
  {
    mode = "n",
    lhs = "<leader>gn",
    group = "Gists",
    icon = { icon = "", color = "orange" },
  },
  { -- Lazy group
    "<leader>l",
    group = "Lazy",
  },
  { -- LazyVim
    "<leader>lv",
    "<cmd>Lazy<cr>",
    desc = "LazyVim",
  },
  { -- LazyExtras
    "<leader>lx",
    "<cmd>LazyExtras<cr>",
    desc = "LazyExtras",
  },
  { -- MiniMap
    "<leader>m",
    group = "MiniMap",
    icon = { icon = "", color = "yellow" },
  },
  {
    "yo",
    rhs = function()
      require("config.rootiest").yank_line()
    end,
    desc = "Yank Line-text",
  },
  { -- Toggle Hardmode with Hints
    "<leader>uH",
    rhs = function()
      require("config.rootiest").toggle_hardmode()
    end,
    desc = "Toggle Hardmode",
  },
  { "<leader>u,", group = "Font" },
  { -- Yank buffer contents
    "<leader>Y",
    "<cmd>%y<cr>",
    desc = "Yank buffer contents",
  },
})

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ smart-splits ━━━━━━━━━━━━━━━━━━━━━━━━━
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-S-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-S-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-S-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-S-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("t", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("t", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("t", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("t", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("t", "<C-S-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("t", "<C-S-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("t", "<C-S-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("t", "<C-S-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("t", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("t", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("t", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("t", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("t", "<leader><leader>l", require("smart-splits").swap_buf_right)
