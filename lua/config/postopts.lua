--  ━━━━━━━━━━━━━━━━━━━━━━━━ Post-Config Functions ━━━━━━━━━━━━━━━━━━━━━━━━

--- Function to setup post-opts
local function setup()
  -- Setup blinky cursor
  require('utils.blinky').setup(vim.g.blinky)

  -- Setup nvim-remote
  if vim.fn.executable('nvr') == 1 then
    vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  end

  -- Check for termux
  local prefix = vim.env.PREFIX

  -- Check if prefix contains "com.termux"
  if prefix ~= nil then
    if prefix:match('com.termux') then
      vim.g.useimage = false
      vim.g.is_termux = true
      vim.g.useavante = false
    end
  end

  -- Define intel_arch
  local intel_arch = { x64 = true, x86 = true }
  local cur_arch = require('data.func').get_system_arch()

  -- Check the platform and disable incompatible plugins
  if not intel_arch[cur_arch] then
    vim.g.useimage = false
    vim.g.useavante = false
  end
end

local function define_globals()
  -- Define Pick function
  Pick = require('data.func').pick
end

-- Run Setup function
setup()

-- Define Global Functions
define_globals()
