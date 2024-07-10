-- -----------------------------------------------------------------------------
-- -------------------------------- KEYBINDS -----------------------------------
-- -----------------------------------------------------------------------------

-- Leader Maps
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    l = {
      name = "󰒲 Lazy",
      v = { "<cmd>Lazy<cr>", "󰒲 LazyVim" },
      x = { "<cmd>LazyExtras<cr>", " LazyExtras" },
    },
    g = {
      name = " Git",
      S = { "<cmd>LazyGit<cr>", " LazyGit" },
      n = {
        name = " Gists",
        c = { "<cmd>GistCreate<cr>", " Create Gist" },
        f = { "<cmd>GistList<cr>", "󰮗 Find Gists" },
      },
    },
  },
})

-- Make :Q close all of the buffers
vim.api.nvim_create_user_command("Q", function()
  vim.cmd.bdelete()
  vim.cmd.qall()
end, { force = true })