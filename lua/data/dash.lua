---@module "data.dash"
--- This module contains the data for the dashboard plugins.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        DASH DATA                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Define default path to the logo art
M.logo = vim.g.dash_logo or "logo/neovim.txt"

--- Alpha plugin configuration
M.alpha = {
  --- Function to setup the Alpha dashboard options
  ---@return table dashboard The alpha dashboard options
  opts = function()
    -- Load the alpha plugin dashboard-nvim theme
    local dashboard = require("alpha.themes.dashboard")

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

    -- Add the dashboard buttons
    -- stylua: ignore start
    dashboard.section.buttons.val = {
      ---@diagnostic disable: param-type-mismatch
      dashboard.button("f", " " .. " Find file", LazyVim.pick("find_files")),
      dashboard.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", " " .. " Recent files", LazyVim.pick("oldfiles")),
      dashboard.button("g", " " .. " Grep text", LazyVim.pick("live_grep")),
      dashboard.button("z", " " .. " LazyGit", "<cmd>lua require('config.rootiest').toggle_lazygit_float() <cr>"),
      dashboard.button("c", " " .. " Config", LazyVim.pick.config_files()),
      dashboard.button("s", "󰶮 " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("S", " " .. " Remote Session", [[<cmd> lua require("config.rootiest").load_remote() <cr>]]),
      dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    -- stylua: ignore end

    -- Set up highlight groups for the dashboard
    dashboard.section.header.opts.hl = "Conditional" or "AlphaHeader"
    dashboard.section.footer.opts.hl = "AlphaFooter"

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
  -- stylua: ignore start
  choices = {
    { action = 'lua LazyVim.pick("find_files")()', desc = " Find File", icon = " ", key = "f"},
    { action = "ene | startinsert", desc = " New File", icon = " ", key = "n"},
    { action = 'lua LazyVim.pick("oldfiles")()', desc = " Recent Files", icon = " ", key = "r"},
    { action = 'lua LazyVim.pick("live_grep")()', desc = " Find Text", icon = " ", key = "g"},
    { action = "LazyGit", desc = " LazyGit", icon = " ", key = "z"},
    { action = "lua LazyVim.pick.config_files()()", desc = " Config", icon = " ", key = "c"},
    { action = 'lua require("persistence").load()', desc = " Restore Session", icon = "󰶮 ", key = "s"},
    { action = 'lua require("config.rootiest").load_remote()', desc = " Remote Session", icon = " ", key = "s"},
    { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l"},
    { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q"},
  },
  -- stylua: ignore end
}

return M
