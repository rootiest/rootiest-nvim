--- @module "config.options"
--- This module defines the user options for the Neovim configuration.
--- Variables defined here set configuration options for the rest
--- of the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Options                         │
--          ╰─────────────────────────────────────────────────────────╯

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ KEYS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.opt.foldlevel = 99

-- Set the mapleader variable to the space key
vim.g.mapleader                 = " "           ---@type string Options: <leader>

-- Set the maplocalleader variable to the space key
vim.g.maplocalleader            = "\\"          ---@type string Options: <localleader>
-- Set the timeout length for key combinations
vim.g.timeoutlen                = 1000          ---@type integer Options: <ms>
-- Allow horizontal motion keys to wrap to next line at start/end of line
vim.opt.whichwrap:append("h,l,<,>,[,]")

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ LSP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- We don't need perl
vim.g.loaded_perl_provider      = 0             ---@type integer Options: <0|1>
-- or ruby
vim.g.loaded_ruby_provider      = 0             ---@type integer Options: <0|1>
-- Prefer basedpyright for python
vim.g.lazyvim_python_lsp        = "pyright"     ---@type string Options: [python lsp]
-- Use tiny-inline-diagnostic
vim.g.usetinyinline             = true          ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ GIT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Github username for dashboard and other customizations
vim.g.gitname                   = 'rootiest'    ---@type string Options: <github username>
-- Show GitHub Contributions on dashboard
vim.g.show_github_contrib       = true          ---@type boolean Options: <true|false>
-- Highlight lines with git changes
vim.g.git_line_hl               = false         ---@type boolean Options: <true|false>
-- Highlight words with git changes
vim.g.git_word_hl               = false         ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ FORMAT AND SAVE ━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.opt.foldlevel               = 99            ---@type integer Options: <0-99>
-- Auto-format
vim.g.autoformat                = true          ---@type boolean Options: <true|false>
-- Auto-save
vim.g.autosave                  = true          ---@type boolean Options: <true|false>
-- Enable encouraging feedback
vim.g.encourage_me              = true          ---@type boolean Options:  <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ MISCELLANEOUS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Use WakaTime for code stats
vim.g.usewakatime               = true          ---@type boolean Options:  <true|false>
-- Allow music controls and stats
vim.g.usemusic                  = false         ---@type boolean Options:  <true|false>
-- Allow discord presence
vim.g.usediscord                = true          ---@type boolean Options:  <true|false>
-- Enable HardTime on startup
vim.g.usehardtime               = false         ---@type boolean Options:  <true|false>
-- Enable Image plugin on compatible terminals
vim.g.useimage                  = true          ---@type boolean Options:  <true|false>
-- Enable LazyGit plugin
vim.g.uselazygit                = true          ---@type boolean Options:  <true|false>
-- Ignore missing lazy.nvim plugin manager
vim.g.ignore_no_lazy            = false         ---@type boolean Options:  <true|false>
-- Enable codesnap for code screenshots
vim.g.codesnap                  = true          ---@type boolean Options:  <true|false>
-- Enable Auto-hiding cursorline
vim.g.auto_cursorline           = false         ---@type boolean Options: <true|false>
-- Toggle cursorline (when not auto)
vim.o.cursorline                = false         ---@type boolean Options: <true|false>
-- Enable Smart Scrolloff
vim.g.smart_scrolloff           = false         ---@type boolean Options: <true|false>
-- Enable Dead Column
vim.g.dead_column               = false         ---@type boolean Options: <true|false>
-- Animate blinky cursor
vim.g.blinky                    = true          ---@type boolean Options: <true|false>
-- Enable todo-comments features
vim.g.usetodo                   = true          ---@type boolean Options: <true|false>
-- Use Floating help window
vim.g.usefloatinghelp           = false         ---@type boolean Options: <true|false>
-- Use dev mode for rootiest plugins
vim.g.rootiest_dev              = true          ---@type boolean Options: <true|false>
-- Enable luarocks package manager
vim.g.use_luarocks              = false         ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ PICKER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Select default fallback picker
vim.g.lazyvim_picker            = "auto"       ---@type string Options: [picker]
--        ╭───────────────────────────╮                auto
--        │                           │                telescope
--        │          Pickers:         │                fzf
--        │      Choose a picker      │
--        │      from the list       │
--        │                           │
--        ╰───────────────────────────╯

-- Use snacks picker by default
vim.g.use_snacks_picker         = true          ---@type boolean Options: <true|false>
-- Use the Telescope plugin
vim.g.use_telescope             = false         ---@type boolean Options: <true|false>
-- Use the Fzf plugin
vim.g.use_fzf_lua               = false         ---@type boolean Options: <true|false>
-- Use oil file manager
vim.g.useoil                    = false         ---@type boolean Options: <true|false>
-- Use NeoTree file manager
vim.g.useneotree                = false         ---@type boolean Options: <true|false>
-- Use Yazy file manager
vim.g.useyazi                   = true          ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ AI TOOL ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Configure the AI completion provider
vim.g.aitool                    = "copilot"  ---@type string Options: [ai tool]
--        ╭───────────────────────────╮                neocodeium
--        │                           │                codeium
--        │         AI Tools:         │                copilot
--        │   Choose an AI provider   │                tabnine
--        │      from the list       │                minuet
--        │                           │                ollama
--        ╰───────────────────────────╯                none
-- Enable ChatGPT plugin for AI chat
vim.g.usechatgpt                 = false        ---@type boolean Options:  <true|false>
-- Enable Avante plugin for AI chat
vim.g.useavante                  = false        ---@type boolean Options:  <true|false>
-- Enable Code-Companion plugin for AI chat
vim.g.usecodecomp                = true         ---@type boolean Options:  <true|false>
-- Enable GP plugin for AI chat
vim.g.usegpai                    = false        ---@type boolean Options:  <true|false>

-- Use Blink instead of nvim-cmp
vim.g.useblinkcmp                = true         ---@type boolean Options:  <true|false>
-- Use experimental performance fork
vim.g.cmp_performance_enabled    = false        ---@type boolean Options: <true|false>
-- When using cmp_performance_enabled with blink, blink will follow main branch
-- Requires a working rust toolchain
---@see vim.g.lazyvim_blink_main
--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ STATUS COLUMN ━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.g.statuscolumn              = "snacks"      ---@type string Options: [statuscolumn]
--        ╭───────────────────────────╮                barsNlines
--        │                           │                snacks
--        │      Status Columns:      │                native
--        │   Choose a plugin from    │
--        │      the list            │
--        │                           │
--        ╰───────────────────────────╯

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ BUFFER LINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.g.tabline                   = "none"        ---@type string Options: [tabline]
--        ╭───────────────────────────╮                bufferline
--        │                           │                barsNlines
--        │      Tab Lines:           │                none
--        │   Choose a plugin from    │
--        │      the list            │
--        │                           │
--        ╰───────────────────────────╯

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ DASHBOARD ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.g.dashboard                 = "snacks"      ---@type string Options: [dashboard]
--        ╭───────────────────────────╮                alpha
--        │                           │                nvim-dashboard
--        │      Dashboards:          │                snacks
--        │   Choose a plugin from    │                none
--        │      the list            │
--        │                           │
--        ╰───────────────────────────╯

-- Dashboard logo file
vim.g.dash_logo                 = "mini.txt"  ---@type string Options: [dash logo]
--  Dashboard header color
vim.g.DashboardHeaderColor      = "#88fc9a"    ---@type string Options: [hex color]

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ STATUS LINE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.g.statusline                = "lualine"     ---@type string Options: [statusline]
--        ╭───────────────────────────╮                lualine
--        │                           │                heirline
--        │      Status Lines:        │                barsNlines
--        │   Choose a plugin from    │                basic
--        │      the list            │                none 
--        │                           │
--        ╰───────────────────────────╯

-- Click git components on statusline to open LazyGit
vim.g.statusline_clickable_git  = true          ---@type boolean Options: <true|false>
-- Show wakatime stats on statusline
vim.g.stats_wakatime            = true          ---@type boolean Options: <true|false>
-- Show music stats on statusline
vim.g.stats_music               = true          ---@type boolean Options: <true|false>
-- Ignored player sources for music stats
vim.g.stats_ignored_players     = {             ---@type string[] Options: [ignored players]
                                  "chromium",
                                  "firefox",
                                  "kdeconnect",
                                  "haruna",
                                  "plasma-browser-integration",
                                  "plasma-browser-integration-76042",
                                 }

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ COLOR ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--  Background color
vim.o.background                = "dark"        ---@type string Options: <dark|light>
-- Disable Transparency
vim.g.disable_transparency      = true          ---@type boolean Options: <true|false>
-- Auto Dark-mode
vim.g.autodarkmode              = false         ---@type boolean Options: <true|false>
-- Set colorcolumn
--vim.opt.colorcolumn           = "120"         ---@type string|table Options: [column]
--Use Astral colorscheme management
vim.g.use_astral                = false         ---@type boolean Options: <true|false>

--  ━━━━━━━━━━━━━━━━━━━━━━━━━ TABS AND INDENTATION ━━━━━━━━━━━━━━━━━━━━━━━━

--  Define characters for tabs, indents, and scopes
--  Option [2] will override [1] if both are defined

--     ──────────────── [1] Choose a preset character ──────────────────
-- Specify a character/table from the presets
-- See: data.types.ibl.char for a list of available characters
-- This option can provide multi-character cycling configurations
-- Tab characters
vim.g.tab_char_name             = "none"        ---@type string Options: [tab char]
-- Indent characters
vim.g.indent_char_name          = "none"        ---@type string Options: [indent char]
-- Scope characters
vim.g.scope_char_name           = "scope"       ---@type string Options: [scope char]

--     ──────────────── [2] Choose a specific character ────────────────
-- Define a character to be used in the whitespace to represent tabs/indents
-- This option allows use of any single character string
-- Multi-character cycling configurations are not possible with this option
-- Multi-character strings are not possible with any of the options
--  Tab character
vim.g.tab_char                  = " "           ---@type string Options: [tab char]
-- -- Indent character
vim.g.indent_char               = " "           ---@type string Options: [indent char]
-- Scope character
vim.g.scope_char                = "│"           ---@type string Options: [scope char]

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Completion ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Cmp Window Border
vim.g.completion_borders        = "rounded"     ---@type string Options: [round|sharp|flat]

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Execute post-opts functions
require("config.postopts")
