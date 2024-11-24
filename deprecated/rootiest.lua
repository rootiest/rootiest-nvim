--          ╭─────────────────────────────────────────────────────────╮
--          │                  Deprecated Functions                   │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local trigger_error = require('config.rootiest').trigger_error

--- Toggle LazyGit terminal split
---@param direction string|nil The direction of the terminal split (default: "horizontal")
---@param size number|nil The size of the terminal split (default: 0.3)
---@return boolean condition true if the terminal was toggled, false otherwise
function M.toggle_lazygit_term(direction, size)
  if pcall(require, 'toggleterm.terminal') then
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = 'lazygit',
      hidden = true,
      direction = direction or 'horizontal', -- Set direction to horizontal split
      size = size or 0.3, -- Set size to 30% of the screen
    })
    lazygit:toggle()
    return true
  else
    trigger_error('toggleterm plugin is not installed')
    return false
  end
end

--- Toggle LazyGit floating terminal
---@param my_args string|nil The arguments to pass to the lazygit command (default: nil)
---@return boolean condition true if the terminal was toggled, false otherwise
function M.toggle_lazygit_float(my_args)
  if pcall(require, 'toggleterm.terminal') then
    local Util = require('lazyvim.util')
    my_args = my_args or nil
    if my_args ~= '' or my_args ~= nil then
      Util.terminal.open(
        { 'lazygit', my_args },
        { cwd = Util.root(), interactive = true, esc_esc = false }
      )
    else
      Util.terminal.open(
        { 'lazygit' },
        { cwd = Util.root(), interactive = true, esc_esc = false }
      )
    end
    return true
  else
    trigger_error('toggleterm plugin is not installed')
    return false
  end
end

return M
