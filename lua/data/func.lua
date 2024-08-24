--          ╭─────────────────────────────────────────────────────────╮
--          │                      FUNCTION DATA                      │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local bit = require("bit")

-- Check if the terminal is kitty
function M.is_kitty()
  local term = os.getenv("TERM") or ""
  local kit = string.find(term, "kitty")
  return kit ~= nil
end

-- Check if the terminal is tmux
function M.is_tmux()
  local tterm = os.getenv("TERM")
  if tterm and string.find(tterm, "screen") then
    if os.getenv("TMUX") then
      return true
    end
  else
    if tterm and string.find(tterm, "tmux") then
      return true
    end
  end
  return false
end

-- Check if the terminal is wezterm
function M.is_wezterm()
  local wterm = os.getenv("TERM_PROGRAM")
  if wterm and string.find(wterm, "WezTerm") then
    return true
  end
  return false
end

-- Check if the terminal is neovide
function M.is_neovide()
  local neovide = vim.g.neovide
  if neovide then
    return true
  end
  return false
end

-- Check if the terminal is ssh
function M.is_ssh()
  local ssh = os.getenv("SSH_TTY") or false
  return ssh
end

-- Check if OS is Windows
function M.is_windows()
  local win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
  if win then
    return true
  end
  return false
end

-- Check if OS is macOS
function M.is_mac()
  local mac = vim.fn.has("macunix")
  if mac == 1 then
    return true
  end
  return false
end

-- Check if OS is Linux
function M.is_linux()
  local lin = vim.fn.has("unix")
  if lin == 1 then
    return true
  end
  return false
end

-- Return the name of the OS
function M.get_os()
  --- @diagnostic disable-next-line: undefined-field
  local os_name = vim.loop.os_uname().sysname

  if os_name == "Windows_NT" then
    return "Windows"
  elseif os_name == "Darwin" then
    return "macOS"
  elseif os_name == "Linux" then
    -- Check if the system is running Android
    --- @diagnostic disable-next-line: undefined-field
    --- @diagnostic disable-next-line: missing-parameter
    if vim.env("ANDROID_ROOT") then
      return "Android"
    end

    -- Determine the Linux distribution
    local distro = "Linux"
    local release_file = "/etc/os-release"

    local fd = io.open(release_file, "r")
    if fd then
      for line in fd:lines() do
        if line:match("^ID=") then
          distro = line:gsub("ID=", ""):gsub('"', "")
          break
        end
      end
      fd:close()
    end
    return "Linux (" .. distro .. ")"
  else
    -- Falback tests
    if M.is_mac() then
      return "macOS"
    elseif M.is_linux() then
      return "Linux"
    elseif M.is_windows() then
      return "Windows"
    else
      -- Failed to determine OS
      return "Unknown OS"
    end
  end
end

-- Check if plugin is installed
function M.is_installed(plugin)
  -- Check for lazy.nvim
  local lazy_installed = pcall(require, "lazy")
  if lazy_installed then
    return require("lazy.core.config").plugins[plugin] ~= nil
  end
  -- Check for packer.nvim
  local packer_installed = pcall(require, "packer_plugins")
  if packer_installed then
    ---@diagnostic disable-next-line: undefined-field
    return _G.packer_plugins and _G.packer_plugins[plugin] ~= nil
  end
  -- Check for vim-plug
  if vim.fn.exists("g:plugs") == 1 then
    return vim.g.plugs[plugin] ~= nil
  end
  -- Plugin not found
  return false
end

-- Function to convert RGB to hexadecimal
function M.rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

-- Function to get the foreground color of a highlight group
function M.get_fg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local fg = hl.fg
  if fg then
    return M.rgb_to_hex({
      bit.rshift(bit.band(fg, 0xFF0000), 16),
      bit.rshift(bit.band(fg, 0x00FF00), 8),
      bit.band(fg, 0x0000FF),
    })
  end
  return nil
end

-- Function to get the background color of a highlight group
function M.get_bg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local bg = hl.bg
  if bg then
    return M.rgb_to_hex({
      bit.rshift(bit.band(bg, 0xFF0000), 16),
      bit.rshift(bit.band(bg, 0x00FF00), 8),
      bit.band(bg, 0x0000FF),
    })
  end
  return nil
end

-- Function to check the window width for lualine
function M.is_window_wide_enough(width_limit)
  local width = vim.fn.winwidth(0)
  return width >= width_limit
end

function M.get_date()
  return os.date("%Y-%m-%d")
end

return M
