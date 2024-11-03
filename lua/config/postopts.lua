--  ━━━━━━━━━━━━━━━━━━━━━━━━ Post-Config Functions ━━━━━━━━━━━━━━━━━━━━━━━━

-- Setup blinky cursor
require("utils.blinky").setup(vim.g.blinky)

-- Setup nvim-remote
if vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end
