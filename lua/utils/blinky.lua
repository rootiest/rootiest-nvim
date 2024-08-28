local M = {}

-- Function to set up blinky cursor
function M.enable()
  vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor", -- Block cursor in normal, visual, and command modes
    "i:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- Blinking vertical line in insert mode
    "r-cr-o:hor20-Cursor/lCursor", -- Horizontal line cursor in replace, command-line replace, and operator-pending modes
    "a:blinkwait700-blinkoff400-blinkon250", -- Global blinking settings for all modes
  }
end

return M
