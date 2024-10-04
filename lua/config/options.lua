--- @module "config.options"
--- This module defines the user options for the Neovim configuration.
--- Variables defined here set configuration options for the rest
--- of the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Options                         │
--          ╰─────────────────────────────────────────────────────────╯
-- stylua: ignore start

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Key Options ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Set the mapleader variable to the space key
vim.g.mapleader            = " "       ---@type string Options: <leader>

-- Set the maplocalleader variable to the space key
vim.g.maplocalleader       = "\\"      ---@type string Options: <localleader>
-- Set the timeout length for key combinations
vim.g.timeoutlen           = 1000      ---@type integer Options: <ms>

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
-- Enable LazyGit plugin
vim.g.uselazygit      =  true          ---@type boolean Options:  <true|false>
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
vim.g.cmp_performance_enabled = true  ---@type boolean Options: <true|false>
-- Use dev mode for rootiest plugins
vim.g.rootiest_dev    =  false         ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ AI TOOL ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Configure the AI completion provider
vim.g.aitool          = "neocodeium"   ---@type string Options: [ai tool]
--        ╭───────────────────────────╮                neocodeium
--        │                           │                codeium
--        │         AI Tools:         │                copilot
--        │   Choose an AI provider   │                tabnine
--        │      from the list       │                minuet
--        │                           │                ollama
--        ╰───────────────────────────╯                none
-- Enable ChatGPT plugin for AI chat
vim.g.usechatgpt      =  false          ---@type boolean Options:  <true|false>
-- Enable Avante plugin for AI chat
vim.g.useavante       =  true           ---@type boolean Options:  <true|false>
-- Enable GP plugin for AI chat
vim.g.usegpai         =  false          ---@type boolean Options:  <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ STATUS COLUMN ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.statuscolumn    = "native"        ---@type string Options: [statuscolumn]
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

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ DASHBOARD ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.dashboard       = "alpha"        ---@type string Options: [dashboard]
--        ╭───────────────────────────╮                alpha
--        │                           │                nvim-dashboard
--        │      Dashboards:          │                none
--        │   Choose a plugin from    │
--        │      the list            │
--        │                           │
--        ╰───────────────────────────╯

-- Dashboard logo file
vim.g.dash_logo = "neovim.txt"    ---@type string Options: [dash logo]
--  Dashboard header color
vim.g.DashboardHeaderColor = "#88fc9a"---@type string Options: [hex color]

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ STATUS LINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.statusline      = "lualine"      ---@type string Options: [statusline]
--        ╭───────────────────────────╮                lualine
--        │                           │                heirline
--        │      Status Lines:        │                barsNlines
--        │   Choose a plugin from    │                basic
--        │      the list            │                none 
--        │                           │
--        ╰───────────────────────────╯

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
-- Disable Transparency
vim.g.disable_transparency = true      ---@type boolean Options: <true|false>
-- Set colorcolumn
--vim.opt.colorcolumn        = "120"     ---@type string|table Options: [column]

--  ━━━━━━━━━━━━━━━━━━━━━━━━━ Tabs and Indentation ━━━━━━━━━━━━━━━━━━━━━━━━
--  Define characters for tabs, indents, and scopes
--  Option [2] will override [1] if both are defined

--     ──────────────── [1] Choose a preset character ──────────────────
-- Specify a character/table from the presets
-- See: data.types.ibl.char for a list of available characters
-- This option can provide multi-character cycling configurations
-- Tab characters
vim.g.tab_char_name        = "none"   ---@type string Options: [tab char]
-- Indent characters
vim.g.indent_char_name     = "none"   ---@type string Options: [indent char]
-- Scope characters
vim.g.scope_char_name      = "scope"   ---@type string Options: [scope char]

--     ──────────────── [2] Choose a specific character ────────────────
-- Define a character to be used in the whitespace to represent tabs/indents
-- This option allows use of any single character string
-- Multi-character cycling configurations are not possible with this option
-- Multi-character strings are not possible with any of the options
--  Tab character
-- vim.g.tab_char          = "󰌒"       ---@type string Options: [tab char]
-- -- Indent character
-- vim.g.indent_char       = "¶"       ---@type string Options: [indent char]
-- Scope character
-- vim.g.scope_char        = ""       ---@type string Options: [scope char]

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Completion ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Cmp Window Border
vim.g.completion_borders   = "rounded" ---@type string Options: [round|sharp|flat]

-- stylua: ignore end

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Post-Config Functions ━━━━━━━━━━━━━━━━━━━━━━━━

-- Setup blinky cursor
require("utils.blinky").setup(vim.g.blinky)

-- Setup nvim-remote
if vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end
