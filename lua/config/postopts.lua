--  ━━━━━━━━━━━━━━━━━━━━━━━━ Post-Config Functions ━━━━━━━━━━━━━━━━━━━━━━━━

-- Setup blinky cursor
require("utils.blinky").setup(vim.g.blinky)

-- Setup nvim-remote
if vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

-- Check for termux
local prefix = vim.env.PREFIX

-- Check if prefix contains "com.termux"
if prefix ~= nil then
  if prefix:match("com.termux") then
    vim.g.useimage = false
    vim.g.is_termux = true
  end
end
