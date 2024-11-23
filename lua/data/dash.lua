---@module "data.dash"
--- This module contains the data for the dashboard plugins.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        DASH DATA                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Define default path to the logo art
local logofile = vim.fn.stdpath('config') .. '/logo/' .. 'neovim.txt'
if vim.g.dash_logo then
  logofile = vim.fn.stdpath('config') .. '/logo/' .. vim.g.dash_logo
end
M.logo = logofile

-- Define dashboard button items in a single table
local dashboard_buttons = {
  -- stylua: ignore start
  { key = "f", icon = " ", desc =    " Find File",    action = function() require("data.func").pick() end },
  { key = "n", icon = " ", desc =    " New File",     action = function() vim.cmd("ene | startinsert") end },
  { key = "r", icon = " ", desc =   " Recent Files",  action = function() require("data.func").pick("oldfiles") end },
  { key = "g", icon = " ", desc =    " Grep Text",    action = function() require("data.func").pick("grep") end },
  { key = "p", icon = "󰙅 ", desc =    " Pick Tree",    action = function() require("data.func").pick("file_browser", "mini") end },
  { key = "z", icon = " ", desc =    " LazyGit",      action = function() Snacks.lazygit() end },
  { key = "c", icon = " ", desc =    " Config",       action = function() require("data.func").pick("config_files") end },
  { key = "s", icon = "󰶮 ", desc = " Restore Session", action = function() require("persistence").load() end },
  { key = "S", icon = " ", desc = " Remote Session",  action = function() require("config.rootiest").load_remote() end },
  { key = "l", icon = "󰒲 ", desc =     " Lazy",        action = function() vim.cmd("Lazy ") end },
  { key = "q", icon = " ", desc =     " Quit",        action = function() vim.api.nvim_input("<cmd>qa<cr>") end },
} -- stylua: ignore end

--- Alpha plugin configuration
M.alpha = {
  --- Function to setup the Alpha dashboard options
  ---@return table dashboard The alpha dashboard options
  opts = function()
    -- Load the alpha plugin dashboard-nvim theme
    local dashboard = require('alpha.themes.dashboard')

    --- Function to read the ASCII art from the logo file
    ---@param logo_path string The path to the logo file
    ---@return table art The ASCII art lines
    local function read_ascii_art(logo_path)
      local lines = {}
      for line in io.lines(logo_path) do
        table.insert(lines, line)
      end
      return lines
    end

    -- Read the ASCII art from the logo file
    local ascii_art_lines = read_ascii_art(M.logo)

    -- Add the ASCII art to the dashboard header
    dashboard.section.header.val = ascii_art_lines

    -- Add the dashboard buttons from the shared table
    dashboard.section.buttons.val = {}
    for _, button in ipairs(dashboard_buttons) do
      table.insert(
        dashboard.section.buttons.val,
        -- Ignore string -> function (param type is valid)
        ---@diagnostic disable: param-type-mismatch
        dashboard.button(button.key, button.icon .. button.desc, button.action)
      )
    end

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end

    -- Set up highlight groups for the dashboard
    dashboard.section.header.opts.hl = 'Conditional' or 'AlphaHeader'
    dashboard.section.footer.opts.hl = 'AlphaFooter'

    -- Calculate the dashboard layout padding
    local padding = 0
    if vim.fn.winheight(0) < 60 then
      padding = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.1) })
    elseif vim.fn.winheight(0) < 40 then
      padding = 1
    elseif vim.fn.winheight(0) < 30 then
      padding = 0
    else
      padding = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
    end

    -- Apply the padding to the dashboard layout
    dashboard.opts.layout[1].val = padding

    -- Return the dashboard options
    return dashboard
  end,
}

--- Dashboard-nvim plugin configuration
M.dashboard_nvim = {
  -- Reusing the same table for button choices in dashboard-nvim
  choices = dashboard_buttons,
}

return M
