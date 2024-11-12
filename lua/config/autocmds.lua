--- @module "config.autocmds"
--- This module defines the autocommands for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                      Autocommands                       │
--          ╰─────────────────────────────────────────────────────────╯
local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- LazyGit root detection
if pcall(require, 'lazygit.utils') then
  autocmd('BufEnter', {
    pattern = '*',
    callback = function()
      require('lazygit.utils').project_root_dir()
    end,
  })
end

--  ━━━━━━━━━━━━━━━━━━━━━━━ Set up Qalc keymappings ━━━━━━━━━━━━━━━━━━━━━━━
if pcall(require, 'qalc') then
  -- Create a group for filetype-specific mappings
  autogrp('QalcFileTypeMappings', { clear = true })

  -- Create an autocommand for the qalc filetype
  autocmd('FileType', {
    pattern = 'qalc',
    group = 'QalcFileTypeMappings',
    callback = function()
      -- Set the key mapping: 'y' to run the :QalcYank command in normal mode
      vim.keymap.set( -- Yank Result
        'n',
        'y',
        ':QalcYank +<CR>',
        { noremap = true, silent = true }
      )
      -- Set the key mapping: 'q' to run the :QalcClose command in normal mode
      vim.keymap.set( -- Close Qalc
        'n',
        'q',
        ':QalcClose<CR>',
        { noremap = true, silent = true }
      )
    end,
  })

  -- Define a custom command to close the Qalc buffer
  vim.api.nvim_create_user_command('QalcClose', function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name ~= '' then
      vim.cmd('bd!')
    else
      -- If the buffer has no name, just remove it without invoking :bd!
      vim.api.nvim_buf_delete(0, { force = true })
    end
  end, { bang = true })
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Set up highlights ━━━━━━━━━━━━━━━━━━━━━━━━━━
local load_highlight = require('utils.highlight')
load_highlight.setup_autocommands()
load_highlight.setup_dashboard_highlight()

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Set up cpp picker ━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Adds a keymap for quicker picking when in cpp files
require('data.autocmd').cpp_picker()

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Set up nvim_exec ━━━━━━━━━━━━━━━━━━━━━━━

-- Function to check and execute the NVIM_EXEC environment variable
local function execute_nvim_exec()
  local exec_command = os.getenv('NVIM_EXEC')

  -- If NVIM_EXEC is set, execute the command
  if exec_command then
    vim.cmd(exec_command)
  end
end

-- Define an autogroup for the autocmd
autogrp('NvimExec', { clear = true })
-- Define an autocmd to run the function at startup
autocmd('VimEnter', {
  group = 'NvimExec',
  callback = execute_nvim_exec,
})
