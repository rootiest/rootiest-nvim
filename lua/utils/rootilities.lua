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

return M
