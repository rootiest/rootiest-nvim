---@module "data.cond"
--- This module defines the conditionals for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Conditionals                    │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

local func = require("data.func")
local types = require("data.types")

--- Auto Save conditional options
M.autosave = function()
  return func.check_global_var("auto_save", true, false)
end

--- Bars-N-Lines conditional options
M.barsNlines = function()
  if
    func.check_global_var("statuscolumn", "barsNlines", "native")
    or func.check_global_var("tabline", "barsNlines", "bufferline")
    or func.check_global_var("statusline", "barsNlines", "lualine")
  then
    return true
  end
  return false
end

M.avante = function()
  return func.check_global_var("useavante", true, false)
end

M.chatgpt = function()
  return func.check_global_var("usechatgpt", true, false)
end

M.gp = function()
  return func.check_global_var("usegpai", true, false)
end

--- Codeium conditional options
M.codeium = function()
  return func.check_global_var("aitool", "codeium", "neocodeium")
end

--- CodeSnap conditional options
M.codesnap = function()
  return func.check_global_var("codesnap", true, false)
end

--- Colorful Window-Separators conditional options
M.colorfulwinsep = function()
  return func.check_global_var("colorfulwinsep", true, false)
end

--- Auto-CursorLine conditional options
M.cursorline = function()
  return func.check_global_var("auto_cursorline", true, true)
end

--- Bufferline conditional options
M.bufferline = function()
  if
    func.check_global_var("tabline", "bufferline", "bufferline")
    or func.check_global_var("tabline", "barsNlines", "bufferline")
  then
    return true
  end
  return false
end

--- CoPilot conditional options
M.copilot = function()
  return vim.g.aitool == "copilot"
end

--- HardTime conditional options
M.hardtime = function()
  return func.check_global_var("usehardtime", true, false)
end

--- Heirline conditional options
M.heirline = function()
  return func.check_global_var("statusline", "heirline", "heirline")
end

--- Image conditional options
M.image = function()
  -- Disable image rendering in Neovide
  -- or when vim.g.useimage = false
  if vim.g.useimage == false then
    return false
  end
  return not vim.g.neovide
end

--- LuaRocks conditional options
M.luarocks = function()
  return func.check_global_var("useluarocks", true, true)
end

--- Minimap conditional options
M.minimap = function()
  types.setup()
  local ex_ft = types.minimap.ft
  local ex_buf = types.minimap.buf
  local ft = vim.bo.filetype
  local buf = vim.bo.buftype
  local mod = vim.bo.modifiable
  return not vim.tbl_contains(ex_ft, ft)
    and not vim.tbl_contains(ex_buf, buf)
    and mod == true
end

--- Minuet conditional options
M.minuet = function()
  return func.check_global_var("aitool", "minuet", "neocodeium")
end

--- Music Controls conditional options
M.musiccontrols = function()
  return func.check_global_var("usemusic", true, true)
end

--- NekiFoch conditional options
M.nekifoch = function()
  return func.is_kitty()
end

--- Tabnine conditional options
--- Codeium conditional options
M.neocodeium = function()
  return func.check_global_var("aitool", "neocodeium", "neocodeium")
end

M.tabnine = function()
  return func.check_global_var("aitool", "tabnine", "neocodeium")
end

--- TMux conditional options
M.tmux = function()
  return func.is_tmux()
end

--- WakaTime conditional options
M.wakatime = function()
  return vim.g.usewakatime
end

--- WezTerm conditional options
M.wezterm = function()
  return func.is_wezterm()
end

return M
