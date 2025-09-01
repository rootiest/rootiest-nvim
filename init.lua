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

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ PROFILING ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Load profiling package if startup profiler triggered
require('config.profiler')

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROOTIEST ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Rootiest Configuration
require('config.rootiest').setup() -- Set up Rootiest options

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ LAZY ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Load Lazy package manager and plugins
require('config.lazy') -- Bootstrap lazy.nvim and initialize plugins

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROCKS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Load LuaRocks package manager and plugins
require('config.rocks') -- Bootstrap LuaRocks and initialize plugins

--          ╔═════════════════════════════════════════════════════════╗
--          ║                 CONFIGURATION STRUCTURE                 ║
--          ╚═════════════════════════════════════════════════════════╝
--    ╭─────────────────────────────────────────────────────────────────────╮
--    │   Configuration modules are organized into categories:              │
--    │    - Options                                                        │
--    │    - Keymaps                                                        │
--    │    - Autocommands                                                   │
--    │    - Utility functions                                              │
--    │    - Plugins                                                        │
--    │    - Commands                                                       │
--    │    - Dashboards                                                     │
--    │    - Types                                                          │
--    │    - Dependencies                                                   │
--    ╰─────────────────────────────────────────────────────────────────────╯
---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ OPTIONS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Neovim options are configured in the lua/config/options.lua file

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ KEYMAPS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Keymaps are configured in the lua/data/keys.lua file

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ AUTOCOMMANDS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Autocommands are configured in the lua/config/autocmds.lua file

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ UTILITY FUNCTIONS ━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Utility functions can be found in the lua/data/func.lua file

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ PLUGINS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Plugin specs are defined in the lua/config/plugins.lua file
-- Plugin keys, cmds, dependencies, and opts/config tables are
-- defined in the lua/data/*.lua files. All plugin configurations
-- are defined in a centralized location to keep them organised.

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ COMMANDS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- User and plugin commands are configured in the lua/data/cmds.lua file

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ DASHBOARDS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Dashboard configurations can be found in the lua/data/dash.lua file

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ TYPES ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Plugin configuration tables are located in the lua/data/types.lua file

---━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ DEPENDENCIES ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Plugin depenendencies are defined in the lua/data/deps.lua file
