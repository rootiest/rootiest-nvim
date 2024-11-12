--          ╭─────────────────────────────────────────────────────────╮
--          │             Neovim Updater Debug Functions              │
--          ╰─────────────────────────────────────────────────────────╯

local D = {}

-- local P = require("nvim_updater")
local U = require('nvim_updater.utils')

function D.test_floating_window()
  local output = U.run_hidden_command(
    "cd ~/.local/src/neovim && git --no-pager log --pretty=format:'%s' HEAD..origin/master"
  )
  U.draw_floating_window(output)
end

return D
