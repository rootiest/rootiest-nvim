-- -----------------------------------------------------------------------------
-- -------------------------------- KEYBINDS -----------------------------------
-- -----------------------------------------------------------------------------

-- --------------------------------- Keymaps -----------------------------------

local substitute_loaded, substitute = pcall(require, "substitute")
local codesnap_loaded = pcall(require, "codesnap")
local icon_picker_loaded = pcall(require, "icon-picker")
local gist_loaded = pcall(require, "gist")
local rootiest = require("rootiest")

local wk = require("which-key")
wk.add({
  {
    "<c-/>",
    ":ToggleTerm<cr>",
    desc = "Toggle Terminal",
  },
  {
    "<leader>gt",
    rhs = function()
      rootiest.toggle_lazygit_term()
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
      return icon_picker_loaded
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
      return icon_picker_loaded
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
      return icon_picker_loaded
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
      return icon_picker_loaded
    end,
  },
  {
    "<leader>gS",
    rhs = function()
      require("lazygit").lazygit()
    end,
    desc = "LazyGit",
  },
  -- Gists group
  {
    mode = "n",
    lhs = "<leader>gn",
    group = "Gists",
    icon = { icon = "", color = "orange" },
    cond = function()
      return gist_loaded
    end,
  },
  -- Create Gist
  {
    mode = { "n", "x" },
    lhs = "<leader>gnc",
    rhs = "<cmd>GistCreate<cr>",
    desc = "Create Gist",
    cond = function()
      return gist_loaded
    end,
  },
  -- Find Gists
  {
    mode = "n",
    lhs = "<leader>gnf",
    rhs = "<cmd>GistList<cr>",
    desc = "Find Gists",
    cond = function()
      return gist_loaded
    end,
  },
  {
    "<leader>l",
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
      return codesnap_loaded
    end,
  },
  -- Save selected code snapshot in ~/Pictures
  {
    mode = "x",
    lhs = "<leader>cs",
    rhs = "<cmd>CodeSnapSave<cr>",
    desc = "Save selected code snapshot in ~/Pictures",
    cond = function()
      return codesnap_loaded
    end,
  },
  -- Highlight and snapshot selected code into clipboard
  {
    mode = "x",
    lhs = "<leader>ch",
    rhs = "<cmd>CodeSnapHighlight<cr>",
    desc = "Highlight and snapshot selected code into clipboard",
    cond = function()
      return codesnap_loaded
    end,
  },
  -- Save ASCII code snapshot into clipboard
  {
    mode = "x",
    lhs = "<leader>ci",
    rhs = "<cmd>CodeSnapASCII<cr>",
    desc = "Save ASCII code snapshot into clipboard",
    cond = function()
      return codesnap_loaded
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
      return rootiest.using_kitty()
    end,
  },
  {
    "<c-s-j>",
    rhs = function()
      require("kitty-navigator").navigateDown()
    end,
    desc = "KittyNavigateDown",
    cond = function() -- Using Kitty
      return rootiest.using_kitty()
    end,
  },
  {
    "<c-s-k>",
    rhs = function()
      require("kitty-navigator").navigateUp()
    end,
    desc = "KittyNavigateUp",
    cond = function() -- Using Kitty
      return rootiest.using_kitty()
    end,
  },
  {
    "<c-s-l>",
    rhs = function()
      require("kitty-navigator").navigateRight()
    end,
    desc = "KittyNavigateRight",
    cond = function() -- Using Kitty
      return rootiest.using_kitty()
    end,
  },
  {
    "zk",
    rhs = function()
      rootiest.toggle_precognition()
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
      rootiest.yank_line()
    end,
    desc = "Yank Line-text",
  },
  { -- Toggle Hardmode with Hints
    "<leader>h",
    rhs = function()
      rootiest.toggle_hardmode()
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
      substitute.operator()
    end,
    desc = "Substitute operator",
    cond = function()
      return substitute_loaded
    end,
  },
  -- Substitute line in normal mode
  {
    mode = "n",
    lhs = "xx",
    rhs = function()
      substitute.line()
    end,
    desc = "Substitute line",
    cond = function()
      return substitute_loaded
    end,
  },
  -- Substitute end of line in normal mode
  {
    mode = "n",
    lhs = "X",
    rhs = function()
      substitute.eol()
    end,
    desc = "Substitute end of line",
    cond = function()
      return substitute_loaded
    end,
  },
  -- Substitute visual selection in visual mode
  {
    mode = "x",
    lhs = "x",
    rhs = function()
      substitute.visual()
    end,
    desc = "Substitute visual selection",
    cond = function()
      return substitute_loaded
    end,
  },
})
