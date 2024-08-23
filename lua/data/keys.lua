--          ╭─────────────────────────────────────────────────────────╮
--          │                        KEYS DATA                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

M.alternate = {
  { -- Toggle Alternate
    "<leader>a",
    "<cmd>Alternate<cr>",
    desc = "Toggle Alternate",
  },
}

M.capsword = {
  {
    "<C-s>",
    function()
      require("caps-word").toggle()
    end,
    desc = "Toggle CapsWord",
    mode = { "i", "n" },
  },
}

M.codesnap = {
  { -- Save selected code snapshot into clipboard
    "<leader>cy",
    "<cmd>CodeSnap<cr>",
    desc = "Save selected code snapshot into clipboard",
    mode = "x",
  },
  { -- Save selected code snapshot in ~/Pictures
    "<leader>cs",
    "<cmd>CodeSnapSave<cr>",
    desc = "Save selected code snapshot in ~/Pictures",
    mode = "x",
  },
  { -- Highlight and snapshot selected code into clipboard
    "<leader>ch",
    "<cmd>CodeSnapHighlight<cr>",
    desc = "Highlight and snapshot selected code into clipboard",
    mode = "x",
  },
  { -- Save ASCII code snapshot into clipboard
    "<leader>ci",
    "<cmd>CodeSnapASCII<cr>",
    desc = "Save ASCII code snapshot into clipboard",
    mode = "x",
  },
}

M.minimap = {
  { "<leader>nt", "<cmd>Neominimap toggle<cr>", desc = "Toggle minimap" },
  { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable minimap" },
  { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable minimap" },
  { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
  { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
  {
    "<leader>ns",
    "<cmd>Neominimap toggleFocus<cr>",
    desc = "Toggle focus on minimap",
  },
  {
    "<leader>nwt",
    "<cmd>Neominimap winToggle<cr>",
    desc = "Toggle minimap for current window",
  },
  {
    "<leader>nwr",
    "<cmd>Neominimap winRefresh<cr>",
    desc = "Refresh minimap for current window",
  },
  {
    "<leader>nwo",
    "<cmd>Neominimap winOn<cr>",
    desc = "Enable minimap for current window",
  },
  {
    "<leader>nwc",
    "<cmd>Neominimap winOff<cr>",
    desc = "Disable minimap for current window",
  },
  {
    "<leader>nbt",
    "<cmd>Neominimap bufToggle<cr>",
    desc = "Toggle minimap for current buffer",
  },
  {
    "<leader>nbr",
    "<cmd>Neominimap bufRefresh<cr>",
    desc = "Refresh minimap for current buffer",
  },
  {
    "<leader>nbo",
    "<cmd>Neominimap bufOn<cr>",
    desc = "Enable minimap for current buffer",
  },
  {
    "<leader>nbc",
    "<cmd>Neominimap bufOff<cr>",
    desc = "Disable minimap for current buffer",
  },
}

M.neocodeium = {
  { -- Accept suggestion
    "<c-y>",
    function()
      require("neocodeium").accept()
    end,
    desc = "Accept suggestion",
    mode = "i",
  },
  { -- Accept word
    "<c-w>",
    function()
      require("neocodeium").accept_word()
    end,
    desc = "Accept word",
    mode = "i",
  },
  { -- Accept line
    "<c-l>",
    function()
      require("neocodeium").accept_line()
    end,
    desc = "Accept line",
    mode = "i",
  },
  { -- Cycle or complete (previous)
    "<c-p>",
    function()
      require("neocodeium").cycle_or_complete(-1)
    end,
    desc = "Cycle or complete (previous)",
    mode = "i",
  },
  { -- Cycle or complete (next)
    "<c-n>",
    function()
      require("neocodeium").cycle_or_complete()
    end,
    desc = "Cycle or complete (next)",
    mode = "i",
  },
}

M.foldnav = {
  { -- Goto Start
    "<C-h>",
    function()
      require("foldnav").goto_start()
    end,
  },
  { -- Goto Next
    "<C-j>",
    function()
      require("foldnav").goto_next()
    end,
  },
  { -- Goto Prev
    "<C-k>",
    function()
      require("foldnav").goto_prev_start()
    end,
  },
  { -- Goto End
    "<C-l>",
    function()
      require("foldnav").goto_end()
    end,
  },
}

M.fugit = {
  { -- Open Fugit
    "<leader>F",
    mode = "n",
    "<cmd>Fugit2<cr>",
  },
}

M.gitlinker = {
  { -- Yank git link
    "<leader>gy",
    "<cmd>GitLink<cr>",
    mode = { "n", "v" },
    desc = "Yank git link",
  },
  { -- Open git link
    "<leader>gY",
    "<cmd>GitLink!<cr>",
    mode = { "n", "v" },
    desc = "Open git link",
  },
}

M.gitgraph = {
  { -- gitgraph_toggle
    "<leader>gm",
    function()
      require("utils.git").gitgraph_toggle()
    end,
    desc = "GitGraph - Toggle",
  },
}

M.gist = {
  { -- Create Gist
    "<leader>gnc",
    "<cmd>GistCreate<cr>",
    desc = "Create Gist",
    mode = { "n", "x" },
  },
  { -- Find Gists
    "<leader>gnf",
    "<cmd>GistList<cr>",
    desc = "Find Gists",
  },
}

M.gx = {
  { -- Open URL/Link
    "gx",
    "<cmd>Browse<cr>",
    mode = { "n", "x" },
    desc = "Open URL/Link",
  },
}

M.iconpicker = {
  { -- Pick Icon
    "<leader>Ii",
    "<cmd>IconPickerNormal<cr>",
    desc = "Pick Icon",
  },
  { -- Yank Icon
    "<leader>Iy",
    "<cmd>IconPickerYank<cr>",
    desc = "Yank Icon",
  },
  { -- Insert Icon in insert mode
    "<C-.>",
    "<cmd>IconPickerInsert<cr>",
    desc = "Insert Icon",
    mode = "i",
  },
}

M.lazygit = {
  { -- LazyGit
    "<leader>lg",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit",
  },
}

M.nekifoch = {
  { -- List Fonts
    "<leader>u,l",
    "<cmd>Nekifoch list<cr>",
    desc = "Fonts list",
  },
  { -- Check Font
    "<leader>u,c",
    "<cmd>Nekifoch check<cr>",
    desc = "Check current font settings",
  },
  { -- Set Font Family
    "<leader>u,f",
    function()
      require("nekifoch.nui_set_font")()
    end,
    desc = "Set font family",
  },
  { -- Set Font Size
    "<leader>u,s",
    function()
      require("nekifoch.nui_set_size")()
    end,
    desc = "Set font size",
  },
}

M.precog = {
  { -- Toggle Precognition
    "zk",
    function()
      require("config.rootiest").toggle_precognition()
    end,
    desc = "Toggle Precognition",
  },
}

M.qalc = {
  {
    "<leader>qc",
    "<cmd>Qalc<cr>",
    desc = "Qalc",
  },
}

M.ripsub = {
  { -- Rip Substitute
    "<leader>fs",
    function()
      require("rip-substitute").sub()
    end,
    mode = { "n", "x" },
    desc = "Rip Substitute",
  },
}

M.splitjoin = {
  toggle = "gJ",
}

M.substitute = {
  { -- Substitute operator in normal mode
    "x",
    function()
      require("substitute").operator()
    end,
    desc = "Substitute operator",
  },
  { -- Substitute line in normal mode
    "xx",
    function()
      require("substitute").line()
    end,
    desc = "Substitute line",
  },
  { -- Substitute end of line in normal mode
    "X",
    function()
      require("substitute").eol()
    end,
    desc = "Substitute end of line",
  },
  { -- Substitute visual selection in visual mode
    "x",
    function()
      require("substitute").visual()
    end,
    desc = "Substitute visual selection",
    mode = "x",
  },
  { -- Substitute visual selection in visual mode
    "<leader>r",
    function()
      require("substitute").visual()
    end,
    desc = "Substitute",
    mode = "x",
  },
}

M.toggleterm = {
  { -- Toggle Terminal
    "<c-/>",
    "<cmd>ToggleTerm<cr>",
    desc = "Toggle Terminal",
    mode = "n",
  },
}

M.zen = {
  { -- Toggle ZenMode
    "<leader>z",
    function()
      require("zen-mode").toggle()
    end,
    desc = "Toggle ZenMode",
  },
}

return M
