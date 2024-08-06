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
    "<leader>h",
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
