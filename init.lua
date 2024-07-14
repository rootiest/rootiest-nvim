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
--              ,l;             c,
--            .:ooool'           loo:.
--          .,oooooooo:.         looooc,       /VVVVVVVV\++++  /VVVVVVVV\
--         ll:,loooooool,        looooool      \VVVVVVVV/++++++\VVVVVVVV/
--         llll,;ooooooooc.      looooooo       |VVVVVV|++++++++/VVVVV/'
--         lllllc,coooooooo;     looooooo       |VVVVVV|++++++/VVVVV/'
--         lllllll;,loooooool'   looooooo      +|VVVVVV|++++/VVVVV/'+
--         lllllllc .:oooooooo:. looooooo    +++|VVVVVV|++/VVVVV/'+++++
--         lllllllc   'loooooool,:ooooooo  +++++|VVVVVV|/VVV___++++++++++
--         lllllllc     ;ooooooooc,cooooo    +++|VVVVVVVVVV/##/ +_+_+_+
--         lllllllc      .coooooooo;;looo      +|VVVVVVVVV___ +/#_#,#_#,\
--         lllllllc        ,loooooool,:ol       |VVVVVVV//##/+/#/+/#/'/#/
--          'cllllc         .:oooooooo;.        |VVVVV/'+/#/+/#/+/#/ /#/
--            .;llc           .loooo:.          |VVV/'++/#/+/#/ /#/ /#/
--               ,;             ;l;             'V/'  /##//##//##//###/
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
    { import = "ui" },
    { import = "plugins" },
    { import = "themes" },
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
