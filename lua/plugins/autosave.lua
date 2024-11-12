--          ╭─────────────────────────────────────────────────────────╮
--          │                        Auto-Save                        │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Auto-save
    'okuuva/auto-save.nvim',
    cmd = require('data.cmd').autosave,
    event = { 'InsertLeave', 'TextChanged' },
    opts = require('data.types').autosave,
    cond = require('data.cond').autosave,
  },
}
