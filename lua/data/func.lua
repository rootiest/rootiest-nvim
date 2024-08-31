--          ╭─────────────────────────────────────────────────────────╮
--          │                    Utility Functions                    │
--          ╰─────────────────────────────────────────────────────────╯

-- Define a namespace for utility functions
local M = {}

--- Check if the terminal is kitty
---@return boolean condition true if the terminal is kitty, false otherwise
function M.is_kitty()
  local term = os.getenv("TERM") or ""
  local kit = string.find(term, "kitty")
  return kit ~= nil
end

--- Check if using kitty-scrollback
---@return boolean condition true if using kitty-scrollback, false otherwise
function M.is_kitty_scrollback()
  if vim.env.KITTY_SCROLLBACK_NVIM == "true" then
    return true
  end
  return false
end

--- Check if the terminal is alacritty
---@return boolean condition true if the terminal is alacritty, false otherwise
function M.is_alacritty()
  local term = os.getenv("TERM") or ""
  local alc = string.find(term, "alacritty")
  return alc ~= nil
end

--- Check if the terminal is tmux
---@return boolean condition true if the terminal is tmux, false otherwise
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

--- Check if the terminal is wezterm
---@return boolean condition true if the terminal is wezterm, false otherwise
function M.is_wezterm()
  local wterm = os.getenv("TERM_PROGRAM")
  if wterm and string.find(wterm, "WezTerm") then
    return true
  end
  return false
end

--- Check if the terminal is neovide
---@return boolean condition true if the terminal is neovide, false otherwise
function M.is_neovide()
  local neovide = vim.g.neovide
  if neovide then
    return true
  end
  return false
end

--- Check if the terminal is ssh
---@return boolean condition true if the terminal is ssh, false otherwise
function M.is_ssh()
  local ssh = os.getenv("SSH_TTY") or false
  if ssh then
    return true
  end
  return false
end

--- Check if OS is Windows
---@return boolean condition true if the OS is Windows, false otherwise
function M.is_windows()
  local win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
  if win then
    return true
  end
  return false
end

--- Check if OS is macOS
---@return boolean condition true if the OS is macOS, false otherwise
function M.is_mac()
  local mac = vim.fn.has("macunix")
  if mac == 1 then
    return true
  end
  return false
end

--- Check if OS is Linux
---@return boolean condition true if the OS is Linux, false otherwise
function M.is_linux()
  local lin = vim.fn.has("unix")
  if lin == 1 then
    return true
  end
  return false
end

--- Get the name of the OS
---@return string os The name of the OS
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

--- Function to send a notification
---@param message string The message to send
---@param level string The level of the notification (default: "info")
---@return boolean condition true if the notification was sent successfully, false otherwise
function M.notify(message, level)
  level = level or "info"
  vim.notify(message, vim.log.levels[level:upper()])
  return true
end

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

--- Check if a plugin is installed.
---@param plugin string The name of the plugin module to check.
---@return boolean condition true if the plugin is installed, false otherwise.
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

--- Condition function to check filetype is not in list
---@param disabled_filetypes string[] The list of filetypes to check
---@return boolean|function true if filetype is not in list, false otherwise
function M.disable_on_filetypes(disabled_filetypes)
  return function()
    local filetype = vim.bo.filetype
    return not vim.tbl_contains(disabled_filetypes, filetype)
  end
end

--- Helper function to add keymaps with common properties
---@param lhs string|table The keybind (or list of keybinds)
---@param rhs string|function The function to execute when the key is pressed
---@param desc string|nil The description of the keybind (optional)
---@param mode string|table|nil The mode(s) in which the keybind should be added (optional)
---@param icon string|nil The icon to use for the keybind (optional)
---@param group string|nil The group to add the keybind to (optional)
---@return boolean condition true if the keybind was added, false otherwise
function M.add_keymap(lhs, rhs, desc, mode, icon, group)
  -- Check if which-key.nvim is installed
  if M.is_installed("which-key.nvim") then
    require("which-key").add({
      -- stylua: ignore start
      {
        lhs,                 -- The keybind
        rhs   = rhs,         -- Function to execute when the key is pressed
        desc  = desc,        -- Description of the keybind
        mode  = mode or "n", -- Default to "n" (normal mode) if mode is not provided
        icon  = icon,        -- Icon to use for the keybind
        group = group,       -- Default to nil (no group) if group is not provided
      },
      -- stylua: ignore end
    })
    return true
  else
    -- Handle the case where lhs is a table
    if type(lhs) == "table" then
      -- If lhs is a list of keymaps, iterate over each item
      for _, keymap in ipairs(lhs) do
        -- Set default values or use provided ones
        local keymap_rhs = keymap.rhs or rhs
        local keymap_desc = keymap.desc or desc
        local keymap_mode = keymap.mode or mode or "n"
        local keymap_icon = keymap.icon or icon
        local keymap_group = keymap.group or group
        local keymap_lhs = keymap.lhs

        if not keymap_group and not keymap_icon then
          -- Apply the keymap using vim.keymap.set
          vim.keymap.set(
            keymap_mode, -- Mode(s) in which the keybind should be added
            keymap_lhs, -- The keybind
            keymap_rhs, -- Function to execute when the key is pressed
            { desc = keymap_desc } -- Description of the keybind
          )
        else
          -- If which-key.nvim is not installed, use vim.notify with a detailed error message
          local msg = string.format(
            "Mapping requires which-key.nvim:\n%s%s",
            vim.inspect(keymap_lhs), -- Convert lhs to a readable format
            keymap_desc and ("\nDescription: " .. keymap_desc) or ""
          )
          M.notify(msg, "WARN")
          return false
        end
      end
      return true
    else
      -- If lhs is a single keymap (not a table)
      if not group and not icon then
        -- stylua: ignore start
        vim.keymap.set(
          mode or "n",    -- Default to "n" (normal mode) if mode is not provided
          lhs,            -- The keybind
          rhs,            -- Function to execute when the key is pressed
          { desc = desc } -- Description of the keybind
        )
        -- stylua: ignore end
        return true
      else
        -- If which-key.nvim is not installed, use vim.notify with a detailed error message
        local msg = string.format(
          "Mapping requires which-key.nvim:\n%s%s",
          vim.inspect(lhs), -- Convert lhs to a readable format
          desc and ("\nDescription: " .. desc) or ""
        )
        M.notify(msg, "WARN")
        return false
      end
    end
  end
end

--- Helper function to remove keymaps
---@param lhs string The keybind
---@param mode string|nil The mode in which the keybind should be removed
---@return boolean condition true if the keymap was removed, false otherwise
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

--- Helper function to add a mark
---@param mark string The mark to add
---@param line integer The line to add the mark to
---@param col integer The column to add the mark to
---@return boolean condition true if the mark was added, false otherwise
function M.add_mark(mark, line, col)
  -- Set the mark at the specified line and column
  vim.api.nvim_buf_set_mark(0, mark, line, col, {})
  return true -- Indicate that the mark was successfully added
end

--- Helper function to remove a mark
---@param mark string The mark to remove
---@return boolean condition true if the mark was removed, false otherwise
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

--- Function to check if buffer is modified
---@return boolean condition true if buffer is modified, false otherwise
function M.is_buffer_modified()
  return vim.bo.modified
end

--- Function to check if buffer is empty
---@return boolean condition true if buffer is empty, false otherwise
function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

--- Function to check if buffer is read-only
---@return boolean condition true if buffer is read-only, false otherwise
function M.is_buffer_readonly()
  return vim.bo.readonly
end

--- Function to check if file exists
---@param filepath string The path to the file
---@return boolean condition true if file exists, false otherwise
function M.file_exists(filepath)
  local f = io.open(filepath, "r")
  if f then
    f:close()
  end
  return f ~= nil
end

--- Function to get the current git branch
---@return string branch git branch name or "No branch"
function M.get_git_branch()
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
  if branch and branch ~= "" then
    return branch
  else
    return "No branch"
  end
end

--- Function to get the current git commit hash
---@return string The current git commit hash or "No commit hash"
function M.get_git_commit_hash()
  local commit_hash = vim.fn.systemlist("git rev-parse --short HEAD")[1]
  if commit_hash and commit_hash ~= "" then
    return commit_hash
  else
    return "No commit hash"
  end
end

--- Function to run a shell command
---@param cmd string The command to run
---@return string|nil result The output of the command
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

--- Function to get the dimensions of the current window
---@param format string The format of the dimensions
---@return string|table dimensions dimensions of the current window
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

--- Function to get the cursor position
---@return integer row The current line number
---@return integer col The current column number
function M.get_cursor_position()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return row, col
end

--- Function to split a string
---@param inputstr string The string to split
---@param sep string The separator
---@return table output The split string
function M.split_string(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local output = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(output, str)
  end
  return output
end

--- Function to convert RGB to hexadecimal
---@param rgb table The RGB color
---@return string hex The hexadecimal color
function M.rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

--- Function to get the foreground color of a highlight group
---@param hlgroup string The name of the highlight group
---@return string|nil hex The foreground color of the highlight group
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

--- Function to get the background color of a highlight group
---@param hlgroup string The name of the highlight group
---@return string|nil hex The background color of the highlight group
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

--- Function to check if the window is wide enough
---@param width_limit number The minimum width of the window
---@return boolean condition true if the window is wide enough, false otherwise
function M.is_window_wide_enough(width_limit)
  local width = vim.fn.winwidth(0)
  return width >= width_limit
end

--- Function to check if the window is tall enough
---@param height_limit number The minimum height of the window
---@return boolean condition true if the window is tall enough, false otherwise
function M.is_window_tall_enough(height_limit)
  local height = vim.fn.winheight(0)
  return height >= height_limit
end

--- Function to get the current date
---@return string|osdate date The current date
function M.get_date()
  return os.date("%Y-%m-%d")
end

--- Function to exit neovim
---@return nil
function M.exit()
  vim.api.nvim_command("wqall")
end

-- Export the module
return M
