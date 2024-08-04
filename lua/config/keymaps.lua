-- -----------------------------------------------------------------------------
-- -------------------------------- KEYBINDS -----------------------------------
-- -----------------------------------------------------------------------------

-- --------------------------------- Keymaps -----------------------------------

-- Initialize which-key
local wk = require("which-key")
wk.add({
  { -- Toggle Terminal
    mode = "n",
    "<c-/>",
    ":ToggleTerm<cr>",
    desc = "Toggle Terminal",
  },
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
    cond = function()
      return pcall(require, "icon-picker")
    end,
  },
  -- Pick Icon
  {
    mode = "n",
    lhs = "<leader>Ii",
    rhs = "<cmd>IconPickerNormal<cr>",
    desc = "Pick Icon",
    group = "IconPicker",
    cond = function()
      return pcall(require, "icon-picker")
    end,
  },
  -- Yank Icon
  {
    mode = "n",
    lhs = "<leader>Iy",
    rhs = "<cmd>IconPickerYank<cr>",
    desc = "Yank Icon",
    group = "IconPicker",
    cond = function()
      return pcall(require, "icon-picker")
    end,
  },
  -- Insert Icon in insert mode
  {
    mode = "i",
    lhs = "<C-i>",
    rhs = "<cmd>IconPickerInsert<cr>",
    desc = "Insert Icon",
    group = "IconPicker",
    cond = function()
      return pcall(require, "icon-picker")
    end,
  },
  -- Gists group
  {
    mode = "n",
    lhs = "<leader>gn",
    group = "Gists",
    icon = { icon = "", color = "orange" },
    cond = function()
      return pcall(require, "gist")
    end,
  },
  -- Create Gist
  {
    mode = { "n", "x" },
    lhs = "<leader>gnc",
    rhs = "<cmd>GistCreate<cr>",
    desc = "Create Gist",
    cond = function()
      return pcall(require, "gist")
    end,
  },
  -- Find Gists
  {
    mode = "n",
    lhs = "<leader>gnf",
    rhs = "<cmd>GistList<cr>",
    desc = "Find Gists",
    cond = function()
      return pcall(require, "gist")
    end,
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
  -- Save selected code snapshot into clipboard
  {
    mode = "x",
    lhs = "<leader>cy",
    rhs = "<cmd>CodeSnap<cr>",
    desc = "Save selected code snapshot into clipboard",
    cond = function()
      return pcall(require, "codesnap")
    end,
  },
  -- Save selected code snapshot in ~/Pictures
  {
    mode = "x",
    lhs = "<leader>cs",
    rhs = "<cmd>CodeSnapSave<cr>",
    desc = "Save selected code snapshot in ~/Pictures",
    cond = function()
      return pcall(require, "codesnap")
    end,
  },
  -- Highlight and snapshot selected code into clipboard
  {
    mode = "x",
    lhs = "<leader>ch",
    rhs = "<cmd>CodeSnapHighlight<cr>",
    desc = "Highlight and snapshot selected code into clipboard",
    cond = function()
      return pcall(require, "codesnap")
    end,
  },
  -- Save ASCII code snapshot into clipboard
  {
    mode = "x",
    lhs = "<leader>ci",
    rhs = "<cmd>CodeSnapASCII<cr>",
    desc = "Save ASCII code snapshot into clipboard",
    cond = function()
      return pcall(require, "codesnap")
    end,
  },
  {
    "gx",
    "<cmd>Browse<cr>",
    mode = { "n", "x" },
    desc = "Open URL/Link",
  },
  {
    "<leader>lg",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit",
  },
  {
    "<leader>fs",
    rhs = function()
      require("rip-substitute").sub()
    end,
    mode = { "n", "x" },
    desc = "Rip Substitute",
  },
  {
    "<c-s-h>",
    rhs = function()
      require("kitty-navigator").navigateLeft()
    end,
    desc = "KittyNavigateLeft",
    cond = function() -- Using Kitty
      return require("config.rootiest").using_kitty()
    end,
  },
  {
    "<c-s-j>",
    rhs = function()
      require("kitty-navigator").navigateDown()
    end,
    desc = "KittyNavigateDown",
    cond = function() -- Using Kitty
      return require("config.rootiest").using_kitty()
    end,
  },
  {
    "<c-s-k>",
    rhs = function()
      require("kitty-navigator").navigateUp()
    end,
    desc = "KittyNavigateUp",
    cond = function() -- Using Kitty
      return require("config.rootiest").using_kitty()
    end,
  },
  {
    "<c-s-l>",
    rhs = function()
      require("kitty-navigator").navigateRight()
    end,
    desc = "KittyNavigateRight",
    cond = function() -- Using Kitty
      return require("config.rootiest").using_kitty()
    end,
  },
  {
    "zk",
    rhs = function()
      require("config.rootiest").toggle_precognition()
    end,
    desc = "Toggle Precognition",
  },
  {
    "<leader>a",
    "<cmd>Alternate<cr>",
    desc = "Toggle Alternate",
    cond = function()
      return (
        vim.bo.filetype == "c"
        or vim.bo.filetype == "h"
        or vim.bo.filetype == "cpp"
        or vim.bo.filetype == "hpp"
      )
    end,
  },
  {
    "<leader>wt",
    rhs = function()
      require("transparent").toggle()
    end,
    desc = "Toggle Transparency",
  },
  {
    mode = "x",
    lhs = "<leader>r",
    rhs = function()
      require("substitute").visual()
    end,
    desc = "Substitute",
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
  { -- Toggle ZenMode
    "<leader>z",
    rhs = function()
      require("zen-mode").toggle()
    end,
    desc = "Toggle ZenMode",
  },
  -- Substitute operator in normal mode
  {
    mode = "n",
    lhs = "x",
    rhs = function()
      require("substitute").operator()
    end,
    desc = "Substitute operator",
    cond = function()
      return pcall(require, "substitute")
    end,
  },
  -- Substitute line in normal mode
  {
    mode = "n",
    lhs = "xx",
    rhs = function()
      require("substitute").line()
    end,
    desc = "Substitute line",
    cond = function()
      return pcall(require, "substitute")
    end,
  },
  -- Substitute end of line in normal mode
  {
    mode = "n",
    lhs = "X",
    rhs = function()
      require("substitute").eol()
    end,
    desc = "Substitute end of line",
    cond = function()
      return pcall(require, "substitute")
    end,
  },
  -- Substitute visual selection in visual mode
  {
    mode = "x",
    lhs = "x",
    rhs = function()
      require("substitute").visual()
    end,
    desc = "Substitute visual selection",
    cond = function()
      return pcall(require, "substitute")
    end,
  },
  { "<leader>u,", group = "Font" },
  { "<leader>u,l", "<cmd>Nekifoch list<cr>", desc = "Fonts list" },
  {
    "<leader>u,c",
    "<cmd>Nekifoch check<cr>",
    desc = "Check current font settings",
  },
  {
    "<leader>u,f",
    rhs = function()
      require("nekifoch.nui_set_font")()
    end,
    desc = "Set font family",
  },
  {
    "<leader>u,s",
    rhs = function()
      require("nekifoch.nui_set_size")()
    end,
    desc = "Set font size",
  },
  { -- Yank buffer contents
    "<leader>Y",
    "<cmd>%y<cr>",
    desc = "Yank buffer contents",
  },
})
