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

-- Run the setup script
M.setup_script()

return M
