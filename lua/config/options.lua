-- -----------------------------------------------------------------------------
-- --------------------------------- OPTIONS -----------------------------------
-- -----------------------------------------------------------------------------

-- Set Default Leader Key
vim.g.mapleader = " "

-- Correct missing settings files
require("config.check-files")

-- Load Stored Leader Key
vim.g.mapleader = vim.fn.readfile(vim.fn.stdpath("config") .. "/.leader")[1]

-- Load the stored colorscheme
STORED_THEME = vim.fn.readfile(vim.fn.stdpath("config") .. "/.colorscheme")[1]

-- ----------------------------------- LSP --------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.lazyvim_python_lsp = "basedpyright"

-- ----------------------------------- FOLDS --------------------------------------
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99 -- load buffers with folds open

-- ------------------------------- CLIENT APPS ---------------------------------
if vim.g.neovide then
  -- ----------------------- Neovide -------------------------
  require("config.neovide")
end
