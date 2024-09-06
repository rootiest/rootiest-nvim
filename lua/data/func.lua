---@module "data.func"
--- This module contains utility functions used throughout the configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                    Utility Functions                    │
--          ╰─────────────────────────────────────────────────────────╯

-- Define a namespace for utility functions
local M = {}

---@function Check if the terminal is kitty
---@return boolean condition true if the terminal is kitty, false otherwise
function M.is_kitty()
  local term = os.getenv("TERM") or ""
  local kit = string.find(term, "kitty")
  return kit ~= nil
end

---@function Check if using kitty-scrollback
---@return boolean condition true if using kitty-scrollback, false otherwise
function M.is_kitty_scrollback()
  if vim.env.KITTY_SCROLLBACK_NVIM == "true" then
    return true
  end
  return false
end

---@function Check if the terminal is alacritty
---@return boolean condition true if the terminal is alacritty, false otherwise
function M.is_alacritty()
  local term = os.getenv("TERM") or ""
  local alc = string.find(term, "alacritty")
  return alc ~= nil
end

---@function Check if the terminal is tmux
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

---@function Check if the terminal is wezterm
---@return boolean condition true if the terminal is wezterm, false otherwise
function M.is_wezterm()
  local wterm = os.getenv("TERM_PROGRAM")
  if wterm and string.find(wterm, "WezTerm") then
    return true
  end
  return false
end

---@function Check if the terminal is neovide
---@return boolean condition true if the terminal is neovide, false otherwise
function M.is_neovide()
  local neovide = vim.g.neovide
  if neovide then
    return true
  end
  return false
end

---@function Check if the terminal is ssh
---@return boolean condition true if the terminal is ssh, false otherwise
function M.is_ssh()
  local ssh = os.getenv("SSH_TTY") or false
  if ssh then
    return true
  end
  return false
end

---@function Check if OS is Windows
---@return boolean condition true if the OS is Windows, false otherwise
function M.is_windows()
  local win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
  if win then
    return true
  end
  return false
end

---@function Check if OS is macOS
---@return boolean condition true if the OS is macOS, false otherwise
function M.is_mac()
  local mac = vim.fn.has("macunix")
  if mac == 1 then
    return true
  end
  return false
end

---@function Check if OS is Linux
---@return boolean condition true if the OS is Linux, false otherwise
function M.is_linux()
  local lin = vim.fn.has("unix")
  if lin == 1 then
    return true
  end
  return false
end

---@function Get the name of the OS.
---@param format string The format of the OS name.
---                    Possible values:
---                    - "verbose": Returns the full name of the OS.
---                    - "short": Returns a short name or abbreviation.
---                    - "code": Returns a code or identifier.
---                    - "platform": Returns either "windows", "osx", or "linux".
---@return string os The name of the OS.
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

---@function Function to send a notification
---@param message string The message to send
---@param level string|nil The level of the notification (default: "info")
---@param title string|nil The title of the notification
---@return boolean condition true if the notification was sent successfully, false otherwise
function M.notify(message, level, title)
  level = level or "info"
  if title then
    vim.notify(message, vim.log.levels[level:upper()], { title = title })
  else
    vim.notify(message, vim.log.levels[level:upper()])
  end
  return true
end

---@function Function to generate a y/n confirmation prompt
---@param prompt string The prompt text to display
---@param action function|string The action to execute if the user confirms the prompt, or a Vim command as a string
---@return boolean condition true if the user confirms the prompt, false otherwise
function M.ConfirmPrompt(prompt, action)
  -- Validate the action parameter
  local function perform_action()
    if type(action) == "function" then
      action() -- Call the function
    elseif type(action) == "string" then
      vim.cmd(action) -- Run the Vim command
    else
      M.notify(
        "Action must be a function or a string",
        "ERROR",
        "Configuration Error"
      )
    end
  end
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new empty buffer
  -- Set the prompt text in the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { prompt, "y/n: " })
  -- Create a floating window to display the buffer
  local win_height = 2 -- Height of floating window
  local win_width = math.floor(vim.o.columns * 0.25) -- Width of floating window
  local row = math.floor((vim.o.lines - win_height) / 2) -- Position row
  local col = math.floor((vim.o.columns - win_width) / 2) -- Position column
  local win_border = "rounded"
  local style = "minimal"
  -- Create a floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = col,
    row = row,
    style = style,
    border = win_border,
  })
  -- Move the cursor to the end of the buffer
  vim.api.nvim_win_set_cursor(win, { 2, 5 })
  -- Define the yes function
  local yes = function()
    vim.api.nvim_win_close(win, true)
    perform_action() -- Perform the action
    return true
  end
  -- Define the no function
  local no = function()
    vim.api.nvim_win_close(win, true)
    M.notify("Action Canceled", "INFO", "Info")
  end
  -- Define buffer-specific key mappings
  local keymaps = {
    y = function()
      yes()
    end,
    n = function()
      no()
    end,
    q = function()
      no()
    end,
    ["<Esc>"] = function()
      no()
    end,
  }
  -- Set the key mappings
  for key, callback in pairs(keymaps) do
    vim.api.nvim_buf_set_keymap(buf, "n", key, "", {
      noremap = true,
      nowait = true,
      callback = callback,
    })
  end

  return false
end

---@function Function to generate an input prompt
---@param prompt string The prompt text to display
---@param callback function The function to call with the user input
function M.InputPrompt(prompt, callback)
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new empty buffer

  -- Set the buffer name
  vim.api.nvim_buf_set_name(buf, "Input")
  -- Set the buffer filetype (e.g., for custom behavior or syntax highlighting)
  vim.bo[buf].filetype = "input"
  -- Set the buffer type to "nofile" to avoid editing or saving the buffer
  vim.bo[buf].buftype = "nofile"
  -- Set the prompt text in the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { prompt, "Input: " })

  -- Create a floating window to display the buffer
  local win_height = 2 -- Height of floating window
  local win_width = math.floor(vim.o.columns * 0.25) -- Width of floating window
  local row = math.floor((vim.o.lines - win_height) / 2) -- Position row
  local col = math.floor((vim.o.columns - win_width) / 2) -- Position column
  local win_border = "rounded"
  local style = "minimal"

  -- Create a floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = col,
    row = row,
    style = style,
    border = win_border,
  })

  -- Move the cursor to the end of the buffer
  vim.api.nvim_win_set_cursor(win, { 2, 8 })
  -- Set input mode
  vim.api.nvim_command("startinsert")

  -- Function to close the window
  local function exit_win()
    vim.api.nvim_command("stopinsert")
    vim.api.nvim_win_close(win, true)
  end

  -- Function to handle input and close the window
  local function handle_input()
    -- Get the text after the "Input: " string
    local input = vim.api.nvim_buf_get_lines(buf, 1, 2, false)[1]:sub(7) -- Adjust to trim "Input: "
    return input
  end

  ---@function Function to return user input
  local function yes()
    local user_input = handle_input() -- Get the input from the buffer
    exit_win()
    if callback then
      callback(user_input) -- Call the callback with the user input
    end
  end

  ---@function Function to cancel user input
  local function no()
    exit_win()
    if callback then
      callback(nil) -- Call the callback with nil to indicate cancellation
    end
  end

  -- Define buffer-specific key mappings
  local keymaps = {
    ["<CR>"] = yes,
    ["<Esc>"] = no,
  }

  -- Set the key mappings
  for key, keyback in pairs(keymaps) do
    vim.api.nvim_buf_set_keymap(buf, "n", key, "", {
      noremap = true,
      nowait = true,
      callback = keyback,
    })
    vim.api.nvim_buf_set_keymap(buf, "i", key, "", {
      noremap = true,
      nowait = true,
      callback = keyback,
    })
  end
end

---@function Function to reload the user's Neovim configuration
---@return nil
function M.reload_config()
  -- Notify the user about the reload process
  M.notify("Reloading configuration...", "WARN", "Reloading Config")
  -- 1. Save all buffers
  vim.cmd("silent! wa")
  -- 2. Record the list of open buffers to reopen later
  local buffer_list = vim.api.nvim_list_bufs()
  local buffers_to_reopen = {}
  for _, buf in ipairs(buffer_list) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.fn.bufname(buf) ~= "" then
      table.insert(
        buffers_to_reopen,
        { buf = buf, file = vim.api.nvim_buf_get_name(buf) }
      )
    end
  end
  -- 3. Close all buffers
  vim.cmd("silent! bufdo! bwipeout")
  -- 4. Clear loaded lua modules related to your custom configuration
  for name, _ in pairs(package.loaded) do
    -- Replace 'userconfig' and 'plugin' with your actual config module names
    if name:match("^userconfig") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  -- 5. Reload the vim script (init.lua)
  vim.cmd("source $MYVIMRC")
  -- 6. Reopen the buffers
  for _, bufinfo in ipairs(buffers_to_reopen) do
    local buf = vim.fn.bufadd(bufinfo.file)
    vim.cmd("buffer " .. buf)
    vim.api.nvim_buf_call(buf, function()
      -- You could also restore the exact cursor position if desired
      vim.cmd('silent! normal! g`"')
    end)
  end -- Notify the user that the config has been reloaded
  M.notify("Configuration reloaded successfully!", "INFO", "Reloaded Config")
end

---@function Function to reload all plugins.
--- This is a messy operation. It's not recommended to use it.
--- If you do, please define the exclusion list in your config.lua file.
--- Suggested defaults:
---   vim.g.plugin_reloader_exclusion_list = {
---         ["lazy.nvim"]      = true,
---         ["noice.nvim"]     = true,
---         ["unception.nvim"] = true,
---         ["nvim-unception"] = true,
---         ["nui.nvim"]       = true,
---         ["packer.nvim"]    = true,
---         ["trouble.nvim"]   = true,
---         ["which-key.nvim"] = true,
---   },
---
--- You should add any other plugins that won't handle a live reload
--- well to this exclusion list and define it in your configuration.
--- The exclusion list can be defined with:
---   'vim.g.plugin_reloader_exclusion_list'
---@see data.types.plugin_reloader.exclusion_list
---@return nil
function M.reload_all_plugins()
  -- Define the exclusion list
  local exclude = {}
  if vim.g.plugin_reloader.exclusion_list then
    -- Use global variable if provided
    exclude = vim.g.plugin_reloader.exclusion_list
  elseif pcall(require, "data.types") then
    -- Use data.types if available
    exclude = require("data.types").plugin_reloader.exclusion_list
  else
    -- Fallback to default
    exclude = {
      ["lazy.nvim"] = true,
      ["noice.nvim"] = true,
      ["unception.nvim"] = true,
      ["nvim-unception"] = true,
      ["nui.nvim"] = true,
      ["packer.nvim"] = true,
      ["trouble.nvim"] = true,
      ["which-key.nvim"] = true,
    }
  end

  -- Get the list of currently loaded plugins
  local plugins = require("lazy.core.config").plugins

  -- Iterate over each plugin and reload it if it's not in the exclusion list
  for plugin_name, _ in pairs(plugins) do
    if not exclude[plugin_name] then
      vim.cmd("Lazy reload " .. plugin_name)
    end
  end
end

---@function Check if a plugin is installed.
---@param plugins string|table The name of the plugin module(s) to check.
---  Options:
---   - string: The name of the plugin module to check.
---   - table: A list of plugin modules to check.
---@return boolean|table condition The installed state of the plugin(s).
---   - boolean: The installed state of the plugin.
---   - table: A list of installed states of the plugins.
---     - boolean: The installed state of the plugin.
---  The return type is determined based on the input type.
---  If the input is a table of plugin modules, the return type is a table.
function M.is_installed(plugins)
  local is_single = type(plugins) == "string"
  if type(plugins) == "string" then
    plugins = { plugins }
  end

  local installed_plugins = {}
  for _, plugin in ipairs(plugins) do
    local installed = false
    local lazy_installed = pcall(require, "lazy")
    if lazy_installed then
      installed = require("lazy.core.config").plugins[plugin] ~= nil
    end
    local packer_installed = pcall(require, "packer_plugins")
    if packer_installed then
      ---@diagnostic disable-next-line: undefined-field
      installed = _G.packer_plugins and _G.packer_plugins[plugin] ~= nil
    end
    if vim.fn.exists("g:plugs") == 1 then
      installed = vim.g.plugs[plugin] ~= nil
    end
    if not installed then
      local has_plug = pcall(require, plugin)
      if has_plug then
        installed = true
      end
    end
    installed_plugins[plugin] = installed
  end

  if is_single then
    return installed_plugins[plugins[1]]
  else
    return installed_plugins
  end
end

---@function Condition function to check filetype is not in list
---@param disabled_filetypes string[] The list of filetypes to check
---@return boolean|function true if filetype is not in list, false otherwise
function M.disable_on_filetypes(disabled_filetypes)
  return function()
    local filetype = vim.bo.filetype
    return not vim.tbl_contains(disabled_filetypes, filetype)
  end
end

---@function Helper function to add keymaps with common properties
---@param lhs string|table The keybind (or list of keybinds)
--- This field can be the following:
--- - A string representing the keybind
--- - A list of strings representing a set of keybinds
--- - A table of multiple keybind specifications
--- This field is required.
---@param rhs string|function|nil The function to execute when the key is pressed
--- This field can be the following:
--- - A string representing the vimscript command
--- - A lua function (only when using which-key.nvim or global keymaps)
--- This field is required.
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
---@param hidden boolean|nil Whether the keybind should be hidden (optional)
--- This field can be the following:
--- - A boolean representing whether to hide the keymap in which-key menus
---   This option is only compatible with which-key configurations
---   It will be ignored if which-key is not installed
---   The default value is false
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
  bufnr, -- Buffer number to add the keymap to
  hidden
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
        hidden = hidden,     -- Hide the keybind in which-key menus
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
              ---@diagnostic disable-next-line: param-type-mismatch
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
              ---@diagnostic disable-next-line: param-type-mismatch
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
            ---@diagnostic disable-next-line: param-type-mismatch
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
            ---@diagnostic disable-next-line: param-type-mismatch
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

---@function Add a new keymap with optional which-key integration
---@param lhs string|table The keybind or a table containing multiple keymaps
---@param rhs string|function|nil The function to execute when the keybind is pressed
---@param desc string|nil The description of the keybind
---@param mode string|table|nil The mode(s) in which the keybind should be added
---@param icon string|nil The icon to associate with the which-key entry (optional)
---@param group string|nil The which-key group to add the keybind to (optional)
---@param bufnr number|nil The buffer number to add the keymap to (optional, for buffer-specific mappings)
---@return boolean success True if all keymaps were successfully added, false otherwise
function M.add_km(lhs, rhs, desc, mode, icon, group, bufnr)
  local function is_mode(value)
    -- Identify common vim modes; this can be expanded based on requirements
    local common_modes =
      { n = true, i = true, v = true, x = true, s = true, o = true, c = true }
    if type(value) == "string" and #value == 1 then
      return common_modes[value] ~= nil
    elseif type(value) == "table" then
      for _, v in ipairs(value) do
        if not common_modes[v] then
          return false
        end
      end
      return true
    end
    return false
  end

  local function correct_swapped_params()
    -- Try to correct common mistakes where rhs and mode might be swapped

    if type(rhs) == "string" and is_mode(rhs) then
      if type(mode) == "string" or type(mode) == "function" then
        -- Swap them if it looks like rhs is mode and mode is rhs
        ---@diagnostic disable-next-line: cast-local-type
        rhs, mode = mode, rhs
      elseif type(mode) == "table" and is_mode(mode) then
        -- Swap if rhs is mode and mode is list of modes
        ---@diagnostic disable-next-line: cast-local-type
        rhs, mode = mode, rhs
      end
    elseif
      type(rhs) == "function"
      and type(mode) == "string"
      and not is_mode(mode)
    then
      -- This checks if mode is actually an rhs-like string or command
      rhs, mode = mode, rhs
    end
  end

  -- Attempt to correct any common parameter swapping issues
  correct_swapped_params()

  -- Helper function to set keymaps using native functions
  local function set_keymap(
    keymap_lhs,
    keymap_rhs,
    keymap_desc,
    keymap_mode,
    keymap_bufnr
  )
    if keymap_bufnr then
      vim.api.nvim_buf_set_keymap(
        keymap_bufnr,
        keymap_mode,
        keymap_lhs,
        keymap_rhs,
        { desc = keymap_desc }
      )
    else
      vim.keymap.set(
        keymap_mode,
        keymap_lhs,
        keymap_rhs,
        { desc = keymap_desc }
      )
    end
  end

  -- Determine if which-key is available and should be used
  local use_which_key = M.is_installed
    and M.is_installed("which-key.nvim")
    and not bufnr

  -- Process a single keymap entry
  ---@function Helper function to process a single keymap
  ---@param keymap table The table containing a keymap
  ---@return boolean success True if the keymap was processed successfully, false otherwise
  local function process_keymap(keymap)
    local keymap_lhs = type(keymap) == "table" and keymap.lhs or lhs
    local keymap_rhs = type(keymap) == "table" and (keymap.rhs or rhs) or rhs
    local keymap_desc = type(keymap) == "table" and (keymap.desc or desc)
      or desc
    local keymap_mode = type(keymap) == "table" and (keymap.mode or mode)
      or mode
      or "n"
    local keymap_icon = type(keymap) == "table" and (keymap.icon or icon)
      or icon
    local keymap_group = type(keymap) == "table" and (keymap.group or group)
      or group

    -- Use which-key if possible; fallback to native keymap functions if not
    if use_which_key then
      require("which-key").add({
        [keymap_lhs] = {
          keymap_rhs,
          keymap_desc,
          mode = keymap_mode,
          icon = keymap_icon,
          group = keymap_group,
        },
      })
    else
      -- Attempt to fall back to the native keymap functions
      local success, err_msg = pcall(
        set_keymap,
        keymap_lhs,
        keymap_rhs,
        keymap_desc,
        keymap_mode,
        bufnr
      )
      if not success then
        -- Notify the user about the failed mapping
        M.notify(("Failed to map %s: %s"):format(keymap_lhs, err_msg), "WARN")
        return false
      end
    end
    return true
  end

  -- Handle the scenario where lhs is a table containing multiple keymaps
  if type(lhs) == "table" then
    for _, keymap in ipairs(lhs) do
      if not process_keymap(keymap) then
        return false
      end
    end
    return true
  else
    -- Handle a single keymap entry
    return process_keymap({})
  end
end

---@function Helper function to remove keymaps
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

  ---@class Keymap
  ---@field lhs string The keybind
  ---@field rhs string|function The function or command associated with the keybind

  if bufnr then
    -- If a buffer number is provided, remove the keymap from the specified buffer
    ---@type Keymap[]
    local keymaps = vim.api.nvim_buf_get_keymap(bufnr, mode)
    for _, keymap in pairs(keymaps) do
      if keymap.lhs and keymap.lhs == lhs then
        vim.api.nvim_buf_del_keymap(bufnr, mode, lhs)
        return true -- Indicate that the keymap was removed
      end
    end
  else
    -- If no buffer number is provided, remove the global keymap
    ---@type Keymap[]
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

---@function Helper function to add a mark
---@param mark string The mark to add
---@param line integer The line to add the mark to
---@param col integer The column to add the mark to
---@return boolean condition true if the mark was added, false otherwise
function M.add_mark(mark, line, col)
  -- Set the mark at the specified line and column
  vim.api.nvim_buf_set_mark(0, mark, line, col, {})
  return true -- Indicate that the mark was successfully added
end

---@function Helper function to remove a mark
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

---@function Function to check if buffer is modified
---@return boolean condition true if buffer is modified, false otherwise
function M.is_buffer_modified()
  return vim.bo.modified
end

---@function Function to check if buffer is empty
---@return boolean condition true if buffer is empty, false otherwise
function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

---@function Function to check if buffer is read-only
---@return boolean condition true if buffer is read-only, false otherwise
function M.is_buffer_readonly()
  return vim.bo.readonly
end

---@function Function to check if file exists
---@param filepath string The path to the file
---@return boolean condition true if file exists, false otherwise
function M.file_exists(filepath)
  local f = io.open(filepath, "r")
  if f then
    f:close()
  end
  return f ~= nil
end

---@function Function to get the current git branch
---@return string branch git branch name or "No branch"
function M.get_git_branch()
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
  if branch and branch ~= "" then
    return branch
  else
    return "No branch"
  end
end

---@function Function to get the current git commit hash
---@return string The current git commit hash or "No commit hash"
function M.get_git_commit_hash()
  local commit_hash = vim.fn.systemlist("git rev-parse --short HEAD")[1]
  if commit_hash and commit_hash ~= "" then
    return commit_hash
  else
    return "No commit hash"
  end
end

---@function Function to run a shell command
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
    M.notify("Failed to run the command: " .. cmd, "ERROR")
    return nil
  end
end

---@function Function to get the dimensions of the current window
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

---@function Function to get the cursor position
---@return integer row The current line number
---@return integer col The current column number
function M.get_cursor_position()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return row, col
end

---@function Function to check if a global variable is set
---@param var_name string The name of the global variable
---@param expected_value any The expected value of the global variable
---@param default_value any The default value of the global variable
---@return boolean condition true if the global variable is set to the expected value, false otherwise
function M.check_global_var(var_name, expected_value, default_value)
  local actual_value = vim.g[var_name]

  -- If the global variable is not set, use the default value (if provided)
  if actual_value == nil and default_value ~= nil then
    actual_value = default_value
  end

  -- Return whether the actual value matches the expected value
  return actual_value == expected_value
end

---@function Function to split a string
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

---@function Function to convert RGB to hexadecimal
---@param rgb table The RGB color
---@return string hex The hexadecimal color
function M.rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

---@function Function to get the foreground color of a highlight group
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

---@function Function to get the background color of a highlight group
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

---@function Function to check if the window is wide enough
---@param width_limit number The minimum width of the window
---@return boolean condition true if the window is wide enough, false otherwise
function M.is_window_wide_enough(width_limit)
  local width = vim.fn.winwidth(0)
  return width >= width_limit
end

---@function Function to check if the window is tall enough
---@param height_limit number The minimum height of the window
---@return boolean condition true if the window is tall enough, false otherwise
function M.is_window_tall_enough(height_limit)
  local height = vim.fn.winheight(0)
  return height >= height_limit
end

---@function Function to get the current date
---@return string|osdate date The current date
function M.get_date()
  return os.date("%Y-%m-%d")
end

---@function Function to exit neovim
---@return nil
function M.exit()
  vim.api.nvim_command("wqall")
end

-- Export the module
return M
