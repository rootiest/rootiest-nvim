-- -----------------------------------------------------------------------------
-- -------------------------------- KEYBINDS -----------------------------------
-- -----------------------------------------------------------------------------
-- Make :Q close all of the buffers
vim.api.nvim_create_user_command("Q", function()
  vim.cmd.bdelete()
  vim.cmd.qall()
end, { force = true })

-- Panel Navigation
vim.api.nvim_set_keymap(
  "n",
  "<A-Left>",
  [[<Cmd>wincmd h<CR>]],
  { noremap = true, desc = " Go to Window Left" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-Up>",
  [[<Cmd>wincmd j<CR>]],
  { noremap = true, desc = " Go to Window Up" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-Down>",
  [[<Cmd>wincmd k<CR>]],
  { noremap = true, desc = " Go to Window Down" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-Right>",
  [[<Cmd>wincmd l<CR>]],
  { noremap = true, desc = " Go to Window Right" }
)

-- Terminal navigation
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end