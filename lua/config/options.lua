--          ╭─────────────────────────────────────────────────────────╮
--          │                         Options                         │
--          ╰─────────────────────────────────────────────────────────╯
-- stylua: ignore start

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Leader Key ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.mapleader      = " " --- @type string Options: <leader>
vim.g.maplocalleader = " " --- @type string Options: <localleader>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ LSP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- We don't need perl
vim.g.loaded_perl_provider = 0 --- @type integer Options: <0|1>
vim.g.loaded_ruby_provider = 0 --- @type integer Options: <0|1>
-- Prefer basedpyright
vim.g.lazyvim_python_lsp = "basedpyright" --- @type string Options: [python lsp]

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ OS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Check if we are on windows
vim.g.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROOTIEST ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--        ╭───────────────────────────╮      Options:
--        │                           │               codeium
--        │         AI Tools:         │               copilot
--        │   Choose an AI provider   │               tabnine
--        │      from the list       │               minuet
--        │                           │               ollama
--        ╰───────────────────────────╯               none
 vim.g.aitool      = "codeium" --- @type string Options: [ai tool]

vim.g.usewakatime =  true  --- @type boolean Options:  <true|false>
vim.g.usehardtime =  false --- @type boolean Options:  <true|false>
vim.g.useimage    =  true  --- @type boolean Options:  <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ COLOR ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Background color
vim.o.background           = "dark"    --- @type string Options: <dark|light>
--  Dashboard header color
vim.g.DashboardHeaderColor = "#88fc9a" --- @type string Options: [hex color]
-- Disable Transparency
vim.g.disable_transparency = true      --- @type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ BLINKY CURSOR ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Setup the blinky cursor
require("utils.blinky").enable()

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ OTHER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Suda smart edit: Automatically edit files in sudo mode when needed
vim.g.suda_smart_edit      = 1         --- @type integer Options: <0|1>
vim.cmd("let g:suda#prompt = '   Enter Sudo Password  '")
-- Cmp Window Border
vim.g.completion_round_borders_enabled = true
-- stylua: ignore end
