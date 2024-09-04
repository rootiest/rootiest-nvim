---@module "data.dash"
--- This module contains the data for the dashboard plugins.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        DASH DATA                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

--- Function to setup the Alpha dashboard options
---@return table The alpha dashboard options
M.alpha = {
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
██████╗  ██████╗  ██████╗ ████████╗██╗███████╗███████╗████████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██║██╔════╝██╔════╝╚══██╔══╝    ████╗  ██║██║   ██║██║████╗ ████║
██████╔╝██║   ██║██║   ██║   ██║   ██║█████╗  ███████╗   ██║       ██╔██╗ ██║██║   ██║██║██╔████╔██║
██╔══██╗██║   ██║██║   ██║   ██║   ██║██╔══╝  ╚════██║   ██║      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║╚██████╔╝╚██████╔╝   ██║   ██║███████╗███████║   ██║       ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝   ╚═╝       ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

    dashboard.section.header.val = vim.split(logo, "\n")
    -- stylua: ignore start
    dashboard.section.buttons.val = {
      ---@diagnostic disable: param-type-mismatch
      dashboard.button("f", " " .. " Find file", LazyVim.pick()),
      dashboard.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", " " .. " Recent files", LazyVim.pick("oldfiles")),
      dashboard.button("g", " " .. " Grep text", LazyVim.pick("live_grep")),
      dashboard.button("z", " " .. " LazyGit", "<cmd>lua require('config.rootiest').toggle_lazygit_float() <cr>"),
      dashboard.button("c", " " .. " Config", LazyVim.pick.config_files()),
      dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("S", " " .. " Remote Session", [[<cmd> lua require("config.rootiest").load_remote() <cr>]]),
      dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }
    -- stylua: ignore end
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 10
    return dashboard
  end,
}

M.dashboard_nvim = {
  choices = {
    { -- Find File
      action = "lua LazyVim.pick()()",
      desc = " Find File",
      icon = " ",
      key = "f",
    },
    { -- New File
      action = "ene | startinsert",
      desc = " New File",
      icon = " ",
      key = "n",
    },
    { -- Open Recent Files
      action = 'lua LazyVim.pick("oldfiles")()',
      desc = " Recent Files",
      icon = " ",
      key = "r",
    },
    { -- Find Text
      action = 'lua LazyVim.pick("live_grep")()',
      desc = " Find Text",
      icon = " ",
      key = "g",
    },
    { -- LazyGit
      action = "LazyGit",
      desc = " LazyGit",
      icon = " ",
      key = "z",
    },
    { -- Config
      action = "lua LazyVim.pick.config_files()()",
      desc = " Config",
      icon = " ",
      key = "c",
    },
    { -- Restore Session
      action = 'lua require("persistence").load()',
      desc = " Restore Session",
      icon = " ",
      key = "s",
    },
    { -- Remote Session
      action = 'lua require("config.rootiest").load_remote()',
      desc = " Remote Session",
      icon = " ",
      key = "s",
    },
    { -- Lazy
      action = "Lazy",
      desc = " Lazy",
      icon = "󰒲 ",
      key = "l",
    },
    { -- Quit
      action = function()
        vim.api.nvim_input("<cmd>qa<cr>")
      end,
      desc = " Quit",
      icon = " ",
      key = "q",
    },
  },
}

return M
