---@module "data.cond"
--- This module defines the conditionals for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Conditionals                    │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

local func = require('data.func')
local types = require('data.types')

-- Auto-dark-mode conditional options
M.auto_dark_mode = function()
  return func.check_global_var('autodarkmode', true, false)
    and not func.is_ssh()
end

--- Auto Save conditional options
M.autosave = function()
  return func.check_global_var('autosave', true, false)
end

-- Auto Format conditional options
M.autoformat = function()
  return func.check_global_var('autoformat', true, false)
end

--- Bars-N-Lines conditional options
M.barsNlines = function()
  if
    func.check_global_var('statuscolumn', 'barsNlines', 'native')
    or func.check_global_var('tabline', 'barsNlines', 'bufferline')
    or func.check_global_var('statusline', 'barsNlines', 'lualine')
  then
    return true
  end
  return false
end

--- Avante conditional options
M.avante = function()
  return func.check_global_var('useavante', true, false)
end

--- ChatGPT conditional options
M.chatgpt = function()
  return func.check_global_var('usechatgpt', true, false)
end

--- GP conditional options
M.gp = function()
  return func.check_global_var('usegpai', true, false)
end

--- Codeium conditional options
M.codeium = function()
  return func.check_global_var('aitool', 'codeium', 'neocodeium')
end

--- CodeSnap conditional options
M.codesnap = function()
  return func.check_global_var('codesnap', true, false)
end

--- Colorful Window-Separators conditional options
M.colorfulwinsep = function()
  return func.check_global_var('colorfulwinsep', true, false)
end

--- Auto-CursorLine conditional options
M.cursorline = function()
  return func.check_global_var('auto_cursorline', true, true)
end

--- Bufferline conditional options
M.bufferline = function()
  if
    func.check_global_var('tabline', 'bufferline', 'bufferline')
    or func.check_global_var('tabline', 'barsNlines', 'bufferline')
  then
    return true
  end
  return false
end

-- Code-Companion conditional options
M.codecompanion = function()
  return func.check_global_var('usecodecomp', true, false)
end

--- CoPilot conditional options
M.copilot = function()
  return vim.g.aitool == 'copilot'
end

--- FloatingHelp conditional options
M.floating_help = function()
  return func.check_global_var('usefloatinghelp', true, false)
end

--- HardTime conditional options
M.hardtime = function()
  return func.check_global_var('usehardtime', true, false)
end

--- Heirline conditional options
M.heirline = function()
  return func.check_global_var('statusline', 'heirline', 'heirline')
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

M.lualine = function()
  -- List of excluded buffer names
  local excluded_buffers = require('data.types').general.buf

  -- List of excluded filetypes
  local excluded_filetypes = require('data.types').general.ft
  -- Check buffer name
  local bufname = vim.api.nvim_buf_get_name(0)
  for _, name in ipairs(excluded_buffers) do
    if string.find(bufname, name) then
      return false
    end
  end

  -- Check filetype
  local filetype = vim.bo.filetype
  for _, ft in ipairs(excluded_filetypes) do
    if filetype == ft then
      return false
    end
  end

  -- Default: load for all other buffers
  return require('data.func').check_global_var(
    'statusline',
    'lualine',
    'lualine'
  )
end

--- LuaRocks conditional options
M.luarocks = function()
  return func.check_global_var('useluarocks', true, true)
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
  return func.check_global_var('aitool', 'minuet', 'neocodeium')
end

--- Music Controls conditional options
M.musiccontrols = function()
  return func.check_global_var('usemusic', true, true)
end

--- NekiFoch conditional options
M.nekifoch = function()
  return func.is_kitty()
end

--- Codeium conditional options
M.neocodeium = function()
  return func.check_global_var('aitool', 'neocodeium', 'neocodeium')
end

M.neotree = function()
  return func.check_global_var('useneotree', true, true)
end

M.treesitter = function()
  -- Only load for editable buffers
  return vim.bo.buftype == '' and not vim.bo.readonly
end

--- Tabnine conditional options
M.tabnine = function()
  return func.check_global_var('aitool', 'tabnine', 'neocodeium')
end

M.tiny_inline_diagnostic = function()
  return func.check_global_var('usetinyinline', true, false)
end

M.todo = function()
  if func.check_global_var('usetodo', true, true) then
    if not func.is_neovide() then
      if vim.bo.readonly == false then
        if func.dir_is_git_repo(vim.fn.expand('%:p:h')) then
          return true
        end
      end
    end
  end
  return false
end

--- TMux conditional options
M.tmux = function()
  return func.is_tmux()
end

--- Use Smart-splits conditional
M.use_splits = function()
  -- return not func.is_ghostty()
  return true
end

--- WakaTime conditional options
M.wakatime = function()
  return vim.g.usewakatime
end

--- WezTerm conditional options
M.wezterm = function()
  return func.is_wezterm()
end

--- Yazi conditional options
M.yazi = function()
  return func.check_global_var('useyazi', true, false)
end

return M
