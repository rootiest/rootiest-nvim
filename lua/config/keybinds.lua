-- -----------------------------------------------------------------------------
-- -------------------------------- KEYBINDS -----------------------------------
-- -----------------------------------------------------------------------------

-- --------------------------------- Keymaps -----------------------------------
vim.keymap.set( -- Explorer
  "n",
  "E",
  "<cmd>lua require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() })<cr>"
)

-- -------------------------------- Commands -----------------------------------
-- Make :Q close all of the buffers
vim.api.nvim_create_user_command("Q", function()
  vim.cmd.bdelete()
  vim.cmd.qall()
end, { force = true })

-- ------------------------------- Leader Maps ---------------------------------
local wk = require("which-key")
local opts = { noremap = true, silent = true }
wk.add({
  {
    "<leader>gS",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit",
  },
  {
    "<leader>gn",
    group = "Gists",
    icon = { icon = "", color = "orange" },
  },
  {
    "<leader>gnc",
    "<cmd>GistCreate<cr>",
    desc = "Create Gist",
  },
  {
    "<leader>gnf",
    "<cmd>GistList<cr>",
    desc = "Find Gists",
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
  {
    "<leader>I",
    group = "IconPicker",
    icon = { icon = "󰥸", color = "orange" },
  },
})

-- ---------------------------- Spell Correction -------------------------------
require("config/spellcheck")
