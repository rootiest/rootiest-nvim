--          ╭─────────────────────────────────────────────────────────╮
--          │                       Cache Stats                       │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local config_dir = vim.fn.stdpath("config")
local cache_script = config_dir .. "/scripts/update_cache.sh"

-- Function to run the cache update script using vim.system
function M.setup_script()
  vim.system({ cache_script }, { detach = true }, function() end)
end

M.setup_script()

return M
