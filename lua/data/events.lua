---@module "data.events"
--- This module defines the event tables for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Events                           │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

--- DEFAULT ---
M.default = 'VeryLazy'

--- Alpha events
M.alpha = { 'VimEnter' }

--- Auto Save events
M.autosave = { 'InsertLeave', 'TextChanged' }

--- Colorful Window Separators events
M.colorfulwinsep = { 'WinLeave' }

--- Dashboard-Nvim events
M.dashboard = { 'UIEnter' }

--- Dead Column
M.deadcolumn = { 'BufEnter' }

--- Heirline events
M.heirline = { 'UIEnter' }

--- Highlight Colors events
M.highlightcolor = { 'BufReadPre' }

--- Mini.Align events
M.minialign = { 'InsertEnter' }

--- Mini.SplitJoin events
M.minisplitjoin = { 'InsertEnter' }

--- Discord Presence events
M.presence = { 'LazyFile' }

--- RipGrep Substitute events
M.ripsub = { 'InsertEnter' }

--- SmoothCursor events
M.smoothcursor = { 'BufEnter' }

return M
