--          ╭─────────────────────────────────────────────────────────╮
--          │                    Utility Functions                    │
--          ╰─────────────────────────────────────────────────────────╯

-- Define a namespace for utility functions
local M = {}

-- Load data module
local data = require("data")

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

--- Get the name of the OS.
--- @param format string The format of the OS name.
---                    Possible values:
---                    - "verbose": Returns the full name of the OS.
---                    - "short": Returns a short name or abbreviation.
---                    - "code": Returns a code or identifier.
---                    - "platform": Returns either "windows", "osx", or "linux".
--- @return string os The name of the OS.
function M.get_os(format)
  ---@diagnostic disable-next-line: undefined-field
  local uname = vim.loop and vim.loop.os_uname and vim.loop.os_uname() or {}
  local os_name = uname.sysname or "unknown"

  if os_name == "Windows_NT" then
    if format == "platform" then
      return "windows"
    elseif format == "short" then
      return "Win"
    elseif format == "code" then
      return "win"
    else
      return "Windows"
    end
  elseif os_name == "Darwin" then
    if format == "platform" then
      return "osx"
    elseif format == "short" then
      return "macOS"
    elseif format == "code" then
      return "osx"
    else
      return "macOS"
    end
  elseif os_name == "Linux" then
    -- Check if the system is running Android
    if vim.env.ANDROID_ROOT then
      if format == "platform" then
        return "linux"
      elseif format == "short" then
        return "Android"
      elseif format == "code" then
        return "android"
      else
        return "Android"
      end
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

    if format == "platform" then
      return "linux"
    elseif format == "short" then
      return "Linux"
    elseif format == "code" then
      return distro
    else
      return "Linux (" .. distro .. ")"
    end
  else
    -- Falback tests
    if M.is_mac() then
      if format == "platform" then
        return "osx"
      elseif format == "short" then
        return "macOS"
      elseif format == "code" then
        return "osx"
      else
        return "macOS"
      end
    elseif M.is_linux() then
      if format == "platform" then
        return "linux"
      elseif format == "short" then
        return "Linux"
      elseif format == "code" then
        return "linux"
      else
        return "Linux"
      end
    elseif M.is_windows() then
      if format == "platform" then
        return "windows"
      elseif format == "short" then
        return "Win"
      elseif format == "code" then
        return "win"
      else
        return "Windows"
      end
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
--- This is a messy operation. It's not recommended to use it.
--- If you do, please define the exclusion list in your config.lua file.
--- @see data.types.plugin_reloader.exclusion_list
--- @return nil
function M.reload_all_plugins()
  -- Define the exclusion list
  local exclude = data.types.plugin_reloader.exclusion_list

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
--- This field can be the following:
--- - A string representing the keybind
--- - A list of strings representing a set of keybinds
--- - A table of multiple keybind specifications
---@param rhs string|function The function to execute when the key is pressed
--- This field can be the following:
--- - A string representing the vimscript command
--- - A lua function (only when using which-key.nvim or global keymaps)
---@param desc string|nil The description of the keybind (optional)
--- This field can be the following:
--- - A string representing the description
---   The description will be displayed in the which-key menu
---@param mode string|table|nil The mode(s) in which the keybind should be added (optional)
--- This field can be the following:
--- - A string representing the mode
--- - A table of multiple modes (only when using which-key.nvim or global keymaps)
---@param icon string|nil The icon to use for the keybind (optional)
--- This field can be the following:
--- - A string representing the icon (only when defining a menu)
---@param group string|nil The group to add the keybind to (optional)
--- This field can be the following:
--- - A string representing the group (only when defining a menu)
---@param bufnr number|nil The buffer number to add the keymap to (optional)
--- This field can be the following:
--- - A number representing the buffer
---   This option is incompatible with some extended keymap options
---@return boolean condition true if the keybind was added, false otherwise
--- There are three main types of keymaps:
--- - Global keymaps
---   This is the most common type of keymap.
---   Ex:
---     add_keymap("<leader>ff", "lua require('telescope.builtin').find_files()")
--- - Buffer keymaps
---   This is used to add keymaps to specific buffers.
---   Ex:
---     add_keymap("<leader>ff", "lua require('telescope.builtin').find_files()", nil, nil, nil, 0)
--- - Which-key menus
---   This is used to add which-key menus.
---   Ex:
---     add_keymap("<leader>l", nil, nil, nil, "󰒲", "Lazy")
---@see which-key.nvim-which-key-mappings
---@see vim.api.nvim_buf_set_keymap
---@see vim.keymap.set
function M.add_keymap(
  lhs, -- The keybind
  rhs, -- Function to execute when the key is pressed
  desc, -- Description of the keybind
  mode, -- Mode(s) in which the keybind should be added
  icon, -- Icon to use for the keybind menu
  group, -- Group to use for the keybind menu
  bufnr -- Buffer number to add the keymap to
)
  -- Check if which-key.nvim is installed
  if M.is_installed("which-key.nvim") and not bufnr then
    require("which-key").add({
      -- stylua: ignore start
      {
        lhs,                 -- The keybind
        rhs   = rhs,         -- Function to execute when the key is pressed
        desc  = desc,        -- Description of the keybind
        mode  = mode or "n", -- Default to "n" (normal mode) if mode is not provided
        icon  = icon,        -- Icon to use for the keybind
        group = group,       -- Group to add the keybind to
      },
      -- stylua: ignore end
    })
    return true
  else
    -- Handle the case where lhs is a table
    if type(lhs) == "table" then
      for _, keymap in ipairs(lhs) do
        -- Set default values or use provided ones
        local keymap_rhs = keymap.rhs or rhs
        local keymap_desc = keymap.desc or desc
        local keymap_mode = keymap.mode or mode or "n"
        local keymap_icon = keymap.icon or icon
        local keymap_group = keymap.group or group
        local keymap_lhs = keymap.lhs

        if not keymap_group and not keymap_icon then
          if not bufnr then
            -- Apply the keymap using vim.keymap.set
            vim.keymap.set(
              keymap_mode, -- Mode(s) in which the keybind should be added
              keymap_lhs, -- The keybind
              keymap_rhs, -- Function to execute when the key is pressed
              { desc = keymap_desc } -- Description of the keybind
            )
          else
            if -- Check if the keymap is compatible with buffer-based keymaps
              type(keymap_mode) == "table" or type(keymap_rhs) == "function"
            then
              -- The keymap is incompatible with buffer-based keymaps
              local msg = string.format(
                "Mapping incompatible with buffer-based keymaps:\n%s%s",
                vim.inspect(keymap_lhs), -- Convert lhs to a readable format
                keymap_desc and ("\nDescription: " .. keymap_desc) or ""
              )
              M.notify(msg, "WARN")
              return false
            end
            -- Apply the keymap using vim.api.nvim_buf_set_keymap
            vim.api.nvim_buf_set_keymap(
              bufnr,
              keymap_mode,
              keymap_lhs,
              keymap_rhs,
              { desc = keymap_desc }
            )
          end
        else
          -- The keymap requires which-key.nvim
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
    else -- Handle the case where lhs is not a table
      if not group and not icon then
        if not bufnr then
          vim.keymap.set(
            mode or "n", -- Default to "n" (normal mode) if mode is not provided
            lhs, -- The keybind
            rhs, -- Function to execute when the key is pressed
            { desc = desc } -- Description of the keybind and optional buffer number
          )
        else
          if -- Check if the keymap is compatible with buffer-based keymaps
            type(mode) == "table" or type(rhs) == "function"
          then
            -- The keymap is incompatible with buffer-based keymaps
            local msg = string.format(
              "Mapping incompatible with buffer-based keymaps:\n%s%s",
              vim.inspect(lhs), -- Convert lhs to a readable format
              desc and ("\nDescription: " .. desc) or ""
            )
            M.notify(msg, "WARN")
            return false
          end
          -- Apply the keymap using vim.api.nvim_buf_set_keymap
          vim.api.nvim_buf_set_keymap(
            bufnr,
            mode or "n",
            lhs,
            rhs,
            { desc = desc }
          )
        end
        return true
      else
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
---@param mode string|nil The mode in which the keybind should be removed (optional)
---@param bufnr number|nil The buffer number to remove the keymap from (optional)
---@return boolean condition true if the keymap was removed, false otherwise
---@see vim.api.nvim_del_keymap
---@see vim.api.nvim_buf_del_keymap
function M.rm_keymap(
  lhs, -- The keybind
  mode, -- Mode(s) in which the keybind should be removed
  bufnr -- Buffer number to remove the keymap from
)
  mode = mode or "n" -- Default to "n" (normal mode) if mode is not provided

  --- @class Keymap
  --- @field lhs string The keybind
  --- @field rhs string|function The function or command associated with the keybind

  if bufnr then
    -- If a buffer number is provided, remove the keymap from the specified buffer
    --- @type Keymap[]
    local keymaps = vim.api.nvim_buf_get_keymap(bufnr, mode)
    for _, keymap in pairs(keymaps) do
      if keymap.lhs and keymap.lhs == lhs then
        vim.api.nvim_buf_del_keymap(bufnr, mode, lhs)
        return true -- Indicate that the keymap was removed
      end
    end
  else
    -- If no buffer number is provided, remove the global keymap
    --- @type Keymap[]
    local keymaps = vim.api.nvim_get_keymap(mode)
    for _, keymap in pairs(keymaps) do
      if keymap.lhs and keymap.lhs == lhs then
        vim.api.nvim_del_keymap(mode, lhs)
        return true -- Indicate that the keymap was removed
      end
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
