--          ╭─────────────────────────────────────────────────────────╮
--          │                       Cache Stats                       │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local config_dir = vim.fn.stdpath("config")
local cache_script = config_dir .. "/scripts/update_cache.sh"

-- Flag to check if the script has already been run
local script_run_once = false

-- Function to run the cache update script using vim.system
function M.setup_script()
  if not script_run_once then
    vim.system({ cache_script }, { detach = true }, function() end)
    script_run_once = true
  end
end

-- Run the setup script only once
M.setup_script()

return M
