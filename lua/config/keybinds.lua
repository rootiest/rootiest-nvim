-- -----------------------------------------------------------------------------
-- -------------------------------- KEYBINDS -----------------------------------
-- -----------------------------------------------------------------------------

-- -------------------------------- Commands -----------------------------------
-- Make :Q close all of the buffers
vim.api.nvim_create_user_command("Q", function()
  vim.cmd.bdelete()
  vim.cmd.qall()
end, { force = true })

-- ------------------------------ Auto-Commands --------------------------------
-- Autosave Colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Store colorscheme name",
  callback = function()
    print("colorscheme:", vim.g.colors_name)
    vim.fn.writefile(
      { vim.g.colors_name },
      vim.fn.stdpath("config") .. "/.colorscheme"
    )
  end,
})

-- --------------------------------- Keymaps -----------------------------------
local wk = require("which-key")
wk.add({
  {
    "<c-/>",
    ":ToggleTerm<cr>",
    desc = "Toggle Terminal",
  },
  {
    "<leader>gt",
    rhs = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
      lazygit:toggle()
    end,
    desc = "LazyGit Terminal",
  },
  {
    "<leader>I",
    group = "IconPicker",
    icon = { icon = "󰥸", color = "orange" },
  },
  {
    "<Leader>Ii",
    "<cmd>IconPickerNormal<cr>",
    desc = "Pick Icon",
    group = "IconPicker",
  },
  {
    "<Leader>Iy",
    "<cmd>IconPickerYank<cr>",
    desc = "Yank Icon",
    group = "IconPicker",
  },
  {
    mode = "i",
    "<C-i>",
    "<cmd>IconPickerInsert<cr>",
    desc = "Insert Icon",
    group = "IconPicker",
  },
  {
    "<leader>gS",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit",
  },
  {
    "<leader>gn",
    group = "Gists",
    icon = { icon = "", color = "orange" },
  },
  {
    "<leader>gnc",
    "<cmd>GistCreate<cr>",
    desc = "Create Gist",
  },
  {
    "<leader>gnf",
    "<cmd>GistList<cr>",
    desc = "Find Gists",
  },
  {
    "<leader>l",
    group = "Lazy",
  },
  {
    "<leader>lv",
    "<cmd>Lazy<cr>",
    desc = "LazyVim",
  },
  {
    "<leader>lx",
    "<cmd>LazyExtras<cr>",
    desc = "LazyExtras",
  },
  {
    "<leader>m",
    group = "MiniMap",
    icon = { icon = "", color = "yellow" },
  },
  {
    "<leader>cy",
    "<cmd>CodeSnap<cr>",
    mode = "x",
    desc = "Save selected code snapshot into clipboard",
  },
  {
    "<leader>cs",
    "<cmd>CodeSnapSave<cr>",
    mode = "x",
    desc = "Save selected code snapshot in ~/Pictures",
  },
  {
    "<leader>ch",
    "<cmd>CodeSnapHighlight<cr>",
    mode = "x",
    desc = "Highlight and snapshot selected code into clipboard",
  },
  {
    "<leader>ci",
    "<cmd>CodeSnapASCII<cr>",
    mode = "x",
    desc = "Save ASCII code snapshot into clipboard",
  },
  {
    "gx",
    "<cmd>Browse<cr>",
    mode = { "n", "x" },
    desc = "Open URL/Link",
  },
  {
    "<leader>lg",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit",
  },
  {
    "<leader>fs",
    rhs = function()
      require("rip-substitute").sub()
    end,
    mode = { "n", "x" },
    desc = "Rip Substitute",
  },
  {
    "<c-s-h>",
    rhs = function()
      require("kitty-navigator").navigateLeft()
    end,
    desc = "KittyNavigateLeft",
    cond = function() -- Using Kitty
      local term = os.getenv("TERM") or ""
      local kit = string.find(term, "kitty")
      return kit ~= nil
    end,
  },
  {
    "<c-s-j>",
    rhs = function()
      require("kitty-navigator").navigateDown()
    end,
    desc = "KittyNavigateDown",
    cond = function() -- Using Kitty
      local term = os.getenv("TERM") or ""
      local kit = string.find(term, "kitty")
      return kit ~= nil
    end,
  },
  {
    "<c-s-k>",
    rhs = function()
      require("kitty-navigator").navigateUp()
    end,
    desc = "KittyNavigateUp",
    cond = function() -- Using Kitty
      local term = os.getenv("TERM") or ""
      local kit = string.find(term, "kitty")
      return kit ~= nil
    end,
  },
  {
    "<c-s-l>",
    rhs = function()
      require("kitty-navigator").navigateRight()
    end,
    desc = "KittyNavigateRight",
    cond = function() -- Using Kitty
      local term = os.getenv("TERM") or ""
      local kit = string.find(term, "kitty")
      return kit ~= nil
    end,
  },
  {
    "zk",
    rhs = function()
      require("precognition").toggle()
    end,
    desc = "Toggle Precognition",
  },
  {
    "<leader>a",
    "<cmd>Alternate<cr>",
    desc = "Toggle Alternate",
    cond = function()
      return (
        vim.bo.filetype == "c"
        or vim.bo.filetype == "h"
        or vim.bo.filetype == "cpp"
        or vim.bo.filetype == "hpp"
      )
    end,
  },
  {
    "<leader>wt",
    "<cmd>TransparentToggle<cr>",
    desc = "Toggle Transparency",
  },
})

-- ---------------------------- Spell Correction -------------------------------
require("config.spellcheck")
