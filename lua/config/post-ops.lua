---@module "config.post_ops"
--- This module contains the functions that exectute after
--- the options.lua file has been loaded.
--          ╭─────────────────────────────────────────────────────────╮
--          │                       Post Ops                          │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

M.apply_options = function()
  -- Setup blinky cursor
  require("utils.blinky").setup(vim.g.blinky)

  -- Setup Rootiest cmd window
  require("utils.cmd_window").setup({
    override_cmdline = vim.g.rootiest_cmd and true or nil,
  })
end

-- Setup post-ops module
M.setup = function()
  M.apply_options()
end

-- Call setup
M.setup()

return M
