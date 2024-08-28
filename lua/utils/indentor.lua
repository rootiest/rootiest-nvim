local M = {}

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

function M.insert_previous_line_indentation()
  -- Get the cursor column position
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- If the cursor is at the start of the line (column 0)
  if col == 0 then
    -- Get the number of spaces from the previous line's indentation
    local indentation_level = get_previous_line_indentation()

    -- Insert the same number of spaces at the start of the current line
    vim.api.nvim_put({ string.rep(" ", indentation_level) }, "c", true, true)
  else
    -- Insert a tab (or spaces if 'expandtab' is set)
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
      "n",
      true
    )
  end
end

-- Create a keymap to trigger the function using native mappings
-- vim.api.nvim_set_keymap(
--   { "i", "n" },
--   "<C-i>",
--   "<Cmd>lua require('indentor').insert_previous_line_indentation()<CR>",
--   { noremap = true, silent = true }
-- )

-- Create a keymap to trigger the function using Rootiest utils
require("data").func.add_keymap(
  "<C-i>",
  M.insert_previous_line_indentation,
  "Indent Line",
  { "i", "n" }
)

return M
