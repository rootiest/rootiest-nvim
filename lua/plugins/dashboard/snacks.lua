--          ╭─────────────────────────────────────────────────────────╮
--          │                    Snacks Dashboard                     │
--          ╰─────────────────────────────────────────────────────────╯

local fallback_logo = require('data.dash').fallback_logo

local function read_file(file_path)
  local success, content_or_error = pcall(function()
    local file = assert(io.open(file_path, 'r')) -- Open the file in read mode
    local content = file:read('*a') -- Read the entire file content
    file:close() -- Close the file
    return content
  end)
  if not success then
    return fallback_logo
  end
  return content_or_error
end

return {
  {
    'folke/snacks.nvim',
    opts = {
      dashboard = {
        enabled = require('data.func').check_global_var(
          'dashboard',
          'snacks',
          'alpha'
        ),
        preset = {
          keys = require('data.dash').dashboard_nvim.choices,
          header = read_file(require('data.dash').logo),
        },
        sections = function()
          if not require('data.func').is_neovide() then
            return {
              { section = 'header', indent = 58 },
              -- {
              --   section = 'terminal',
              --   cmd = 'pokemon-colorscripts -n porygon-z --no-title',
              --   padding = 0,
              --   height = 20,
              --   indent = 44,
              -- },
              { section = 'keys', gap = 1, padding = 1 },
              {
                pane = 2,
                icon = ' ',
                title = 'Recent Files',
                section = 'recent_files',
                indent = 2,
                padding = { 2, 4 },
              },
              {
                pane = 2,
                icon = ' ',
                title = 'Projects',
                section = 'projects',
                indent = 2,
                padding = 2,
              },
              {
                pane = 2,
                icon = ' ',
                title = 'Git Status',
                section = 'terminal',
                enabled = require('data.func').is_git_repo(),
                cmd = 'hub status --short --branch --renames',
                padding = 2,
                indent = 3,
                ttl = 1 * 60, -- Time between git updates
              },
              { section = 'startup', padding = 2 },
              {
                section = 'terminal',
                cmd = 'kusa rootiest && sleep 0.2',
                -- cmd = 'gh graph -s github -p %E2%96%88',
                padding = { 0, 0 },
                height = 10,
                width = 106,
                indent = 8,
              },
            }
          else
            return {
              {
                section = 'header',
                indent = 40,
              },
              { section = 'keys', gap = 1, padding = 1 },
              {
                pane = 2,
                icon = ' ',
                title = 'Recent Files',
                section = 'recent_files',
                indent = 2,
                padding = { 2, 20 },
              },
              {
                pane = 2,
                icon = ' ',
                title = 'Projects',
                section = 'projects',
                indent = 2,
                padding = 2,
              },
              { section = 'startup' },
            }
          end
        end,
      },
    },
  },
}
