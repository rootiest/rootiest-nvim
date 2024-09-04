--- @module "config.options"
--- This module defines the user options for the Neovim configuration.
--- Variables defined here set configuration options for the rest
--- of the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Options                         │
--          ╰─────────────────────────────────────────────────────────╯
-- stylua: ignore start

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Leader Key ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.mapleader      = " " ---@type string Options: <leader>
vim.g.maplocalleader = " " ---@type string Options: <localleader>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ LSP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- We don't need perl
vim.g.loaded_perl_provider = 0 ---@type integer Options: <0|1>
vim.g.loaded_ruby_provider = 0 ---@type integer Options: <0|1>
-- Prefer basedpyright
vim.g.lazyvim_python_lsp = "basedpyright" ---@type string Options: [python lsp]

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ OS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Check if we are on windows
vim.g.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROOTIEST ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.usewakatime     =  true          ---@type boolean Options:  <true|false>
vim.g.usemusic        =  true          ---@type boolean Options:  <true|false>
vim.g.usehardtime     =  false         ---@type boolean Options:  <true|false>
vim.g.useimage        =  true          ---@type boolean Options:  <true|false>
vim.g.ignore_no_lazy  =  false         ---@type boolean Options:  <true|false>
vim.g.codesnap        =  true          ---@type boolean Options:  <true|false>
vim.g.auto_cursorline =  true          ---@type boolean Options: <true|false>
vim.g.auto_save       =  true          ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ AI TOOL ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.aitool          = "codeium"      ---@type string Options: [ai tool]
--        ╭───────────────────────────╮                codeium
--        │                           │                copilot
--        │         AI Tools:         │                tabnine
--        │   Choose an AI provider   │                minuet
--        │      from the list       │                ollama
--        │                           │                none
--        ╰───────────────────────────╯

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ STATUS LINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.statusline      = "lualine"      ---@type string Options: [statusline]
--        ╭───────────────────────────╮                lualine
--        │                           │                heirline
--        │      Status Lines:        │                basic
--        │   Choose a plugin from    │                none
--        │      the list            │
--        │                           │
--        ╰───────────────────────────╯
--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ STATUS COLUMN ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.statuscolumn    = "native"       ---@type string Options: [statuscolumn]
--        ╭───────────────────────────╮                barsNlines
--        │                           │                native
--        │      Status Columns:      │
--        │   Choose a plugin from    │
--        │      the list            │
--        │                           │
--        ╰───────────────────────────╯
--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ BUFFER LINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.tabline         = "bufferline"   ---@type string Options: [tabline]
--        ╭───────────────────────────╮                bufferline
--        │                           │                barsNlines
--        │      Tab Lines:           │                none
--        │   Choose a plugin from    │
--        │      the list            │
--        │                           │
--        ╰───────────────────────────╯
vim.g.statusline_clickable_git = false ---@type boolean Options: <true|false>
vim.g.stats_wakatime           = true  ---@type boolean Options: <true|false>
vim.g.stats_music              = true  ---@type boolean Options: <true|false>
vim.g.stats_ignored_players    = {     ---@type string[] Options: [ignored players]
  "chromium",
  "firefox",
  "kdeconnect",
  "haruna",
  "plasma-browser-integration",
  "plasma-browser-integration-76042",
}

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ COLOR ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Background color
vim.o.background           = "dark"    ---@type string Options: <dark|light>
--  Dashboard header color
vim.g.DashboardHeaderColor = "#88fc9a"---@type string Options: [hex color]
-- Disable Transparency
vim.g.disable_transparency = true      ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Completion ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Cmp Window Border
vim.g.completion_round_borders_enabled = true  ---Options: <true|false>
-- stylua: ignore end
