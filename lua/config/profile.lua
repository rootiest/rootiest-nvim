--- @module "config.profile"
--- This module configures the profiler for the Neovim configuration.
--- This tool can be used to profile specific modules or all modules.
---
--- The profiler can be toggled with the leader keybinding `d<f1>`
--- or with the `NVIM_PROFILE` environment variable.
---
--- Specific modules can be selected with the `NVIM_PROFILE_MODULE`
--- environment variable.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        PROFILER                         │
--          ╰─────────────────────────────────────────────────────────╯

-- Check if the environment variable is set
local should_profile = os.getenv("NVIM_PROFILE")
local profile_module = os.getenv("NVIM_PROFILE_MODULE") or "*"

-- Start the profiler
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start(profile_module)
  else
    require("profile").instrument(profile_module)
  end
end

-- Function to toggle the profiler
local function toggle_profile()
  local prof = require("profile")
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({
      prompt = "Save profile to:",
      completion = "file",
      default = "profile.json",
    }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format("Wrote %s", filename))
      end
    end)
  else
    prof.start(profile_module)
  end
end

-- Add the keybind to toggle the profiler
require("data").func.add_keymap("<leader>d<f1>", function()
  local prof_name = profile_module
  if profile_module == "*" then
    prof_name = "all"
  end
  print("Profiling module: " .. prof_name)
  toggle_profile()
end, "Toggle Profiler")
