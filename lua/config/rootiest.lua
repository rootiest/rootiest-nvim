local M = {}

local precog_first_time = true

-- Yank line without leading/trailing whitespace
function M.yank_line()
  vim.api.nvim_feedkeys("_v$hy$", "n", true)
end

-- Check if the terminal is Kitty
function M.using_kitty()
  local term = os.getenv("TERM") or ""
  return term:find("kitty") ~= nil
end

-- Toggle the precognition plugin
function M.toggle_precognition()
  if pcall(require, "precognition") then
    local precognition = require("precognition")
    if precog_first_time then
      precognition.toggle()
      precognition.toggle() -- Call toggle twice
      precog_first_time = false
    else
      precognition.toggle() -- Call toggle once
    end
  else
    vim.api.nvim_err_writeln("precognition plugin is not installed")
  end
end

-- Toggle Hardtime and Precognition
function M.toggle_hardmode()
  if pcall(require, "hardtime") then
    local hardtime = require("hardtime")
    hardtime.toggle()
    M.toggle_precognition()
  else
    vim.api.nvim_err_writeln("hardtime plugin is not installed")
  end
end

-- Toggle LazyGit terminal
function M.toggle_lazygit_term()
  if pcall(require, "toggleterm.terminal") then
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
    lazygit:toggle()
  else
    vim.api.nvim_err_writeln("toggleterm plugin is not installed")
  end
end

-- Load remote-nvim plugin
function M.load_remote()
  if pcall(require, "remote-nvim") then
    ---@diagnostic disable-next-line: missing-parameter
    require("remote-nvim").setup()
    vim.cmd("RemoteStart")
  else
    vim.api.nvim_err_writeln("remote-nvim plugin is not installed")
  end
end

-- Set cursor icons
function M.set_cursor_icons()
  local function rgb_to_hex(rgb)
    return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
  end

  local function get_bg_color(hlgroup)
    local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
    local bg = hl.bg
    if bg then
      return rgb_to_hex({
        bit.rshift(bit.band(bg, 0xFF0000), 16),
        bit.rshift(bit.band(bg, 0x00FF00), 8),
        bit.band(bg, 0x0000FF),
      })
    end
    return nil
  end
  local current_mode = vim.fn.mode()
  local bg_color

  if current_mode == "n" then
    bg_color = get_bg_color("MiniStatuslineModeNormal")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "v" then
    bg_color = get_bg_color("MiniStatuslineModeVisual")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "V" then
    bg_color = get_bg_color("MiniStatuslineModeVisual")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "R" or current_mode == "r" then
    bg_color = get_bg_color("MiniStatuslineModeReplace")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  elseif current_mode == "i" then
    bg_color = get_bg_color("MiniStatuslineModeInsert")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  else
    bg_color = get_bg_color("MiniStatuslineModeNormal")
    vim.api.nvim_set_hl(0, "SmoothCursor", { fg = bg_color })
    vim.fn.sign_define("smoothcursor", { text = "" })
  end
end

-- Evaluate dependencies and print warnings if needed
function M.eval_dependencies()
  local function should_suppress_warnings()
    return false
  end

  local function check_executable(executable)
    if vim.fn.executable(executable) ~= 1 then
      vim.api.nvim_notify(
        executable .. " is not installed!",
        vim.log.levels.WARN,
        {}
      )
    end
  end

  if not should_suppress_warnings() then
    local executables =
      { "lazygit", "gh", "rg", "fzf", "fd", "git", "luarocks" }
    for _, executable in ipairs(executables) do
      check_executable(executable)
    end
  end
end

-- Evaluate Neovide settings
function M.eval_neovide()
  if vim.g.neovide then
    require("config.neovide")
  end
end

-- Define autocorrections
function M.define_autocorrections()
  require("config.autospell")
end

-- Define user commands
function M.define_commands()
  vim.api.nvim_create_user_command("Q", function()
    vim.cmd.qall()
  end, { force = true, desc = "Close all buffers" })

  vim.api.nvim_create_user_command("YankLine", function()
    M.yank_line()
  end, { force = true, desc = "Yank line without leading whitespace" })
end

function M.setup()
  M.eval_dependencies()
  M.eval_neovide()
  M.define_autocorrections()
  M.define_commands()
end

return M
