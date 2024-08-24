local bit = require("bit")

local M = {}

-- Function to convert RGB to hexadecimal
function M.rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

-- Function to get the foreground color of a highlight group
function M.get_fg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local fg = hl.fg
  if fg then
    return M.rgb_to_hex({
      bit.rshift(bit.band(fg, 0xFF0000), 16),
      bit.rshift(bit.band(fg, 0x00FF00), 8),
      bit.band(fg, 0x0000FF),
    })
  end
  return nil
end

function M.get_bg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local bg = hl.bg
  if bg then
    return M.rgb_to_hex({
      bit.rshift(bit.band(bg, 0xFF0000), 16),
      bit.rshift(bit.band(bg, 0x00FF00), 8),
      bit.band(bg, 0x0000FF),
    })
  end
  return nil
end

function M.is_window_wide_enough(width_limit)
  -- Get the current width of the Neovim window
  local width = vim.fn.winwidth(0)
  -- Return true if width is greater than or equal to width_limit
  return width >= width_limit
end

function M.get_date()
  return os.date("%Y-%m-%d")
end

function M.code_action_on_selection()
  -- Capture the current mode
  local mode = vim.fn.mode()

  -- Proceed only if in Visual mode
  if mode == "v" or mode == "V" or mode == "" then
    -- Capture the start and end positions of the selected text
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    -- Ensure positions are valid (non-nil)
    if start_pos and end_pos then
      -- Convert positions to zero-indexed (LSP format)
      local start_row = start_pos[2]
      local start_col = start_pos[3]
      local end_row = end_pos[2]
      local end_col = end_pos[3]

      -- Ensure that the range is valid
      if
        start_row >= 0
        and start_col >= 0
        and end_row >= 0
        and end_col >= 0
      then
        -- Create the range
        local range = {
          start = { line = start_row, character = start_col },
          ["end"] = { line = end_row, character = end_col },
        }

        -- Invoke code action with the range
        vim.lsp.buf.code_action({
          range = range,
        })
      else
        -- Fallback if the range is invalid
        vim.notify(
          "Invalid selection range for code action",
          vim.log.levels.ERROR
        )
      end
    else
      -- Fallback if positions are nil
      vim.notify("Could not capture selection range", vim.log.levels.ERROR)
    end
  else
    -- If not in Visual mode, just run code action normally
    vim.lsp.buf.code_action()
  end
end

return M
