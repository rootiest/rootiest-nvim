-- -------------------------------- Commands -----------------------------------
-- Make :Q close all of the buffers
vim.api.nvim_create_user_command("Q", function()
  vim.cmd.bdelete()
  vim.cmd.qall()
end, { force = true })

-- ------------------------------ Auto-Commands --------------------------------
-- Autosave Colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Store colorscheme name",
  callback = function()
    print("colorscheme:", vim.g.colors_name)
    vim.fn.writefile(
      { vim.g.colors_name },
      vim.fn.stdpath("config") .. "/.colorscheme"
    )
  end,
})
