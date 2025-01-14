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

--- DiffView plugin cmds
M.diffview = {
  'DiffviewOpen',
  'DiffviewClose',
  'DiffviewToggleFiles',
  'DiffviewFocusFiles',
  'DiffviewRefresh',
  'DiffviewFileHistory',
}

--- FloatingHelp plugin cmds
M.floating_help = {
  'FloatingHelp',
  'FloatingHelpClose',
  'FloatingHelpToggle',
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

--- ImgClip plugin cmds
M.imgclip = {
  'ImgClipEmbed',
  'PasteImage',
  'ImgClipConfig',
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

--- Markdown-preview plguin cmds
M.markdown_preview = {
  'MarkdownPreviewToggle',
  'MarkdownPreview',
  'MarkdownPreviewStop',
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

--- Spell Errors plugin cmds
M.spell_errors = {
  'Telescope spell_errors',
}

--- Symbols plugin cmds
M.symbols = {
  'Symbols',
  'SymbolsToggle',
  'SymbolsOpen',
  'SymbolsClose',
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
