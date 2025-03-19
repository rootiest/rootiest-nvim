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
  Pick('command_history')
end, opts)

vim.api.nvim_create_user_command('LspListClients', function()
  local clients =
    vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
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

-- Statuscolumn Tweaks
require('config.statuscolumn')

-- Macro recording cursor color
local api = vim.api
-- Store current cursor color
local current_cursor_color = api.nvim_get_hl(0, { name = 'Cursor' }).bg

api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    api.nvim_set_hl(0, 'Cursor', { bg = '#ff5080' })
  end,
})

api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    api.nvim_set_hl(0, 'Cursor', { bg = current_cursor_color })
  end,
})

-- Remap 'q' to 'Q' to reduce accidental macros
if pcall(require, 'which-key') then
  require('which-key').add({
    lhs = 'q',
    rhs = '<nop>',
    mode = 'n',
    hidden = true,
  })
else
  vim.keymap.set('n', 'q', '<nop>', { noremap = true })
end
vim.keymap.set('n', 'Q', 'q', { noremap = true, desc = 'Record macro' })
vim.keymap.set(
  'n',
  '<M-q>',
  'Q',
  { noremap = true, desc = 'Replay last register' }
)

---------------------------------------------------------------------------
--          ╓─────────────────────────────────────────────────────────╖
--          ║  Scroll half a screen with <C-d> and <C-u>              ║
--          ║           (with count and memory)                       ║
--          ╙─────────────────────────────────────────────────────────╜
local last_scroll_count = 1 -- Store the last used count

-- Define the ScrollDirection type
---@alias ScrollDirection 'up'|'down'

--- Scroll half a screen up or down
---@param direction ScrollDirection The direction to scroll in
local function scroll(direction)
  -- Set the count to the provided count or the last used count
  local count = vim.v.count > 0 and vim.v.count or last_scroll_count
  -- Remember the count for next time
  last_scroll_count = count

  -- To remove the memory feature, uncomment the following line
  -- count = vim.v.count > 0 and vim.v.count or 1  -- Use current count or default to 1

  -- Calculate the number of lines in a half-screen
  local half_screen = math.floor(vim.api.nvim_win_get_height(0) / 2)
  -- Generate the key sequence
  local keys = count * half_screen .. (direction == 'down' and '\x04' or '\x15')

  -- Execute the key sequence
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    'n',
    false
  )
end

-- Map the scroll functions to <C-d> and <C-u>
vim.keymap.set('n', '<C-d>', function()
  scroll('down')
end, { silent = true })
vim.keymap.set('n', '<C-u>', function()
  scroll('up')
end, { silent = true })
---------------------------------------------------------------------------
