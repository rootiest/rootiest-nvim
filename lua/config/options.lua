--- @module "config.options"
--- This module defines the user options for the Neovim configuration.
--- Variables defined here set configuration options for the rest
--- of the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Options                         │
--          ╰─────────────────────────────────────────────────────────╯
-- stylua: ignore start

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Key Options ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.mapleader = " "                  ---@type string Options: <leader>
vim.g.maplocalleader = " "             ---@type string Options: <localleader>
-- vim.g.timeoutlen        = 1000      ---@type integer Options: <ms>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ LSP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- We don't need perl
vim.g.loaded_perl_provider = 0         ---@type integer Options: <0|1>
-- or ruby
vim.g.loaded_ruby_provider = 0         ---@type integer Options: <0|1>
-- Prefer basedpyright for python
vim.g.lazyvim_python_lsp   = "pyright" ---@type string Options: [python lsp]
-- Open all folds by default
vim.opt.foldlevel          = 99        ---@type integer Options: <0-99>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROOTIEST ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Use WakaTime for code stats
vim.g.usewakatime     =  true          ---@type boolean Options:  <true|false>
-- Allow music controls and stats
vim.g.usemusic        =  false         ---@type boolean Options:  <true|false>
-- Enable HardTime on startup
vim.g.usehardtime     =  false         ---@type boolean Options:  <true|false>
-- Enable Image plugin on compatible terminals
vim.g.useimage        =  true          ---@type boolean Options:  <true|false>
-- Ignore missing lazy.nvim plugin manager
vim.g.ignore_no_lazy  =  false         ---@type boolean Options:  <true|false>
-- Enable codesnap for code screenshots
vim.g.codesnap        =  true          ---@type boolean Options:  <true|false>
-- Enable encouraging feedback
vim.g.encourage_me    =  true          ---@type boolean Options:  <true|false>
-- Enable Auto-hiding cursorline
vim.g.auto_cursorline =  true          ---@type boolean Options: <true|false>
-- Enable Auto-save
vim.g.auto_save       =  true          ---@type boolean Options: <true|false>
-- Animate blinky cursor
vim.g.blinky          =  true          ---@type boolean Options: <true|false>
-- Use experimental cmp performance fork
vim.g.cmp_performance_enabled = true   ---@type boolean Options: <true|false>
-- Use dev mode for rootiest plugins
vim.g.rootiest_dev    =  false         ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ AI TOOL ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.aitool          = "neocodeium"   ---@type string Options: [ai tool]
--        ╭───────────────────────────╮                neocodeium
--        │                           │                codeium
--        │         AI Tools:         │                copilot
--        │   Choose an AI provider   │                tabnine
--        │      from the list       │                minuet
--        │                           │                ollama
--        ╰───────────────────────────╯                none

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

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ STATUS LINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.statusline      = "lualine"      ---@type string Options: [statusline]
--        ╭───────────────────────────╮                lualine
--        │                           │                heirline
--        │      Status Lines:        │                barsNlines
--        │   Choose a plugin from    │                basic
--        │      the list            │                none 
--        │                           │
--        ╰───────────────────────────╯
--
-- Click git components on statusline to open LazyGit
vim.g.statusline_clickable_git = false ---@type boolean Options: <true|false>
-- Show wakatime stats on statusline
vim.g.stats_wakatime           = true  ---@type boolean Options: <true|false>
-- Show music stats on statusline
vim.g.stats_music              = true  ---@type boolean Options: <true|false>
-- Ignored player sources for music stats
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
vim.g.completion_round_borders_enabled = true  ---@type boolean Options: <true|false>

-- stylua: ignore end

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Post-Config Functions ━━━━━━━━━━━━━━━━━━━━━━━━
-- Setup blinky cursor
require("utils.blinky").setup(vim.g.blinky)
