--          ╭─────────────────────────────────────────────────────────╮
--          │                    Utility Functions                    │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local bit = require("bit")

-- Check if the terminal is kitty
function M.is_kitty()
  local term = os.getenv("TERM") or ""
  local kit = string.find(term, "kitty")
  return kit ~= nil
end

-- Check if using kitty-scrollback
function M.is_kitty_scrollback()
  if vim.env.KITTY_SCROLLBACK_NVIM == "true" then
    return true
  end
  return false
end

-- Check if the terminal is alacritty
function M.is_alacritty()
  local term = os.getenv("TERM") or ""
  local alc = string.find(term, "alacritty")
  return alc ~= nil
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

-- Function to send a notification
function M.notify(message, level)
  level = level or "info"
  vim.notify(message, vim.log.levels[level:upper()])
--- Function to reload all plugins.
--- @return nil
function M.reload_all_plugins()
  -- Define the exclusion list
  local exclude = require("data").types.plugin_reloader.exclusion_list

  -- Get the list of currently loaded plugins
  local plugins = require("lazy.core.config").plugins

  -- Iterate over each plugin and reload it if it's not in the exclusion list
  for plugin_name, _ in pairs(plugins) do
    if not exclude[plugin_name] then
      vim.cmd("Lazy reload " .. plugin_name)
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

-- Helper function to add keymaps with common properties
function M.add_keymap(lhs, rhs, desc, mode, icon, group)
  -- Check if which-key.nvim is installed
  if M.is_installed("which-key.nvim") then
    require("which-key").add({
      -- stylua: ignore start
      {
        lhs,                -- The keybind
        rhs = rhs,          -- Function to execute when the key is pressed
        desc = desc,        -- Description of the keybind
        mode = mode or "n", -- Default to "n" (normal mode) if mode is not provided
        icon = icon,        -- Icon to use for the keybind
        group = group,      -- Default to nil (no group) if group is not provided
      },
      -- stylua: ignore end
    })
  else
    -- Handle the case where lhs is a table
    if type(lhs) == "table" then
      rhs = lhs.rhs or rhs
      desc = lhs.desc or desc
      mode = lhs.mode or mode
      icon = lhs.icon or icon
      group = lhs.group or group
      lhs = lhs.lhs or lhs
    end
    -- If which-key.nvim is not installed, use vim.keymap.set
    if not group and not icon then
      -- stylua: ignore start
      vim.keymap.set(
        mode or "n",    -- Default to "n" (normal mode) if mode is not provided
        lhs,            -- The keybind
        rhs,            -- Function to execute when the key is pressed
        { desc = desc } -- Description of the keybind
      )
      -- stylua: ignore end
    else
      -- If which-key.nvim is not installed, use vim.notify with detailed error message
      local msg = string.format(
        "Mapping requires which-key.nvim:\n%s%s",
        vim.inspect(lhs), -- Convert lhs to a readable format
        desc and ("\nDescription: " .. desc) or ""
      )
      M.notify(msg, "WARN")
    end
  end
end

-- Helper function to remove keymaps
function M.rm_keymap(lhs, mode)
  mode = mode or "n" -- Default to "n" (normal mode) if mode is not provided
  -- Get all keymaps for the specified mode
  local keymaps = vim.api.nvim_get_keymap(mode)
  -- Check if the keymap exists
  for _, keymap in pairs(keymaps) do
    ---@diagnostic disable-next-line: undefined-field
    if keymap.lhs and keymap.lhs == lhs then
      -- Keymap exists, remove it
      vim.api.nvim_del_keymap(mode, lhs)
      return true -- Indicate that the keymap was removed
    end
  end
  return false -- Indicate that the keymap did not exist
end

-- Helper function to add a mark
function M.add_mark(mark, line, col)
  -- Set the mark at the specified line and column
  vim.api.nvim_buf_set_mark(0, mark, line, col, {})
  return true -- Indicate that the mark was successfully added
end

-- Helper function to remove a mark if it exists
function M.rm_mark(mark)
  -- Get a list of marks in the current buffer
  local marks = vim.fn.getmarklist(vim.fn.bufnr("%"))
  -- Check if the mark exists
  for _, m in ipairs(marks) do
    if m.mark == mark then
      -- Mark exists, remove it
      vim.cmd("delmarks " .. mark)
      return true -- Indicate that the mark was removed
    end
  end
  return false -- Indicate that the mark did not exist
end

-- Function to check if buffer is modified
function M.is_buffer_modified()
  return vim.bo.modified
end

-- Function to check if buffer is empty
function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

-- Function to check if buffer is read-only
function M.is_buffer_readonly()
  return vim.bo.readonly
end

-- Function to check if file exists
function M.file_exists(filepath)
  local f = io.open(filepath, "r")
  if f then
    f:close()
  end
  return f ~= nil
end

-- Function to get the current git branch
function M.get_git_branch()
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
  if branch and branch ~= "" then
    return branch
  else
    return "No branch"
  end
end

-- Function to get the current git commit hash
function M.get_git_commit_hash()
  local commit_hash = vim.fn.systemlist("git rev-parse --short HEAD")[1]
  if commit_hash and commit_hash ~= "" then
    return commit_hash
  else
    return "No commit hash"
  end
end

-- Function to execute a shell command
function M.run_shell_command(cmd)
  local handle = io.popen(cmd)
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result
  else
    -- Handle the error case where `handle` is nil
    vim.notify("Failed to run the command: " .. cmd, vim.log.levels.ERROR)
    return nil
  end
end

-- Get Workspace dimensions with optional output format
function M.get_ws_dimensions(format)
  format = format or "verbose"
  local dimensions = {
    width = tonumber(vim.opt.columns:get()) or 0,
    height = tonumber(vim.opt.lines:get()) or 0,
  }
  if format == "verbose" then
    return string.format(
      "Width: %d cells\nHeight: %d cells",
      dimensions.width,
      dimensions.height
    )
  elseif format == "basic" then
    return string.format("%dx%d", dimensions.width, dimensions.height)
  elseif format == "raw" then
    return dimensions
  else
    -- Trigger an error if the format is not valid
    error("Invalid format: " .. format)
  end
end

-- Function to get the current cursor position
function M.get_cursor_position()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return row, col
end

-- Function to split strings
function M.split_string(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
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

function M.exit()
  vim.api.nvim_command("wqall")
end

return M
