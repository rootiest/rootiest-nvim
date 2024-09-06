---@module "utils.cache_stats"
--- This module provides a function to update the cached statistics.
--          ╭─────────────────────────────────────────────────────────╮
--          │                       Cache Stats                       │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Options ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Options can be set with:
--    vim.g.stats_wakatime = true|false (default: true)
--    vim.g.stats_music = true|false (default: true)
--    vim.g.stats_ignored_players = { "player1", "player2", ... }

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Script execution ━━━━━━━━━━━━━━━━━━━━━━━
-- Path to the cache script
local config_dir = vim.fn.stdpath("config") --[[@as string]]
local cache_script = vim.fs.joinpath(config_dir, "scripts", "update_cache.sh")

-- Path to the Neovim cache directory
_G.cache_stats_dir = -- Cache directory
  vim.fn.stdpath("cache") --[[@as string]]

-- Flag to check if the script has already been run
local script_run_once = false

-- Variable to track the pid
---@type number|boolean
M.pid = false

-- Default list of players/sources to ignore when updating the status
local ignored_players = {
  "chromium",
  "firefox",
  "kdeconnect",
  "haruna",
  "plasma-browser-integration",
  "plasma-browser-integration-76042",
}

-- Add any vim.g.stats_ignored_players to the list
for _, player in ipairs(vim.g.stats_ignored_players or {}) do
  table.insert(ignored_players, player)
end

-- Set the default values for the options
vim.g.stats_music = vim.g.stats_music or true
vim.g.stats_wakatime = vim.g.stats_wakatime or true

--- Function to run the cache script
---@return boolean|number pid The pid of the script
function M.setup_script()
  if not script_run_once then
    -- Build the arguments for the cache script
    local args = { cache_script }

    -- Add the --cache-dir option
    table.insert(args, "--cache-dir")
    table.insert(args, _G.cache_stats_dir)

    -- Add the --ignore option with the ignored players
    if #ignored_players > 0 then
      table.insert(args, "--ignore")
      table.insert(args, table.concat(ignored_players, ","))
    end

    -- Add the --disable-wakatime option if wakatime is disabled
    if vim.g.stats_wakatime == false then
      table.insert(args, "--disable-wakatime")
    end

    -- Add the --no-music option if music is disabled
    if vim.g.stats_music == false then
      table.insert(args, "--no-music")
    end

    -- Prevent the script from running again
    script_run_once = true

    -- Run the cache script with the constructed arguments
    local script = vim.system(args, { detach = true }, function() end)

    -- Return the pid of the script
    return script.pid
  end

  -- Return false if the script has already been run
  return false
end

---@function Function to force the script to reset
---        This will kill the script if it's running and delete the lock file.
---        Optionally the cache files will be deleted if wipe is true.
---        By default, the cache files will not be deleted.
---        If the script is not running, this function will start the script.
---@param wipe boolean|nil Whether to wipe the cache files (default: false)
---        If true, the cache files will be deleted.
---        If false, the cache files will not be deleted.
---
---        The cache files are:
---        - music_cache.txt
---        - wakatime_cache.txt
---@return boolean|number pid The pid of the script
function M.reset_script(wipe)
  -- Try to kill the script if it's running
  if M.pid and vim.fn.jobstop(M.pid) == 0 then
    M.pid = false
  end
  -- Remove the lockfile
  vim.fn.delete(
    vim.fs.joinpath(_G.cache_stats_dir, "music_wakatime_update.lock")
  )
  -- Wipe the cache files
  if wipe then
    vim.fn.delete(vim.fs.joinpath(_G.cache_stats_dir, "music_cache.txt"))
    vim.fn.delete(vim.fs.joinpath(_G.cache_stats_dir, "wakatime_cache.txt"))
  end
  -- Reset the script_run_once flag
  script_run_once = false
  -- Re-run the script
  M.pid = M.setup_script()
  -- Return the pid
  return M.pid
end

-- Run the setup script
M.pid = M.setup_script()

return M
