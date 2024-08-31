--          ╭─────────────────────────────────────────────────────────╮
--          │                        KEYS DATA                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Load utils
local rootiest = require("config.rootiest")

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

M.flash = {
  {
    "<CR>",
    function()
      require("flash").jump()
    end,
    desc = "Flash jump",
    mode = { "n", "o", "v" },
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

M.groups = {
  -- Icon picker
  {
    lhs = "<leader>I",
    group = "IconPicker",
    icon = { icon = "󰥸", color = "orange" },
  },
  -- Gists menu
  {
    lhs = "<leader>gn",
    group = "Gists",
    icon = { icon = "", color = "orange" },
  },
  -- Lazy menu
  {
    lhs = "<leader>l",
    group = "Lazy",
    icon = { icon = "󰒲", color = "red" },
  },
  -- MiniMap menu
  {
    lhs = "<leader>n",
    group = "MiniMap",
    icon = { icon = "", color = "green" },
  },
  -- Code action menu
  {
    lhs = "<leader>C",
    group = "CodeActions",
    icon = { icon = "", color = "yellow" },
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

M.indentor = {
  { -- Indentor
    "<C-i>",
    function()
      require("utils.indentor").insert_previous_line_indentation()
    end,
    "Insert Previous Line Indentation",
    { "i", "n" },
  },
}

M.lazygit = {
  { -- LazyGit
    "<leader>lg",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit",
  },
}

M.misc = {
  -- LazyGit
  {
    lhs = "<leader>gt",
    rhs = function()
      rootiest.toggle_lazygit_float()
    end,
    desc = "LazyGit Terminal",
  },
  -- Yank line (without whitespace)
  {
    lhs = "yo",
    rhs = function()
      rootiest.yank_line()
    end,
    desc = "Yank Line-text",
  },
  -- Hardmode
  {
    lhs = "<leader>uH",
    rhs = function()
      rootiest.toggle_hardmode()
    end,
    desc = "Toggle Hardmode",
  },
  -- Yank buffer
  {
    lhs = "<leader>Y",
    rhs = "<cmd>%y<cr>",
    desc = "Yank buffer contents",
  },
  -- Select all
  {
    lhs = "<C-a>",
    rhs = "<cmd>norm ggVG<cr>",
    desc = "Select all",
  },
  -- Neotree
  {
    lhs = "|",
    rhs = "<cmd>Neotree reveal toggle<cr>",
    desc = "Neotree toggle",
  },
  -- Exit Neovim
  {
    lhs = "<leader>Q",
    rhs = "<cmd>lua require('data').func.exit()<cr>",
    desc = "Exit Neovim",
  },
  -- LazyVim
  {
    lhs = "<leader>lv",
    rhs = "<cmd>Lazy<cr>",
    desc = "LazyVim",
  },
  -- LazyExtras
  {
    lhs = "<leader>lx",
    rhs = "<cmd>LazyExtras<cr>",
    desc = "LazyExtras",
  },
  -- De-map 's' to avoid conflicts with mini.surround
  {
    lhs = "s",
    rhs = "<Nop>",
    desc = "Nos",
    mode = { "n", "x" },
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
  { -- Open Qalc
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

M.splits = {
  resize = {
    {
      "<A-h>",
      function()
        require("smart-splits").resize_left()
      end,
      "Resize split left",
    },
    {
      "<A-j>",
      function()
        require("smart-splits").resize_down()
      end,
      "Resize split down",
    },
    {
      "<A-k>",
      function()
        require("smart-splits").resize_up()
      end,
      "Resize split up",
    },
    {
      "<A-l>",
      function()
        require("smart-splits").resize_right()
      end,
      "Resize split right",
    },
    {
      "<A-r>",
      function()
        require("smart-splits").start_resize_mode()
      end,
      "Resize split to previous size",
    },
  },
  move = {
    {
      "<C-S-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      "Move cursor left",
    },
    {
      "<C-S-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      "Move cursor down",
    },
    {
      "<C-S-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      "Move cursor up",
    },
    {
      "<C-S-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      "Move cursor right",
    },
    {
      "<C-\\>",
      function()
        require("smart-splits").move_cursor_previous()
      end,
      "Move cursor to previous split",
    },
  },
  swap = {
    {
      "<A-S-h>",
      function()
        require("smart-splits").swap_buf_left()
      end,
      "Swap buffer left",
    },
    {
      "<A-S-j>",
      function()
        require("smart-splits").swap_buf_down()
      end,
      "Swap buffer down",
    },
    {
      "<A-S-k>",
      function()
        require("smart-splits").swap_buf_up()
      end,
      "Swap buffer up",
    },
    {
      "<A-S-l>",
      function()
        require("smart-splits").swap_buf_right()
      end,
      "Swap buffer right",
    },
  },
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

M.surround = {
  { -- De-map 's' to prevent conflicts
    "s",
    "<Nop>",
    desc = "Nos",
    mode = { "n", "x" },
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

M.transparent = {
  {
    "<leader>wt",
    function()
      require("transparent").toggle()
    end,
    desc = "Toggle Transparency",
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
