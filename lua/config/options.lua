-- -----------------------------------------------------------------------------
-- --------------------------------- OPTIONS -----------------------------------
-- -----------------------------------------------------------------------------

-- Set Default Leader Key
vim.g.mapleader = " "

-- Restore Leader Key
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.leader") == 1 then
  -- Load Stored Leader Key
  vim.g.mapleader = vim.fn.readfile(vim.fn.stdpath("config") .. "/.leader")[1]
end

-- Restore Colorscheme to variable
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.colorscheme") == 1 then
  -- Load the stored colorscheme
  STORED_THEME = vim.fn.readfile(vim.fn.stdpath("config") .. "/.colorscheme")[1]
else
  -- Get the kitty theme
  if os.getenv("KITTY_THEME") then
    KITTY_THEME = os.getenv("KITTY_THEME")
  end
end

-- ----------------------------------- LSP --------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.lazyvim_python_lsp = "basedpyright"

-- ------------------------------- CLIENT APPS ---------------------------------
if vim.g.neovide then
  -- ----------------------- Neovide -------------------------
  require("config.neovide")
end