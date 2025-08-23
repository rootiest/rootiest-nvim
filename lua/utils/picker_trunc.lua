local M = {}

--- Recursively find the width for a window by name
---@param layout table
---@param target_win string
---@return number|nil
local function find_win_width(layout, target_win)
  for _, item in ipairs(layout) do
    if type(item) == 'table' then
      if item.win == target_win and item.width then
        return item.width
      elseif vim.islist(item) or item.box then
        local result = find_win_width(item, target_win)
        if result then
          return result
        end
      end
    end
  end
  return nil
end

--- Get relative window width
---@param fraction number fraction of the main window width
---@param layout_name string the snacks layout to use
---@param target_win string the window name to extract width for
---@return number width the relative width in columns
function M.get_relative_win_width(fraction, layout_name, target_win)
  vim.validate({
    fraction = { fraction, 'number', true },
    layout_name = { layout_name, 'string', true },
    target_win = { target_win, 'string', true },
  })

  if fraction < 0 then
    return 0
  elseif fraction > 1 then
    return 1
  end

  local win_width = vim.api.nvim_win_get_width(0)
  local top_level_fraction = 1
  local nested_win_fraction = 1

  local ok, snacks = pcall(require, 'snacks')
  if ok then
    local layouts = snacks.config
      and snacks.config.picker
      and snacks.config.picker.layouts

    local chosen_layout = layouts
      and layouts[layout_name]
      and layouts[layout_name].layout

    if chosen_layout then
      -- Check for layout-wide width
      if type(chosen_layout) == 'table' and chosen_layout.width then
        top_level_fraction = chosen_layout.width
      end

      -- Check inside nested win="target_win"
      nested_win_fraction = find_win_width(chosen_layout, target_win) or 1
    end
  end

  local combined_fraction = fraction * top_level_fraction * nested_win_fraction
  return math.floor(win_width * combined_fraction + 0.5)
end

--- Truncate the picker file text
---@param fraction number|nil
---@param layout_name string|nil
---@param target_win string|nil
---@param picker_type string|nil
function M.trunc_text(fraction, layout_name, target_win, picker_type)
  fraction = fraction or 1.0
  layout_name = layout_name or 'default'
  target_win = target_win or 'list'
  picker_type = picker_type or 'files'

  local trunc_width =
    M.get_relative_win_width(fraction, layout_name, target_win)

  local ok, snacks = pcall(require, 'snacks')
  if not ok then
    vim.notify('snacks.nvim not loaded', vim.log.levels.ERROR)
    return
  end

  local picker = snacks.picker and snacks.picker[picker_type]
  if type(picker) ~= 'function' then
    vim.notify(
      'Invalid Snacks.picker type: ' .. tostring(picker_type),
      vim.log.levels.ERROR
    )
    return
  end

  picker({
    layout = { preset = layout_name },
    formatters = { file = { truncate = trunc_width } },
  })
end

return M
