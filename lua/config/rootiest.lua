local M = {}

local precog_first_time = true

-- Define the config path and default values
local config_path = vim.fn.stdpath("config")

function M.set_defaults()
  -- Set Default Leader Key
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"
end

function M.eval_settings_files()
  -- Function to ensure a file exists and write a default value if it doesn't
  local function ensure_file_exists(file_path, default_value, setup_func)
    if vim.fn.filereadable(file_path) ~= 1 then
      if setup_func then
        -- Call the setup function if provided
        setup_func()
      else
        -- Write default value to file
        vim.fn.writefile({ default_value }, file_path)
      end
    end
  end

  local defaults = {
    [config_path .. "/.aitool"] = "codeium",
    [config_path .. "/.useimage"] = "true",
    [config_path .. "/.wakatime"] = "true",
    [config_path .. "/.hardtime"] = "false",
    [config_path .. "/.ignore-deps"] = "false",
    [config_path .. "/.leader"] = vim.g.mapleader,
  }

  -- Function to handle special logic for the .colorscheme file
  local function setup_colorscheme()
    local color_file = config_path .. "/.colorscheme"
    if M.kitty_theme then
      vim.fn.writefile({ M.kitty_theme }, color_file)
    else
      vim.fn.writefile({ vim.g.colors_name }, color_file)
    end
  end

  -- Ensure each file exists with the corresponding default value or special logic
  for file_path, default_value in pairs(defaults) do
    ensure_file_exists(file_path, default_value)
  end

  -- Ensure the .colorscheme file exists with special logic
  ensure_file_exists(config_path .. "/.colorscheme", nil, setup_colorscheme)
end

function M.restore_colorscheme()
  -- Restore colorscheme
  vim.cmd.colorscheme(M.colortheme or "catppuccin-frappe" or "tokyonight")
end

function M.yank_line()
  -- Yank line without leading/trailing whitespace
  vim.api.nvim_feedkeys("_v$hy$", "n", true)
end

function M.using_kitty()
  local term = os.getenv("TERM") or ""
  local kit = string.find(term, "kitty")
  return kit ~= nil
end

function M.toggle_precognition()
  if precog_first_time then
    require("precognition").toggle()
    require("precognition").toggle() -- Call toggle twice
    precog_first_time = false -- Update variable after the first call
  else
    require("precognition").toggle() -- Call toggle once
  end
end

function M.toggle_hardmode()
  require("hardtime").toggle()
  M.toggle_precognition()
end

function M.toggle_lazygit_term()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
  lazygit:toggle()
end

-- Function to check if a given string matches the content of the .aitool file
function M.using_aitool(input)
  local aitool_file = config_path .. "/.aitool"

  -- Ensure the .aitool file exists
  if vim.fn.filereadable(aitool_file) ~= 1 then
    vim.fn.writefile({ "codeium" }, aitool_file)
  end

  -- Read the file and normalize its content
  local content = vim.fn.readfile(aitool_file)[1] or ""
  local normalized_content = content:lower():gsub("%s+", "")

  -- Normalize the input and compare
  local normalized_input = input:lower():gsub("%s+", "")
  return normalized_input == normalized_content
end

function M.load_remote()
  ---@diagnostic disable-next-line: missing-parameter
  require("remote-nvim").setup()
  vim.cmd("RemoteStart")
end

function M.set_cursor_icons()
  -- Define last cursor position icon
  vim.fn.sign_define("smoothcursor_n", { text = "" })
  vim.fn.sign_define("smoothcursor_v", { text = " " })
  vim.fn.sign_define("smoothcursor_V", { text = "" })
  vim.fn.sign_define("smoothcursor_i", { text = "" })
  vim.fn.sign_define("smoothcursor_�", { text = "" })
  vim.fn.sign_define("smoothcursor_R", { text = "󰊄" })
end

function M.eval_dependencies()
  -- Function to read the .ignore-deps file and return whether warnings should be suppressed
  local function should_suppress_warnings()
    local ignore_file = config_path .. "/.ignore-deps"
    local file = io.open(ignore_file, "r")
    if file then
      local content = file:read("*a")
      file:close()
      content = content:lower():gsub("%s+", "") -- convert to lowercase and remove whitespace
      local suppress_values = { ["true"] = true, ["1"] = true, ["yes"] = true }
      return suppress_values[content] or false
    end
    return false
  end

  -- Function to check if an executable is installed and generate a warning if not
  local function check_executable(executable)
    if vim.fn.executable(executable) ~= 1 then
      vim.api.nvim_notify(
        executable .. " is not installed!",
        vim.log.levels.WARN,
        {}
      )
    end
  end

  -- Check if warnings should be suppressed
  if not should_suppress_warnings() then
    -- List of executables to check
    local executables =
      { "lazygit", "gh", "rg", "fzf", "fd", "git", "luarocks" }

    -- Check each executable
    for _, executable in ipairs(executables) do
      check_executable(executable)
    end
  end
end

function M.eval_neovide()
  if vim.g.neovide then
    require("config.neovide")
  end
end

-- -------------------------------- Commands -----------------------------------
function M.define_commands()
  -- Make :Q close all of the buffers
  vim.api.nvim_create_user_command("Q", function()
    vim.cmd.qall()
  end, { force = true, desc = "Close all buffers" })

  -- Yank line without leading/trailing whitespace
  vim.api.nvim_create_user_command("YankLine", function()
    M.yank_line()
  end, { force = true, desc = "Yank line without leading whitespace" })

  -- Restore Colorscheme
  -- Define the RestoreColorscheme command
  vim.api.nvim_create_user_command(
    "RestoreColorscheme", -- Command name
    function() -- Callback function
      M.restore_colorscheme()
    end,
    { desc = "Restore colorscheme" }
  )

  -- Load/start Remote
  vim.api.nvim_create_user_command("LoadRemote", function()
    M.load_remote()
  end, { force = true, desc = "Load/start Remote" })
end

-- ------------------------------- Variables -----------------------------------
-- Load the kitty theme
M.kitty_theme = os.getenv("KITTY_THEME")

-- Load the stored colorscheme
M.colortheme = vim.fn.readfile(config_path .. "/.colorscheme")[1]

-- Load Stored Leader Key
M.leader = vim.fn.readfile(config_path .. "/.leader")[1]

-- --------------------------------- Setup -------------------------------------
function M.setup()
  -- Set Defaults
  M.set_defaults()
  -- Define Commands
  M.define_commands()
  -- Evaluate settings files
  M.eval_settings_files()
  -- Evaluate dependencies
  M.eval_dependencies()
  -- Evaluate neovide settings
  M.eval_neovide()
  -- Restore colorscheme
  M.restore_colorscheme()
  -- Set cursor icons
  M.set_cursor_icons()
  -- Load Stored Leader Key
  vim.g.mapleader = M.leader
end

return M
