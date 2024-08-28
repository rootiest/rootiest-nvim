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
--          ██████╔╝██║   ██║██║   ██║   ██║   ██║█████╗  ███████╗   ██
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
--               ,;             ;l;           'V/'  /##//##//##//###/
--
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Rootiest NVim ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Configuration ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
--                       The rootiest NeoVim configuration!

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ OPTIONS ━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Options are configured in the lua/config/options.lua file

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROOTIEST ━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Rootiest Configuration
require("config.rootiest").setup()

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ LAZY ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Load Lazy package manager and plugins
require("config.lazy")

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROCKS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Load LuaRocks package manager and plugins
require("config.rocks")

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ PROFILING ━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Load profiling package
require("config.profile")

-- Profiling options:     Set by environment variable
--   ──────────────────────────────────────────────────────────────────────
--   NVIM_PROFILE=1                       Start profiling at startup
--   NVIM_PROFILE_MODILE="lualine"        Set profiling target to lualine
--   ──────────────────────────────────────────────────────────────────────

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ KEYMAPS ━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Keymaps are configured in the lua/config/keymaps.lua file
