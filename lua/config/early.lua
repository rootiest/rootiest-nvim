--          ╭─────────────────────────────────────────────────────────╮
--          │                   Early interventions                   │
--          ╰─────────────────────────────────────────────────────────╯

-- Execute project-specific configuration if it exists
local project_config = vim.fn.getcwd() .. '/.nvim.lua'
if vim.fn.filereadable(project_config) == 1 then
  dofile(project_config)
end

-- Address vim.hl bug impacting `:Inspect` command
---@see https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight
