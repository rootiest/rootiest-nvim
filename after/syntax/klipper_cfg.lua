local api = vim.api

-- Clear any existing syntax rules
api.nvim_command("syntax clear")

-- Default to INI syntax highlighting
api.nvim_command("runtime! syntax/ini.vim")

-- Define gcode region
api.nvim_command(
  'syntax region klipperGcode start="^\\s*gcode:" end="^\\S" keepend contains=klipperJinja,klipperJinjaCondition'
)

-- Define Jinja highlighting within gcode
api.nvim_command('syntax region klipperJinja start="{" end="}" contained')
api.nvim_command(
  'syntax region klipperJinjaCondition start="{%" end="%}" contained'
)

-- Apply custom highlighting
api.nvim_command("highlight link klipperGcode Identifier")
api.nvim_command("highlight link klipperJinja Conditional")
api.nvim_command("highlight link klipperJinjaCondition Statement")
