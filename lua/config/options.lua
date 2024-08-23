--          ╭─────────────────────────────────────────────────────────╮
--          │                         Options                         │
--          ╰─────────────────────────────────────────────────────────╯
-- stylua: ignore start
-- Leader Key
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

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ USER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.o.background = "dark"              --- @type string Options: <dark|light>
vim.g.DashboardHeaderColor = "#88fc9a" --- @type string Options: [hex color]

-- BLINKY CURSOR
vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor",         -- Block cursor in normal, visual, and command modes
  "i:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",  -- Blinking vertical line in insert mode
  "r-cr-o:hor20-Cursor/lCursor",        -- Horizontal line cursor in replace, command-line replace, and operator-pending modes
  "a:blinkwait700-blinkoff400-blinkon250",  -- Global blinking settings for all modes
}
-- stylua: ignore end
