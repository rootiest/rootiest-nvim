-- -----------------------------------------------------------------------------
-- ---------------------------------- LAZY -------------------------------------
-- -----------------------------------------------------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	-- stylua: ignore
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- --------------------------------- PLUGINS -----------------------------------
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "ui" }, -- UI Plugins
    { import = "plugins" }, -- General Plugins
    { import = "themes" }, -- Theme Plugins
  },
  defaults = { lazy = false, version = false },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  profiling = {
    -- Track the time spent loading plugins
    loader = true,
    require = true,
  },
})
