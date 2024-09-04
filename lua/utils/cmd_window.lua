---@module "utils.cmd_window"
--- This module provides a function to open a floating window with a completion menu.
--          ╭─────────────────────────────────────────────────────────╮
--          │                 Rootiest Command Window                 │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

function M.open_floating_window_with_completion()
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
  local win_height = 1 -- Height of floating window
  local win_width = math.floor(vim.o.columns * 0.25) -- Width of floating window
  local row = math.floor((vim.o.lines - win_height) / 2) -- Position row
  local col = math.floor((vim.o.columns - win_width) / 2) -- Position column
  local win_border = "rounded"

  -- Create a floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = col,
    row = row,
    border = win_border,
  })

  -- Set the buffer's filetype
  vim.bo[buf].filetype = "cmdline" -- Set a unique filetype

  -- Variables to manage history
  _G.history_index = 0
  _G.history_size = vim.fn.histnr("cmd")

  -- Function to close the window
  M.close_window = function()
    vim.api.nvim_win_close(win, true) -- Close the window
    -- Switch back to normal mode
    vim.api.nvim_command("stopinsert")
  end

  -- Function to execute the command
  M.execute_command = function()
    local cmd = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1] or ""
    -- Ensure abbreviation expansion
    vim.api.nvim_command("execute 'silent! " .. cmd .. "'")
    M.close_window()
  end

  -- Function to handle navigation and clear buffer
  M.handle_history_navigation = function(direction)
    -- Update history index
    _G.history_index = (_G.history_index + direction) % _G.history_size
    if _G.history_index < 0 then
      _G.history_index = _G.history_size - 1
    end

    -- Clear the buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

    -- Fetch history item and insert into buffer
    local history_cmd = vim.fn["histget"]("cmd", _G.history_index + 1)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { history_cmd or "" })
    vim.api.nvim_win_set_cursor(win, { 1, #history_cmd or 0 })
  end

  -- Setup keymaps for buffer
  -- Map <CR> to execute the command
  vim.api.nvim_buf_set_keymap(
    buf,
    "i",
    "<CR>",
    [[<cmd>lua require('utils.cmd_window').execute_command()<CR>]],
    { noremap = true, silent = true }
  )
  -- Map <ESC> to close the window
  vim.api.nvim_buf_set_keymap(
    buf,
    "i",
    "<ESC>",
    [[<cmd>lua require('utils.cmd_window').close_window()<CR>]],
    { noremap = true, silent = true }
  )
  -- Map <Up> to navigate command history
  vim.api.nvim_buf_set_keymap(
    buf,
    "i",
    "<Up>",
    [[<cmd>lua require('utils.cmd_window').handle_history_navigation(-1)<CR>]],
    { noremap = true, silent = true }
  )
  -- Map <Down> to navigate command history
  vim.api.nvim_buf_set_keymap(
    buf,
    "i",
    "<Down>",
    [[<cmd>lua require('utils.cmd_window').handle_history_navigation(1)<CR>]],
    { noremap = true, silent = true }
  )
  -- Map <C-n> to navigate command history
  vim.api.nvim_buf_set_keymap(
    buf,
    "i",
    "<C-n>",
    [[<cmd>lua require('utils.cmd_window').handle_history_navigation(1)<CR>]],
    { noremap = true, silent = true }
  )
  -- Map <C-p> to navigate command history
  vim.api.nvim_buf_set_keymap(
    buf,
    "i",
    "<C-p>",
    [[<cmd>lua require('utils.cmd_window').handle_history_navigation(-1)<CR>]],
    { noremap = true, silent = true }
  )

  -- Start in insert mode
  vim.api.nvim_command("startinsert")
end

M.setup = function(opts)
  opts = opts or {}

  -- Add a user command to open the floating window
  vim.api.nvim_create_user_command(
    "FloatingWindowWithCompletion",
    M.open_floating_window_with_completion,
    {}
  )

  -- Optionally override default command-line behavior
  if opts.override_cmdline then
    require("data").func.add_keymap(
      ":",
      "<cmd>lua require('utils.cmd_window').open_floating_window_with_completion()<cr>",
      "FloatingWindowWithCompletion"
    )
  end
end

return M
