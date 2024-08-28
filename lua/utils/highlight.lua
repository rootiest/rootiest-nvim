--          ╭─────────────────────────────────────────────────────────╮
--          │                        Highlight                        │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

-- Load utils
local utils = require("utils.rootiest")
local data = require("data")
-- Readability functions
local get_bg_color = utils.get_bg_color
local get_fg_color = utils.get_fg_color
local set_hl = vim.api.nvim_set_hl
local sign_def = vim.fn.sign_define

-- Function to set up indent highlights
function M.setup_indent_highlight()
  -- Get the background color of CursorLine
  local cursorline_bg_hex = get_bg_color("CursorLine")

  -- Get the foreground color of Error
  local miniiconsred_fg_hex = get_fg_color("Error")

  -- Load the ibl plugin hooks
  local hooks = require("ibl.hooks")
  -- create the highlight groups in the highlight setup hook
  if cursorline_bg_hex then
    -- Define custom highlight groups for indent
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      set_hl(
        0,
        "IndentBlanklineIndent",
        { fg = cursorline_bg_hex, nocombine = true }
      )
      set_hl(
        0,
        "IndentsScopeHighlight",
        { fg = miniiconsred_fg_hex, nocombine = true }
      )
    end)
  end

  -- Configure the indent-blankline plugin
  require("ibl").setup({
    indent = {
      char = vim.g.indent_char or data.types.ibl.indent_char.none,
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
      char = vim.g.scope_char or data.types.ibl.scope_char.light,
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    exclude = {
      filetypes = data.types.highlights.exclude,
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

-- Function to set up mode highlights
function M.setup_mode_highlight()
  local current_mode = vim.fn.mode()
  local bg_color -- Define bg_color variable
  if current_mode == "n" then
    bg_color = get_bg_color("MiniStatuslineModeNormal")
    set_hl(0, "SmoothCursor", { fg = bg_color })
    sign_def("smoothcursor", { text = "" })
  elseif current_mode == "v" then
    bg_color = get_bg_color("MiniStatuslineModeVisual")
    set_hl(0, "SmoothCursor", { fg = bg_color })
    sign_def("smoothcursor", { text = "" })
  elseif current_mode == "V" then
    bg_color = get_bg_color("MiniStatuslineModeVisual")
    set_hl(0, "SmoothCursor", { fg = bg_color })
    sign_def("smoothcursor", { text = "" })
  elseif current_mode == "R" or current_mode == "r" then
    bg_color = get_bg_color("MiniStatuslineModeReplace")
    set_hl(0, "SmoothCursor", { fg = bg_color })
    sign_def("smoothcursor", { text = "" })
  elseif current_mode == "i" then
    bg_color = get_bg_color("MiniStatuslineModeInsert")
    set_hl(0, "SmoothCursor", { fg = bg_color })
    sign_def("smoothcursor", { text = "" })
  else
    bg_color = get_bg_color("MiniStatuslineModeNormal")
    set_hl(0, "SmoothCursor", { fg = bg_color })
    sign_def("smoothcursor", { text = "" })
  end
end

-- Function to set up dashboard header highlight
function M.setup_dashboard_highlight()
  if not vim.g.DashboardHeaderColor then
    local dash_color = get_fg_color("Error")
    set_hl(0, "DashboardHeader", { fg = dash_color })
  else
    set_hl(0, "DashboardHeader", { fg = vim.g.DashboardHeaderColor })
  end
end

-- Set up transparency
function M.setup_transparency()
  if data.func.is_kitty() and not vim.g.disable_transparency then
    vim.cmd("TransparentEnable")
  else
    vim.cmd("TransparentDisable")
  end
end

-- Setup autocommands to update on InsertEnter and ColorScheme events
function M.setup_autocommands()
  local autogrp = vim.api.nvim_create_augroup
  local autocmd = vim.api.nvim_create_autocmd

  -- List of filetypes to exclude
  local excluded_filetypes = data.types.highlights.exclude

  -- Create a new augroup for the IndentHighlight
  local IndentGroup = autogrp("IndentHighlight", { clear = true })
  -- Autocommand to trigger setup on FileType
  autocmd("FileType", {
    group = IndentGroup,
    callback = function()
      local filetype = vim.bo.filetype
      if not vim.tbl_contains(excluded_filetypes, filetype) then
        M.setup_indent_highlight()
      end
    end,
  })
  -- Autocommand to trigger setup on ColorScheme
  autocmd("ColorScheme", {
    pattern = "*",
    group = IndentGroup,
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
  -- Autocommand to trigger setup on FileType
  autocmd("FileType", {
    pattern = "*",
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

  -- Create a new augroup for the terminal background
  local terminalGroup = autogrp("TerminalColors", { clear = true })
  -- Match neovim and terminal background colors
  autocmd({ "UIEnter", "ColorScheme" }, {
    group = terminalGroup,
    callback = function()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      if not normal.bg then
        return
      end
      io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
  })
  -- Reset terminal background on UILeave
  autocmd("UILeave", {
    group = terminalGroup,
    callback = function()
      io.write("\027]111\027\\")
    end,
  })
end

return M
