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

---@function Function to move blocks of text up and down
---@param up? boolean Whether to move the blocks up or down
---  Ex: Move selected block of text up: move_visual(true)
---      Move selected block of text down: move_visual(false)
---@param multiplier? integer The number of times to move the blocks
---  Ex: Move selected block of text up 3 times: move_visual(true, 3)
---      Move selected block of text down 2 times: move_visual(false, 2)
---@return nil
function M.move_visual(up, multiplier)
  -- Handle parameter
  local offset = 1
  if up then
    offset = -2
  end
  if multiplier then
    offset = offset * multiplier
  end

  -- escape visual mode
  vim.cmd("norm v")
  -- GET REGION
  -- eg region = { [103] = {0,-1}, [104] = {0,-1}, [105] = {0,-1}}
  ---@diagnostic disable-next-line: deprecated
  local region = vim.region(0, "'<", "'>", vim.fn.visualmode(), true)

  local function array_keys(array)
    local keys = {}
    for k in pairs(array) do
      table.insert(keys, k)
    end
    return keys
  end

  -- GET LINES
  -- eg lines = { 103, 104, 105 }
  local lines = array_keys(region)
  table.sort(lines)

  -- GET TOP/BOTTOM LINE NUMBERS
  local top = lines[1] + 1
  local bottom = lines[#lines] + 1

  -- EXECUTE
  local new_pos = offset > 0 and bottom + offset or top + offset
  vim.cmd(string.format("silent %d, %d move %d", top, bottom, new_pos))
  -- eg :silent 104, 106 move 107

  vim.cmd("norm gv")
end

---@function Function to paste over text with overwrite
---@return nil
function M.paste_overwrite()
  -- Get the register contents and type
  local register = vim.fn.getreginfo(vim.v.register or '"')
  local regcontents = register.regcontents

  -- Enter Virtual Replace Mode
  vim.api.nvim_feedkeys("gR", "n", false)

  -- Process each line in the register contents
  for i, line in ipairs(regcontents) do
    if i > 1 then
      -- Handle formatting of multi-line pastes (except for the first line)
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>0gR", true, false, true),
        "n",
        false
      )
    end

    -- Paste the current line; add a newline if it's not the last line
    if i < #regcontents then
      vim.api.nvim_feedkeys(line .. "\n", "n", false)
    else
      vim.api.nvim_feedkeys(line, "n", false)
    end
  end

  -- Properly exit Virtual Replace Mode using <Esc>
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
    "n",
    false
  )
end

---@function Function to dump the current buffer to a register and format as a Lua table
---@param register string? The name of the register to dump the buffer to (defaults to unnamed register if nil)
---@return nil
function M.dump_buffer_to_table(register)
  register = register or "" -- Default to unnamed register if not provided

  -- Get the lines from the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Process the buffer contents
  local result = {}
  for _, line in ipairs(lines) do
    local entry = line:gsub("%.lua$", "") -- Remove ".lua" extension
    table.insert(result, '"' .. entry .. '"')
  end

  -- Join the result into a single string and format as a Lua table
  local output = "{ " .. table.concat(result, ", ") .. " }"

  -- Dump the result into a register
  vim.fn.setreg(register, output)
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

  -- Try to require the lazy.core.config module
  local ok, lazy_config = pcall(require, "lazy.core.config")

  if not ok then
    -- Handle the error; the module is not available
    print("lazy.core.config not found")
  else
    -- Get the list of currently loaded plugins
    local plugins = lazy_config.plugins

    -- Iterate over each plugin and reload it if it's not in the exclusion list
    for plugin_name, _ in pairs(plugins) do
      if not exclude[plugin_name] then
        vim.cmd("Lazy reload " .. plugin_name)
      end
    end
  end
end

---@function Check if a plugin is installed.
---@param plugins string|table The name of the plugin module(s) to check.
---  Options:
---   - string: The name of the plugin module to check.
---   - table: A list of plugin modules to check.
---@param simple boolean|nil Whether to use a simple check (pcall(require, plugin)).
---@return boolean|table condition The installed state of the plugin(s).
---   - boolean: The installed state of the plugin.
---   - table: A list of installed states of the plugins.
---     - boolean: The installed state of the plugin.
---  The return type is determined based on the input type.
---  If the input is a table of plugin modules, the return type is a table.
function M.is_installed(plugins, simple)
  local is_single = type(plugins) == "string"
  if type(plugins) == "string" then
    plugins = { plugins }
  end

  local installed_plugins = {}
  for _, plugin in ipairs(plugins) do
    local installed = false
    if simple then
      installed = pcall(require, plugin)
    else
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
    end
    installed_plugins[plugin] = installed
  end

  if is_single then
    return installed_plugins[plugins[1]]
  else
    return installed_plugins
  end
end

---@function Function to create a floating terminal window
function M.open_floating_terminal()
  -- Create a scratch buffer specifically for the terminal
  local buf = vim.api.nvim_create_buf(false, true) -- Create an unnamed, non-file, scratch buffer

  if not buf or buf == 0 then
    vim.notify("Failed to create buffer", vim.log.levels.ERROR)
    return
  end

  -- Get the dimensions of the current editor window
  -- This helps us center the floating window
  local ui = vim.api.nvim_list_uis()[1]
  local width = ui.width
  local height = ui.height
  local win_width = math.floor(width * 0.8)
  local win_height = math.floor(height * 0.8)

  -- Define settings of the floating window, sizing it to 80% of the full editor size
  local win_opts = {
    style = "minimal", -- Minimal UI, no status line or tab line
    relative = "editor", -- Float relative to the whole editor UI
    width = win_width, -- Set width to 80% of editor width
    height = win_height, -- Set height to 80% of editor height
    row = math.floor((height - win_height) / 2), -- Centered vertically
    col = math.floor((width - win_width) / 2), -- Centered horizontally
    border = "rounded", -- Add a border for aesthetics (can be 'single', 'double', etc.)
  }

  -- Open the floating window with our newly created buffer
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Check if the window was created successfully
  if not win or win == 0 then
    vim.notify("Failed to create floating window", vim.log.levels.ERROR)
    return
  end

  -- Set very specific buffer and window configurations
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf }) -- Auto-remove when the buffer is closed
  vim.api.nvim_set_option_value("winblend", 10, { win = win }) -- Add slight transparency to the floating window

  -- Now that the floating window is ready, we run the terminal shell in the created buffer
  -- Open the terminal in the buffer when we're sure the buffer is set up in the float
  vim.fn.termopen(vim.o.shell, {
    on_exit = function()
      -- Safety measure: Ensure the window still exists before trying to close it
      if vim.api.nvim_win_is_valid(win) then
        -- Notify the user that the terminal has closed
        vim.notify("Terminal closed", vim.log.levels.INFO)
        -- Close and wipe the associated floating window and its buffer
        vim.api.nvim_win_close(win, true) -- Force close the terminal window
      end
    end,
  })

  -- Switch focus to the terminal window in the floating buffer and enter insert mode
  vim.api.nvim_set_current_win(win)
  vim.cmd("startinsert!") -- Automatically enter insert mode within the terminal
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

---@function Function to get the appropriate ordinal suffix for a given number.
---@param number number The number to check for the ordinal suffix.
---@return string The number with its ordinal suffix.
function M.get_ordinal_suffix(number)
  -- Determine the last two digits to handle 'teen' cases correctly
  local suffix = "th" -- Default suffix
  local last_digit = number % 10
  local last_two_digits = number % 100

  if last_digit == 1 and last_two_digits ~= 11 then
    suffix = "st"
  elseif last_digit == 2 and last_two_digits ~= 12 then
    suffix = "nd"
  elseif last_digit == 3 and last_two_digits ~= 13 then
    suffix = "rd"
  end

  return tostring(number) .. suffix
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

---@function Function to render the MultiCursor statusline
---@return table status The MultiCursor status object
function M.mc_statusline()
  -- Define the default status object
  local status = {
    enabled = false,
    icon = "󰘪 ",
    short_text = "NO",
    text = "SINGLE",
    color = "lualine_a_normal",
    cursors = 1,
    disabled = 0,
    installed = false,
  }

  local ok, mc = pcall(require, "multicursor-nvim")
  if not ok then
    -- Handle the case where the plugin is not installed
    return status
  end

  status.installed = true
  if mc.numEnabledCursors() > 1 then
    status.enabled = true
    status.cursors = mc.numEnabledCursors()
    status.disabled = mc.numDisabledCursors()
    if vim.fn.mode() == "v" then
      -- status.icon = "󰚕 "
      status.icon = "󰆿"
      status.short_text = "V"
      status.text = "VISUAL"
      status.color = "lualine_a_visual"
    else
      -- status.icon = "󰬸 "
      status.icon = "󰇀"
      status.short_text = "N"
      status.text = "NORMAL"
      status.color = "lualine_a_normal"
    end
  end

  -- Add the icon and text to the status object
  status.icon_short_text = status.icon .. status.short_text
  status.icon_text = status.icon .. status.text

  -- Update the status object
  if status.cursors > 1 and status.disabled > 0 then
    status.count = status.cursors .. "/" .. status.disabled
  elseif status.cursors > 1 and status.disabled <= 0 then
    status.count = status.cursors
  else
    status.count = ""
  end
  return status
end

--- Configure conditional spellchecking

---@function This function conditionally enables spellcheck based on the provided parameters.
---@param spellcheck? boolean Whether to enable spellcheck (default: true)
---@param filetypes? table|boolean A list of filetypes to enable/disable spellcheck in
---  (default: nil)
---  - If true, toggle spellcheck for all filetypes
---  - If false, enable spellcheck for the current buffer
---  - If a table, enable spellcheck for the specified filetypes
---  - If nil, enable spellcheck for the current buffer
---@return nil
function M.spellcheck(spellcheck, filetypes)
  -- Default to true if spellcheck is not provided
  spellcheck = spellcheck == nil and true or spellcheck

  -- Set up local toggler
  local function toggle()
    -- Handle local spellchecking
    if spellcheck then -- Enable spellcheck for the current buffer
      vim.opt_local.spell = true
    else -- Disable spellcheck for the current buffer
      vim.opt_local.spell = false
    end
  end

  -- Handle filetype-specific spellchecking
  if filetypes then
    -- Set up description text
    local desc = "Enable"
    if not spellcheck then
      desc = "Disable"
    end

    -- Make a comma-separated list of filetypes
    local typedesc
    if type(filetypes) == "table" then
      typedesc = table.concat(filetypes, ",")
    else -- Fallback to a string
      typedesc = tostring(filetypes)
    end

    -- If filetypes is a boolean
    if filetypes == true then
      filetypes = { "*" } -- Apply to all filetypes
    elseif filetypes == false then
      toggle()
    end

    -- Create an autocommand for the specified filetypes to manage spellcheck
    vim.api.nvim_create_autocmd("FileType", {
      group = "Spellcheck",
      pattern = filetypes,
      callback = function()
        vim.opt_local.spell = spellcheck
      end,
      desc = desc .. " spellcheck for " .. typedesc,
    })
  else
    -- Handle local spellchecking
    toggle()
  end
end

---@function This function swaps the behavior of `p` and `P`
---@param default? boolean Whether to use the default behavior (default: true)
---    - true: swap the behavior of `p` and `P`
---    - false: revert the behavior of `p` and `P`
---@return nil
function M.swap_paste(default)
  if default == nil then
    default = true
  end
  if default then
    -- Mapping to swap the behavior of `p` and `P`
    -- `p` will now paste before the cursor (originally `P`)
    -- `P` will now paste after the cursor (originally `p`)

    -- Preserve the original actions of `p` and `P` using Vim commands to avoid interference

    -- Set `p` to the original paste after cursor
    vim.api.nvim_set_keymap("n", "p", '"_dP', { noremap = true, silent = true })
    -- Set `P` to the original paste before cursor
    vim.api.nvim_set_keymap(
      "n",
      "P",
      '"_d"0p',
      { noremap = true, silent = true }
    )
  else
    -- Mapping to revert the behavior of `p` and `P` to their original functions
    -- `p` will now revert to pasting after the cursor (original behavior)
    -- `P` will now revert to pasting before the cursor (original behavior)

    -- Remap `p` to its original behavior
    vim.api.nvim_set_keymap("n", "p", "p", { noremap = true, silent = true })

    -- Remap `P` to its original behavior
    vim.api.nvim_set_keymap("n", "P", "P", { noremap = true, silent = true })
  end
end

---@function This function extracts text between two marked positions in a buffer,
---          removes empty lines, and trims indentation from the left.
---@return string? text The extracted and trimmed text
---          - nil if there is no text in the specified range
---          - string if the text is in the specified range
function M.trim_yank()
  -- Execute the last command in normal mode
  vim.cmd.normal("!<Esc>")

  -- Get the start and finish positions of the selected text
  local start = vim.fn.getpos("'<")
  local finish = vim.fn.getpos("'>")

  -- Get the lines in the specified range
  local lines = vim.fn.getline(start[2], finish[2])

  -- Ensure lines is a table even if only one line is selected
  if type(lines) == "string" then
    lines = { lines }
  end

  -- Drop empty lines from the selection
  for i = #lines, 1, -1 do
    if lines[i] == "" then
      table.remove(lines, i)
    end
  end

  -- Return early if there are no lines to process
  if #lines == 0 then
    return
  end

  -- Find the minimum whitespace (indentation) in the selected lines
  local ws = 9999
  for _, line in ipairs(lines) do
    local lws = line:match("^%s*") -- Extract leading whitespace
    if lws and #lws < ws then
      ws = #lws
    end
  end

  -- Trim the leading whitespace from each line according to the minimal whitespace found
  for i, line in ipairs(lines) do
    lines[i] = line:sub(ws + 1)
  end

  -- Return the resulting lines as a single concatenated string
  return table.concat(lines, "\n")
end

---@function Function to open the lazygit popup in a floaterm
---@return nil
function M.open_lazygit_popup()
  -- Set floaterm border characters
  vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

  -- Floaterm configuration properties
  local floaterm_props = {
    width = "0.98", -- Width of the floaterm
    height = "0.95", -- Height of the floaterm
    autoclose = "1", -- Auto close the floaterm when finished
    command = "lazygit", -- Command to run in the floaterm
    name = "LazyGit", -- Name of the floaterm
    title = "LazyGit", -- Title of the floaterm
    titlepos = "center", -- Title position of the floaterm
  }

  -- Construct the command string for opening the floaterm with the specified settings
  local cmd = string.format(
    "FloatermNew --height=%s --width=%s --name=%s --title=%s --titleposition=%s --autoclose=%s %s",
    floaterm_props.height,
    floaterm_props.width,
    floaterm_props.name,
    floaterm_props.title,
    floaterm_props.titlepos,
    floaterm_props.autoclose,
    floaterm_props.command
  )

  -- Execute the command
  vim.cmd(cmd) -- Using vim.cmd to run the constructed command

  -- Enter insert mode in the floaterm
  vim.cmd("startinsert")
end

---@function Function to replace '...' with '…' (ellipsis)
---@return boolean condition true if the replacement was successful, false otherwise
function M.replace_ellipsis()
  -- Get the current line and the cursor position
  local current_line = vim.api.nvim_get_current_line()
  local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Get the current cursor position

  -- Check if the current line ends with '...'
  if current_line:sub(cursor_pos[2] - 2, cursor_pos[2]) == "..." then
    -- Replace '...' with '…' using string manipulation
    local new_line = current_line:sub(1, cursor_pos[2] - 3) .. "…"

    -- Set the new line content
    vim.api.nvim_set_current_line(new_line)

    -- Move cursor to the new position after replacing
    vim.api.nvim_win_set_cursor(0, { cursor_pos[1], cursor_pos[2] - 2 }) -- Adjust cursor position

    return true
  end

  return false
end

---@function Function to automate replacing '...' with '…' (ellipsis)
---@param enable? boolean whether to enable the replacement on InsertLeave
---@return boolean result true if the replacement was enabled, false otherwise
function M.setup_replace_ellipsis(enable)
  if enable == nil then
    enable = true
  end

  -- Create an autogroup to handle the autocmds
  vim.api.nvim_create_augroup("EllipsisReplace", { clear = true })

  if enable then
    -- Add an autocmd to handle the InsertLeave event
    vim.api.nvim_create_autocmd("InsertLeave", {
      group = "EllipsisReplace",
      callback = M.replace_ellipsis,
    })

    -- Optionally, you could call the function on text change as well
    vim.api.nvim_create_autocmd("TextChangedI", {
      group = "EllipsisReplace",
      callback = M.replace_ellipsis,
    })
    return true
  else
    -- Remove the autocmds
    vim.api.nvim_del_augroup_by_id(
      vim.api.nvim_create_augroup("EllipsisReplace", { clear = true })
    )
  end

  return false
end

--- Function to append modeline after the last line in the buffer.
--- @return nil
function M.append_modeline()
  local tabstop = vim.o.tabstop
  local shiftwidth = vim.o.shiftwidth
  local textwidth = vim.o.textwidth
  local expandtab = vim.o.expandtab

  -- Create the modeline string.
  local modeline = string.format(
    " vim: set ts=%d sw=%d tw=%d %set :",
    tabstop,
    shiftwidth,
    textwidth,
    expandtab and "" or "no"
  )

  -- Replace the placeholder in the comment string.
  local commentstring = vim.o.commentstring
  modeline = commentstring:gsub("%%s", modeline)

  -- Append the modeline after the last line in the buffer.
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { modeline })
end

--- Function to remove buffer
--- Borrowed from LazyVim
--- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/ui.lua
---@param buf number?
function M.bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(
      ("Save changes to %q?"):format(vim.fn.bufname()),
      "&Yes\n&No\n&Cancel"
    )
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if
        not vim.api.nvim_win_is_valid(win)
        or vim.api.nvim_win_get_buf(win) ~= buf
      then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr("#")
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      ---@diagnostic disable-next-line: param-type-mismatch
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, "bdelete! " .. buf)
  end
end

-- Export the module
return M
