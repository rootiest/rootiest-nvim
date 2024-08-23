--          ╭─────────────────────────────────────────────────────────╮
--          │                       Cache Stats                       │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Path to the cache script
local config_dir = vim.fn.stdpath("config")
---@diagnostic disable-next-line: param-type-mismatch
local cache_script = vim.fs.joinpath(config_dir, "/scripts/update_cache.sh")

-- Flag to check if the script has already been run
local script_run_once = false

-- Function to run the cache update script using vim.system
function M.setup_script()
  if not script_run_once then
    -- Run the cache script
    vim.system({ cache_script }, { detach = true }, function() end)
    -- Prevent the script from running again
    script_run_once = true
  end
end

-- Run the setup script only once
M.setup_script()

return M
