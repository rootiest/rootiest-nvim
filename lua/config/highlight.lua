local M = {}

-- Function to convert RGB to hexadecimal
local function rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

local function get_bg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local bg = hl.bg
  if bg then
    return rgb_to_hex({
      bit.rshift(bit.band(bg, 0xFF0000), 16),
      bit.rshift(bit.band(bg, 0x00FF00), 8),
      bit.band(bg, 0x0000FF),
    })
  end
  return nil
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

-- Function to set up indent highlights
function M.setup_indent_highlight()
  -- Get the background color of CursorLine
  local cursorline_bg_hex = get_bg_color("CursorLine")

  -- Get the foreground color of Error
  local miniiconsred_fg_hex = get_fg_color("Error")

  local hooks = require("ibl.hooks")
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  if cursorline_bg_hex then
    -- Define custom highlight groups for indent using the CursorLine background color
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(
        0,
        "IndentBlanklineIndent",
        { fg = cursorline_bg_hex, nocombine = true }
      )
      vim.api.nvim_set_hl(
        0,
        "IndentsScopeHighlight",
        { fg = miniiconsred_fg_hex, nocombine = true }
      )
    end)
  end

  -- Configure the indent-blankline plugin
  require("ibl").setup({
    indent = {
      char = {
        "󰎤",
        "󰎧",
        "󰎪",
        "󰎭",
        "󰎱",
        "󰎳",
        "󰎶",
        "󰎹",
        "󰎼",
        "󰽽",
      },
      highlight = {
        "IndentBlanklineIndent",
      },
    },
    scope = {
      show_start = true,
      highlight = {
        "IndentsScopeHighlight",
        "IndentsScopeHighlight",
      },
      char = "┋",
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  })

  -- Configure the deadcolumn plugin
  require("deadcolumn").setup({
    scope = "line", ---@type string|fun(): integer
    modes = function(mode)
      return mode:find("^[ictRss\x13]") ~= nil
    end,
    blending = {
      threshold = 0.9,
      colorcode = cursorline_bg_hex,
      hlgroup = { "Normal", "bg" },
    },
    warning = {
      alpha = 0.4,
      offset = 0,
      colorcode = miniiconsred_fg_hex,
      hlgroup = { "Error", "bg" },
    },
    extra = {
      follow_tw = "80",
    },
  })

  -- Set colorcolumn
  vim.cmd(":set colorcolumn=120")
end

function M.setup_mode_highlight()
  local current_mode = vim.fn.mode()
  local bg_color

  if current_mode == "n" then
    bg_color = get_bg_color("MiniStatuslineModeNormal")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "v" then
    bg_color = get_bg_color("MiniStatuslineModeVisual")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "V" then
    bg_color = get_bg_color("MiniStatuslineModeVisual")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "R" or current_mode == "r" then
    bg_color = get_bg_color("MiniStatuslineModeReplace")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "i" then
    bg_color = get_bg_color("MiniStatuslineModeInsert")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  else
    bg_color = get_bg_color("MiniStatuslineModeNormal")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  end
end

function M.setup_dashboard_highlight()
  if not vim.g.DashboardHeaderColor then
    local dash_color = get_fg_color("Error")
    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = dash_color })
  else
    vim.api.nvim_set_hl(
      0,
      "DashboardHeader",
      { fg = vim.g.DashboardHeaderColor }
    )
  end
end

-- Setup autocommands to update on InsertEnter and ColorScheme events
function M.setup_autocommands()
  local autogrp = vim.api.nvim_create_augroup
  local autocmd = vim.api.nvim_create_autocmd
  -- Autocommand to trigger setup on InsertEnter
  autogrp("IndentHighlight", { clear = true })
  autocmd("InsertEnter", {
    group = "IndentHighlight",
    callback = function()
      M.setup_indent_highlight()
    end,
  })

  -- Autocommand to trigger setup on ColorScheme
  autocmd("ColorScheme", {
    group = "IndentHighlight",
    callback = function()
      M.setup_indent_highlight()
    end,
  })

  -- Autocommand to trigger setup on ModeChanged
  autogrp("ModeHighlighting", { clear = true })
  autocmd("ModeChanged", {
    group = "ModeHighlighting",
    callback = function()
      M.setup_mode_highlight()
    end,
  })

  -- Create a new augroup for the dashboard
  local dashboardGroup = autogrp("DashboardColors", { clear = true })
  -- Set the color for DashboardHeader when VimEnter event triggers
  autocmd("CursorMoved", {
    group = dashboardGroup,
    callback = function()
      M.setup_dashboard_highlight()
    end,
  })
  -- Reapply highlights when the colorscheme changes
  autocmd("ColorScheme", {
    pattern = "*",
    group = dashboardGroup,
    callback = function()
      M.setup_dashboard_highlight()
    end,
  })
  -- Match neovim and terminal background colors
  vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      if not normal.bg then
        return
      end
      io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
  })
  vim.api.nvim_create_autocmd("UILeave", {
    callback = function()
      io.write("\027]111\027\\")
    end,
  })
end

return M
