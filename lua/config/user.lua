-- -----------------------------------------------------------------------------
-- --------------------------------- OPTIONS -----------------------------------
-- -----------------------------------------------------------------------------

-- ----------------------------------- LSP --------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.lazyvim_python_lsp = "basedpyright"

-- ---------------------------------- STYLE ------------------------------------
-- Apply the colorscheme
vim.cmd.colorscheme(STORED_THEME or KITTY_THEME or "catppuccin-frappe")

-- ------------------------------- CLIENT APPS ---------------------------------
if vim.g.neovide then
  -- ----------------------- Neovide -------------------------
  require("config.neovide")
end

-- -------------------------------- KEYBINDS -----------------------------------
require("config.keybinds")