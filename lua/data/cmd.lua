--- @module "data.cmd"
--- This module contains the commands for the plugins.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        CMD DATA                         │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

--- Autosave plugin cmds
M.autosave = {
  'ASToggle',
}

--- Codesnap plugin cmds
M.codesnap = {
  'CodeSnap',
  'CodeSnapSave',
  'CodeSnapHighlight',
  'CodeSnapASCII',
}

--- Gists plugin cmds
M.gist = {
  'GistCreate',
  'GistCreateFromFile',
  'GistsList',
}

--- Gx plugin cmds
M.gx = {
  'Browse',
}

--- Kitty-Scrollback plugin cmds
M.kitty_scrollback = {
  'KittyScrollbackGenerateKittens',
  'KittyScrollbackCheckHealth',
}

--- LazyGit plugin cmds
M.lazygit = {
  'LazyGit',
  'LazyGitConfig',
  'LazyGitCurrentFile',
  'LazyGitFilter',
  'LazyGitFilterCurrentFile',
}

--- Nekifoch plugin cmds
M.nekifoch = 'Nekifoch'

--- Thanks plugin cmds
M.thanks = {
  'ThanksAll',
  'ThanksGithubAuth',
  'ThanksGithubLogout',
  'ThanksClearCache',
}

--- Gitlinker plugin cmds
M.gitlinker = {
  'GitLink',
}

--- Qalc plugin cmds
M.qalc = {
  'Qalc',
  'QalcAttach',
  'QalcYank',
}

--- Ripsub plugin cmds
M.ripsub = {
  'RipSubstitute',
}

M.spell_errors = {
  'Telescope spell_errors',
}

--- Suda plugin cmds
M.suda = {
  'SudaWrite',
  'SudaRead',
}

--- Transparent plugin cmds
M.transparent = {
  'TransparentEnable',
  'TransparentDisable',
  'TransparentToggle',
}

--- Trouble plugin cmds
M.trouble = {
  'Trouble',
}

return M
