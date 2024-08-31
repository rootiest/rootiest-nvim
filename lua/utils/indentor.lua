---@module "utils.indentor"
--- This module provides functions to insert indentation at the start of a line.

local M = {}

--- Get the indentation level from the previous line
---@return integer level The indentation level
local function get_previous_line_indentation()
  -- Get the current cursor position
  local current_line, _ = unpack(vim.api.nvim_win_get_cursor(0))

  -- Ensure we're not on the first line
  if current_line == 1 then
    return 0
  end

  -- Get the previous line's content
  local previous_line =
    vim.api.nvim_buf_get_lines(0, current_line - 2, current_line - 1, false)[1]

  -- Match the leading spaces (indentation)
  local indentation = previous_line:match("^%s*")

  -- Return the number of spaces (or indentation level)
  return #indentation
end

--- Insert the previous line's indentation at the start of the current line
---@return boolean inserted true if the indentation was inserted, false otherwise
function M.insert_previous_line_indentation()
  -- Get the cursor column position
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- If the cursor is at the start of the line (column 0)
  if col == 0 then
    -- Get the number of spaces from the previous line's indentation
    local indentation_level = get_previous_line_indentation()

    -- Insert the same number of spaces at the start of the current line
    vim.api.nvim_put({ string.rep(" ", indentation_level) }, "c", true, true)
    return true
  else
    -- Insert a tab (or spaces if 'expandtab' is set)
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
      "n",
      true
    )
    return false
  end
end

--- Create keymaps for the module
---@return nil
function M.setup()
  -- Load the data module
  local data = require("data")
  -- Create keymaps
  for _, map in ipairs(data.keys.indentor) do
    data.func.add_keymap(map[1], map[2], map[3], map[4])
  end
end

return M
