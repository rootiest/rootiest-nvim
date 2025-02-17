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

-- Common sections reused across conditions
local common_sections = {
  {
    section = 'keys',
    title = 'Shortcuts',
    icon = '󰌌 ',
    gap = 0,
    padding = 1,
    indent = 2,
  },
  {
    pane = 2,
    padding = 2,
  },
  {
    pane = 2,
    icon = ' ',
    title = 'Recent Files',
    section = 'recent_files',
    indent = 2,
    padding = 1,
    gap = 0,
  },
  {
    pane = 2,
    icon = ' ',
    title = 'Projects',
    section = 'projects',
    indent = 2,
    padding = 2,
  },
}

local function create_sections(neovide)
  local sections = {
    { section = 'header', indent = neovide and 40 or 60 },
  }

  -- Add common sections in order
  for _, common in ipairs(common_sections) do
    table.insert(sections, common)
  end

  -- Ensure "startup" is always at the end
  table.insert(sections, neovide and { section = 'startup' } or {
    section = 'startup',
    padding = 2,
    indent = 60,
  })

  if not neovide then
    local usrname = vim.g.gitname or 'rootiest'
    table.insert(sections, {
      section = 'terminal',
      cmd = 'kusa ' .. usrname .. ' && sleep 0.2',
      padding = { 0, 0 },
      height = 10,
      width = 106,
      indent = 8,
    })
  end

  return sections
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
          return create_sections(require('data.func').is_neovide())
        end,
      },
    },
  },
}
