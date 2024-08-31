local M = {}

--- Function to set up blinky cursor
---@return boolean state true if the cursor is enabled, false otherwise
function M.enable()
  -- Set the cursor to a blinking state
  vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor", -- Block cursor in normal, visual, and command modes
    "i:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- Blinking vertical line in insert mode
    "r-cr-o:hor20-Cursor/lCursor", -- Horizontal line cursor in replace, command-line replace, and operator-pending modes
    "a:blinkwait700-blinkoff400-blinkon250", -- Global blinking settings for all modes
  }
  return true
end

--- Function to disable blinky cursor
---@return boolean state true if the cursor is enabled, false otherwise
function M.disable()
  -- Set the cursor to a non-blinking state
  vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
  return false
end

return M
