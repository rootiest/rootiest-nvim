-- Copyright (C) 2024 Chris Laprade (chris@rootiest.com)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
--
--          ██████╗  ██████╗  ██████╗ ████████╗██╗███████╗███████╗████████╗
--          ██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██║██╔════╝██╔════╝╚══██╔══╝
--          ██████╔╝██║   ██║██║   ██║   ██║   ██║█████╗  ███████╗   ██║
--          ██╔══██╗██║   ██║██║   ██║   ██║   ██║██╔══╝  ╚════██║   ██║
--          ██║  ██║╚██████╔╝╚██████╔╝   ██║   ██║███████╗███████║   ██║
--          ╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝   ╚═╝
--
--               ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
--               ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
--               ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
--               ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
--               ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
--               ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
--                ,l;             c,
--             .:ooool'           loo:.        /VVVVVVVV\++++  /VVVVVVVV\
--           .,oooooooo:.         looooc,      \VVVVVVVV/++++++\VVVVVVVV/
--          ll:,loooooool,        looooool      |VVVVVV|++++++++/VVVVV/'
--          llll,;ooooooooc.      looooooo      |VVVVVV|++++++/VVVVV/'
--          lllllc,coooooooo;     looooooo     +|VVVVVV|++++/VVVVV/'+
--          lllllll;,loooooool'   looooooo   +++|VVVVVV|++/VVVVV/'+++++
--          lllllllc .:oooooooo:. looooooo +++++|VVVVVV|/VVV___++++++++++
--          lllllllc   'loooooool,:ooooooo   +++|VVVVVVVVVV/##/ +_+_+_+
--          lllllllc     ;ooooooooc,cooooo     +|VVVVVVVVV___ +/#_#,#_#,\
--          lllllllc      .coooooooo;;looo      |VVVVVVV//##/+/#/+/#/'/#/
--          lllllllc        ,loooooool,:ol      |VVVVV/'+/#/+/#/+/#/ /#/
--           'cllllc         .:oooooooo;.       |VVV/'++/#/+/#/ /#/ /#/
--             .;llc           .loooo:.         'V/'  /##//##//##//###/
--                ,;             ;l;
--
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Rootiest NVim ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Configuration ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

-- ---------------------------------- LAZY -------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Bootstrap lazy.nvim
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

-- -------------------------------- DISABLED -----------------------------------
vim.g.loaded_perl_provider = 0

-- --------------------------------- PLUGINS -----------------------------------
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.ui.edgy" },
    { import = "lazyvim.plugins.extras.util.chezmoi" },
    { import = "lazyvim.plugins.extras.editor.aerial" },
    { import = "lazyvim.plugins.extras.editor.dial" },
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    { import = "lazyvim.plugins.extras.editor.outline" },
    { import = "lazyvim.plugins.extras.coding.codeium" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    --{ import = "lazyvim.plugins.extras.ui.alpha" },
    { import = "lazyvim.plugins.extras.util.gitui" },
    { import = "lazyvim.plugins.extras.util.octo" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.editor.fzf" },
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = {} },
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
})

-- ---------------------------------- STYLE ------------------------------------
require("config/style")

-- ------------------------------- CLIENT APPS ---------------------------------
if vim.g.neovide then
  -- ----------------------- Neovide -------------------------
  require("config/neovide")
end

-- -------------------------------- KEYBINDS -----------------------------------
require("config/keybinds")
