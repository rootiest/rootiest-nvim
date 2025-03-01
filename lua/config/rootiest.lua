---@module "config.rootiest"
--- This module contains the configuration options and functions
--- for the rootiest distro.
--          ╭─────────────────────────────────────────────────────────╮
--          │                     Rootiest Module                     │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

--- Function to trigger an error message
---@param message string The error message to trigger
---@return boolean condition true if the error message was triggered, false otherwise
local function trigger_error(message)
  return require('data').func.notify(message, 'ERROR')
end

local function setup_os_vars()
  --  Check if we are on windows
  vim.g.is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

--- Yank line without leading/trailing whitespace
---@return nil
function M.yank_line()
  vim.api.nvim_feedkeys('_v$hy$', 'n', true)
end

-- Variable to track if the precognition plugin has been called once
local precog_first_time = true

--- Toggle the precognition plugin
---@return nil
function M.toggle_precognition()
  if pcall(require, 'precognition') then
    -- Initialize precognition plugin
    local precognition = require('precognition')
    -- Toggle the plugin
    if precog_first_time then
      precognition.toggle()
      precognition.toggle() -- Call toggle twice
      precog_first_time = false
    else
      precognition.toggle() -- Call toggle once
    end
  else
    trigger_error('precognition plugin is not installed')
  end
end

--- Toggle Hardtime and Precognition together
---@return nil
function M.toggle_hardmode()
  if pcall(require, 'hardtime') then
    local hardtime = require('hardtime')
    hardtime.toggle()
    M.toggle_precognition()
  else
    trigger_error('hardtime plugin is not installed')
  end
end

--- Load remote-nvim plugin
---@return boolean condition true if the plugin was loaded, false otherwise
function M.load_remote()
  if pcall(require, 'remote-nvim') then
    ---@diagnostic disable-next-line: missing-parameter
    require('remote-nvim').setup()
    vim.cmd('RemoteStart')
    return true
  else
    trigger_error('remote-nvim plugin is not installed')
    return false
  end
end

--- Yank text inside quotes on the current line and paste it into text inside quotes at various marks.
--- @return boolean true if any text was pasted successfully, false otherwise
function M.YankAndPasteInQuotes()
  -- Yank text inside quotes on the current line
  vim.cmd('normal! yiq')

  -- Get the yanked text from the "0 register (the unnamed register)
  local yanked_text = vim.fn.getreg('"')

  -- List of marks to check ('a' to 'z')
  local marks = 'abcdefghijklmnopqrstuvwxyz'

  -- Flag to track if any pasting was successful
  local was_pasted = false

  -- Loop through each mark
  for mark in marks:gmatch('.') do
    -- Check if the mark exists (returns the line number or nil)
    local position = vim.fn.getpos("'" .. mark)

    if position[1] ~= 0 then
      -- Go to the mark
      vim.cmd("normal! '" .. mark)

      -- Select text inside quotes and paste the yanked text
      vim.cmd('normal! viq')
      vim.cmd('normal! "' .. yanked_text .. 'P')

      -- Set the flag to true since pasting was successful
      was_pasted = true
    end
  end

  -- Return whether any pasting was successful
  return was_pasted
end

--- Evaluate Neovide state and activate settings if necessary
---@return boolean condition true if Neovide is active, false otherwise
function M.eval_neovide()
  if vim.g.neovide then
    require('config.neovide')
    return true
  else
    return false
  end
end

--- Define user commands
---@return nil
function M.define_commands()
  -- Define Q as a usercmd
  vim.api.nvim_create_user_command('Q', 'qall', { desc = 'Quit all buffers' })

  -- Define yank line command
  vim.api.nvim_create_user_command('YankLine', function()
    M.yank_line()
  end, { force = true, desc = 'Yank line without leading whitespace' })
  vim.api.nvim_create_user_command(
    'YankAndPasteQuotes',
    M.YankAndPasteInQuotes,
    {}
  )
end

--- Set up rootiest module
function M.setup()
  -- Early interventions
  require('config.early')
  -- Setup OS variables
  setup_os_vars()
  -- Setup neovide
  M.eval_neovide()
  -- Define user commands
  M.define_commands()
  -- Setup vimscripts
  require('data.vim').setup()
  -- Setup types data
  require('data.types').setup()
  -- Setup indentor
  -- require('utils.indentor')
end

return M
