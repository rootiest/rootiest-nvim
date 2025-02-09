-- Setup gradient line number column

-- Table to hold hex color values for easy reference
local colors = {
  statusLineNrCurrent = '#b3befe',
  statusLineNrDefault = '#444659',
  fallbackColor = '#808080', -- Fallback gray if the group doesn't exist
}

--- Calculate a color gradient between two colors.
-- @param base_color (string) The starting color in hex format (e.g., '#RRGGBB').
-- @param target_color (string) The ending color in hex format (e.g., '#RRGGBB').
-- @param max_steps (number) The total number of steps in the gradient.
-- @param step (number) The current step in the gradient.
-- @return (string) The interpolated color in hex format.
local function calculate_gradient(base_color, target_color, max_steps, step)
  -- Parse the base and target colors into RGB components
  local br, bg, bb =
    tonumber(base_color:sub(2, 3), 16),
    tonumber(base_color:sub(4, 5), 16),
    tonumber(base_color:sub(6, 7), 16)

  local tr, tg, tb =
    tonumber(target_color:sub(2, 3), 16),
    tonumber(target_color:sub(4, 5), 16),
    tonumber(target_color:sub(6, 7), 16)

  -- Calculate the blending factor
  local factor = step / max_steps

  -- Interpolate between the base and target colors based on the blending factor
  local r = math.floor(br + (tr - br) * factor)
  local g = math.floor(bg + (tg - bg) * factor)
  local b = math.floor(bb + (tb - bb) * factor)

  return string.format('#%02X%02X%02X', r, g, b) -- Return the new color as a string
end

--- Get the foreground color of a highlight group.
-- @param group (string) The name of the highlight group.
-- @return (string) The foreground color in hex format or a fallback gray color.
local function get_highlight_fg(group)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  if hl and hl.fg then
    return string.format('#%06X', hl.fg) -- Convert the integer color to hex
  else
    return colors.fallbackColor -- Use fallback gray if the group doesn't exist
  end
end

--- Set up gradient highlights for a specified group.
-- @param base_color (string) The starting color for the gradient.
-- @param group_name_prefix (string) The prefix for the highlight group names.
-- @param max_steps (number) The total number of steps for the gradient.
local function setup_gradient_highlights(
  base_color,
  group_name_prefix,
  max_steps
)
  local target_color = get_highlight_fg('StatusLineNrDefault') -- Get the default color for interpolation
  for step = 1, max_steps do
    local color = calculate_gradient(base_color, target_color, max_steps, step) -- Get the gradient color
    vim.api.nvim_set_hl(
      0,
      group_name_prefix .. step,
      { fg = color, bg = 'NONE' } -- Set the highlight with foreground color and no background
    )
  end
end

-- Define highlight groups for current and default status line numbers
vim.api.nvim_set_hl(
  0,
  'StatusLineNrCurrent',
  { fg = colors.statusLineNrCurrent, bg = 'NONE', bold = true }
)
vim.api.nvim_set_hl(
  0,
  'StatusLineNrDefault',
  { fg = colors.statusLineNrDefault, bg = 'NONE' }
)

-- Set up gradient highlights for lines above and below the cursor
setup_gradient_highlights(colors.statusLineNrCurrent, 'StatusLineNrAbove', 10)
setup_gradient_highlights(colors.statusLineNrCurrent, 'StatusLineNrBelow', 10)

-- Custom status column for displaying line number gradients
_G.CustomStatusColumn = function()
  local lnum = vim.v.lnum -- Current line number
  local cursor_lnum = vim.fn.line('.') -- Current cursor line number
  local max_gradient_steps = 10 -- Maximum steps in gradient

  -- Use the plugin's original status column
  local original_statuscolumn = require('snacks.statuscolumn').get()

  -- Highlight for the current line
  if lnum == cursor_lnum then
    return '%#StatusLineNrCurrent#' .. original_statuscolumn .. '%*'
  end

  -- Highlight for lines above the cursor
  if lnum < cursor_lnum and (cursor_lnum - lnum) <= max_gradient_steps then
    local step = cursor_lnum - lnum
    return '%#StatusLineNrAbove' .. step .. '#' .. original_statuscolumn .. '%*'
  end

  -- Highlight for lines below the cursor
  if lnum > cursor_lnum and (lnum - cursor_lnum) <= max_gradient_steps then
    local step = lnum - cursor_lnum
    return '%#StatusLineNrBelow' .. step .. '#' .. original_statuscolumn .. '%*'
  end

  -- Default case for other lines
  return '%#StatusLineNrDefault#' .. original_statuscolumn .. '%*'
end

-- Set the custom status column to be used
vim.o.statuscolumn = [[%!v:lua.CustomStatusColumn()]]
