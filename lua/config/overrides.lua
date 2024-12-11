--          ╭─────────────────────────────────────────────────────────╮
--          │                        Overrides                        │
--          ╰─────────────────────────────────────────────────────────╯

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Keymap Overrides ━━━━━━━━━━━━━━━━━━━━━━━

-- Add keymapper function
local add_keymap = require('data.func').add_keymap

-- Add keymaps for overrides
add_keymap(require('data.keys').overrides)

-- Replace '...' with '…' (ellipsis) on InsertLeave
require('data.func').setup_replace_ellipsis(true)

-- Search selected text in visual mode
add_keymap('/', '*<Esc>', 'Search selected text', 'v')

-- Use modern cipher instead of rot13
add_keymap(require('data.keys').cipher.hex)

-- Help keybinds
for _, item in ipairs(require('data.keys').help) do
  add_keymap(item)
end

-- Remap Command Mode List
require('data.keys').cmd_mode()

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Additional Overrides ━━━━━━━━━━━━━━━━━━━━━

-- Disable NeoMiniMap in Termux
if vim.g.is_termux then
  if require('data.func').is_installed('neominimap') then
    -- Disable NeoMiniMap
    vim.cmd('Neominimap off')
  end
end

-- Allow directional motions to wrap to next line
-- vim.cmd('set whichwrap+=h,l')

-- Stop snippet when leaving insert mode
vim.keymap.set({ 'i', 's' }, '<Esc>', function()
  vim.snippet.stop()
  return '<Esc>'
end, { expr = true, desc = 'Close snippet session' })

-- Swap the behavior of 'p' and 'P' while preserving plugin-defined behaviors
local opts = { noremap = false, silent = true, remap = true }

vim.keymap.set('n', 'p', 'P', opts)
vim.keymap.set('n', 'P', 'p', opts)
vim.keymap.set('n', 'q:', function()
  require('data.func').pick('command_history')
end, opts)

vim.api.nvim_create_user_command('ListLspClients', function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then
    print('No LSP attached')
  else
    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    print('Attached LSP(s): ' .. table.concat(names, ', '))
  end
end, {})
