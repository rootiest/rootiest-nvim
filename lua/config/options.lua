-- -----------------------------------------------------------------------------
-- --------------------------------- OPTIONS -----------------------------------
-- -----------------------------------------------------------------------------

-- Leader Key
vim.g.mapleader = " "

-- ----------------------------------- LSP --------------------------------------
-- We don't need perl
vim.g.loaded_perl_provider = 0
-- Prefer basedpyright
vim.g.lazyvim_python_lsp = "basedpyright"

-- --------------------------------- GIT-BLAME ----------------------------------
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text

-- --------------------------------- ROOTIEST -----------------------------------
vim.g.aitool = "codeium"
vim.g.usewakatime = true
vim.g.usehardtime = false
vim.g.useimage = true
vim.o.background = "dark"
vim.g.DashboardHeaderColor = "#A6E3A1"
