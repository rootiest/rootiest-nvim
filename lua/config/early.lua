--          ╭─────────────────────────────────────────────────────────╮
--          │                   Early interventions                   │
--          ╰─────────────────────────────────────────────────────────╯

-- Address vim.hl bug impacting `:Inspect` command
---@see https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight
