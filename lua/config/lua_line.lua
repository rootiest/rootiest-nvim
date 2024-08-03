-- -----------------------------------------------------------------------------
-- -------------------------------- LUA-LINE -----------------------------------
-- -----------------------------------------------------------------------------

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif
      trunc_width
      and trunc_len
      and win_width < trunc_width
      and #str > trunc_len
    then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc_front(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif
      trunc_width
      and trunc_len
      and win_width < trunc_width
      and #str > trunc_len
    then
      local truncated_str = str:sub(-trunc_len)
      return (no_ellipsis and "" or "...") .. truncated_str
    end
    return str
  end
end

-- Function to convert RGB to hexadecimal
local function rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

local function get_fg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local fg = hl.fg
  if fg then
    return rgb_to_hex({
      bit.rshift(bit.band(fg, 0xFF0000), 16),
      bit.rshift(bit.band(fg, 0x00FF00), 8),
      bit.band(fg, 0x0000FF),
    })
  end
  return nil
end

-- Ensure the function is called only once
local lualine_updated = false

-- Function to add custom sections to lualine
local function add_custom_sections_to_lualine()
  if lualine_updated then
    return
  end
  lualine_updated = true

  -- Require the dependencies
  local wakatime_cache = require("config.wakatime_cache")
  local music_current = require("config.music_stats")
  local git_blame = require("gitblame")

  -- Get the current lualine configuration
  local config = require("lualine").get_config()

  config.options.section_separators = { left = "", right = "" }

  config.options.component_separators = { left = "", right = "" }

  config.options.globalstatus = true

  -- Replace the lualine_a section
  config.sections.lualine_a = {
    { "mode", fmt = trunc(80, 4, 0, true) },
  }

  -- Replace the lualine_b section
  config.sections.lualine_b = {
    { "branch", fmt = trunc(80, 4, 0, true) },
  }

  -- Add Git-blame to lualine_c section
  table.insert(config.sections.lualine_c, {
    git_blame.get_current_blame_text,
    fmt = trunc_front(160, 40, 120, true),
    cond = git_blame.is_blame_text_available,
    color = { fg = get_fg_color("GitSignsCurrentLineBlame") },
  })

  -- Add the WakaTime data to the lualine_x section
  table.insert(config.sections.lualine_x, {
    function()
      return (wakatime_cache.get_today() or "Loading...")
    end,
    icon = wakatime_cache.get_icon(),
    fmt = trunc(120, 20, 120, true),
    color = function()
      if wakatime_cache.get_total_minutes() >= 60 then
        return { fg = get_fg_color("diffAdded") }
      elseif wakatime_cache.get_total_minutes() >= 30 then
        return { fg = get_fg_color("diffOldFile") }
      else
        return { fg = get_fg_color("diffRemoved") }
      end
    end,
    on_click = function(button)
      if button == "left" then
        vim.cmd(":WakaTimeToday")
      end
    end,
  })

  -- Add the Music Current data to the lualine_y section
  table.insert(config.sections.lualine_y, {
    function()
      return music_current.get_current() -- Always display the current state
    end,
    icon = music_current.get_icon(),
    fmt = trunc(120, 20, 80, true),
    on_click = function(button)
      if button == "left" then
        vim.cmd(":MusicPause")
      elseif button == "right" then
        vim.cmd(":MusicNext")
      end
    end,
  })

  -- Add word count to the lualine_y section
  table.insert(config.sections.lualine_y, 1, {
    function()
      return vim.fn.wordcount().words
    end,
    icon = " ",
    fmt = trunc(140, 20, 140, true),
  })

  -- Add selection_count to the lualine_y section
  table.insert(config.sections.lualine_y, 2, {
    "selection_count",
    fmt = trunc(120, 20, 120, true),
  })

  -- Add filesize to the lualine_y section
  table.insert(config.sections.lualine_y, {
    "filesize",
    fmt = trunc(120, 20, 120, true),
  })

  -- Add search count to the lualine_z section
  table.insert(config.sections.lualine_z, 1, {
    "searchcount",
    fmt = trunc(80, 20, 80, true),
    color = "CurSearch",
    separator = { left = "", right = "" },
    icon = "󰍉 ",
  })

  -- Apply the new configuration
  require("lualine").setup(config)
end

-- Use an autocommand to ensure it runs after lualine is set up
vim.api.nvim_create_autocmd("User", {
  pattern = "LualineSetup",
  callback = add_custom_sections_to_lualine,
})

-- Or use defer_fn if you're unsure about the exact timing
vim.defer_fn(add_custom_sections_to_lualine, 100) -- Delay in milliseconds
