--- @module "config.autocmds"
--- This module defines the autocommands for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                      Autocommands                       │
--          ╰─────────────────────────────────────────────────────────╯
local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- LazyGit root detection
-- if pcall(require, 'lazygit.utils') then
--   autocmd('BufEnter', {
--     pattern = '*',
--     callback = function()
--       require('lazygit.utils').project_root_dir()
--     end,
--   })
-- end

--  ━━━━━━━━━━━━━━━━━━━━━━━ Set up Qalc keymappings ━━━━━━━━━━━━━━━━━━━━━━━
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

-- Define an autogroup for the NvimExec autocmd
autogrp('NvimExec', { clear = true })
-- Define an autocmd to run the function at startup
autocmd('VimEnter', {
  group = 'NvimExec',
  callback = execute_nvim_exec,
})

-- Create an autogroup for managing command-line abbreviations
local abbrev_group = autogrp('LazyAbbreviationGroup', { clear = true })
-- Create an autocmd for unwrapping the 'lazy' abbreviation
autocmd('CmdlineEnter', {
  group = abbrev_group,
  callback = function()
    vim.cmd([[
cnoreabbrev <expr> lazy ((getcmdtype() == ':' && getcmdline() == 'lazy') ? 'Lazy' : 'lazy')
    ]])
  end,
})

-- change line number based on mode:
-- for command mode: make it absolute for ranges etc
-- for normal mode: relative movements <3
local cmdline_group = vim.api.nvim_create_augroup('CmdlineLinenr', {})
-- debounce cmdline enter events to make sure we dont have flickering for non user cmdline use
-- e.g. mappings using : instead of <cmd>
local cmdline_debounce_timer

autocmd('CmdlineEnter', {
  group = cmdline_group,
  callback = function()
    cmdline_debounce_timer = vim.uv.new_timer()
    cmdline_debounce_timer:start(
      100,
      0,
      vim.schedule_wrap(function()
        if vim.o.number then
          vim.o.relativenumber = false
          vim.api.nvim__redraw({ statuscolumn = true })
        end
      end)
    )
  end,
})

autocmd('CmdlineLeave', {
  group = cmdline_group,
  callback = function()
    if cmdline_debounce_timer then
      cmdline_debounce_timer:stop()
      cmdline_debounce_timer = nil
    end
    if vim.o.number then
      vim.o.relativenumber = true
    end
  end,
})

autogrp('RootyCustomEvent', { clear = true })
autocmd({ 'BufReadPost', 'BufNewFile' }, {
  group = 'RootyCustomEvent',
  callback = function(args)
    local ignored_filetypes = require('data.types').general.ft
    local ft = vim.bo[args.buf].filetype

    if not vim.tbl_contains(ignored_filetypes, ft) then
      vim.api.nvim_exec_autocmds('User', { pattern = 'LazyFileOpen' })
    end
  end,
})

-- Don't comment next line when using `o`
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'o' })
  end,
})

-- Run async commands with output to split
vim.api.nvim_create_user_command('RunAsync', function(async_opts)
  -- Save current buffer first
  vim.cmd('w')

  -- Construct the full command
  local cmd = table.concat(async_opts.fargs, ' ')

  -- Open a horizontal split with the terminal running the command
  vim.cmd('belowright split | terminal ' .. cmd)

  -- Optional: return focus to original window
  vim.cmd('wincmd p')
end, {
  nargs = '+', -- Require at least one argument
})
