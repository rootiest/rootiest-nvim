-- -----------------------------------------------------------------------------
-- ------------------------------- Icon Picker ---------------------------------
-- -----------------------------------------------------------------------------

return {
  "ziontee113/icon-picker.nvim",
  config = function()
    require("icon-picker").setup({ disable_legacy_commands = true })
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<Leader>Ii", "<cmd>Pick Icon<cr>", opts)
    vim.keymap.set("n", "<Leader>Iy", "<cmd>Yank Icon<cr>", opts)
    vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
  end,
}
