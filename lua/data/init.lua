---@module "data"
--- This module aggregates various utility modules used throughout the configuration.
--- It provides a centralized way to access keymaps, data types, utility functions, commands, and dashboard utilities.

local keys = require("data.keys")
local types = require("data.types")
local func = require("data.func")
local cmd = require("data.cmd")
local deps = require("data.deps")
local dash = require("data.dash")

---@alias DataModule
---| { keys: table, types: table, func: table, cmd: table, deps: table, dash: table }

---@type DataModule
local data = {
  keys = keys,
  types = types,
  func = func,
  cmd = cmd,
  deps = deps,
  dash = dash,
}

return data
