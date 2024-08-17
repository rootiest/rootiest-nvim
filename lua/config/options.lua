--          ╭─────────────────────────────────────────────────────────╮
--          │                         Options                         │
--          ╰─────────────────────────────────────────────────────────╯

-- Leader Key
vim.g.mapleader = " "

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ LSP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- We don't need perl
vim.g.loaded_perl_provider = 0
-- Prefer basedpyright
vim.g.lazyvim_python_lsp = "basedpyright"

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Git-Blame ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
-- vim.g.gitblame_date_format = "%r"
-- vim.g.gitblame_message_when_not_committed = "Not yet committed!"
-- vim.g.gitblame_message_template = "<author> • <date> • <summary> <<sha>>"

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ OS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ROOTIEST ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- stylua: ignore start
vim.g.aitool      = "codeium" --Options:  codeium, copilot, tabnine, minuet, none
vim.g.usewakatime = true      --Options:  true, false
vim.g.usehardtime = false     --Options:  true, false
vim.g.useimage    = true      --Options:  true, false
-- stylua: ignore end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ USER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.o.background = "dark"
vim.g.DashboardHeaderColor = "#A6E3A1"
