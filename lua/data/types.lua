--          ╭─────────────────────────────────────────────────────────╮
--          │                          TYPES                          │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

M.logo = {
  icon = "",
  color = "Special",
}

M.general = {
  -- Excluded buffer types
  buf = {
    "help",
    "alpha",
    "dashboard",
    "neo-tree",
    "Trouble",
    "trouble",
    "lazy",
    "mason",
    "notify",
    "toggleterm",
    "lazyterm",
  },
  -- excluded filetypes
  ft = {
    "help",
    "dashboard",
    "neorg",
  },
}

-- All modes for keymaps
M.all_modes = {
  "n",
  "i",
  "v",
  "x",
  "s",
  "o",
  "c",
  "t",
}

-- Filetypes for Alternate plugin
M.alternate = {
  "cpp",
  "h",
  "hpp",
  "c",
}

M.arrow = {
  show_icons = true,
  leader_key = ";", -- Recommended to be a single key
  buffer_leader_key = "m", -- Per Buffer Mappings
}

-- Bufferline configuration options
M.bufferline = {
  themable = true,
  color_icons = true,
  numbers = "ordinal",
  separator_style = "slant",
  auto_toggle_bufferline = true,
  buffer_close_icon = "󱎘",
  modified_icon = "●",
  close_icon = "",
  left_trunc_marker = "󰬨",
  right_trunc_marker = "󰬪",
  diagnostics_indicator = function(_, _, diagnostics_dict, _)
    local s = " "
    for e, n in pairs(diagnostics_dict) do
      local sym = e == "error" and " "
        or (e == "warning" and " " or " ")
      s = s .. sym .. n
    end
    return s
  end,
}

-- Nvim-cmp excluded filetypes
M.cmp = {
  "dashboard",
  "qalc",
}

-- Git-Blame configuration
M.gitblame = {
  display_virtual_text = 0, -- Disable virtual text
  date_format = "%r", -- Relative date format
  message_when_not_committed = "  Not yet committed",
  message_template = "<author> • <date> • <summary>",
}

-- Git-Graph plugin options
M.gitgraph = {
  -- Git-graph symbols check for kitty
  symbols = function()
    if require("data.func").is_kitty() then
      return {
        merge_commit = "",
        commit = "",
        merge_commit_end = "",
        commit_end = "",

        -- Advanced symbols
        GVER = "",
        GHOR = "",
        GCLD = "",
        GCRD = "╭",
        GCLU = "",
        GCRU = "",
        GLRU = "",
        GLRD = "",
        GLUD = "",
        GRUD = "",
        GFORKU = "",
        GFORKD = "",
        GRUDCD = "",
        GRUDCU = "",
        GLUDCD = "",
        GLUDCU = "",
        GLRDCL = "",
        GLRDCR = "",
        GLRUCL = "",
        GLRUCR = "",
      }
    else
      -- Fallback
      return {
        merge_commit = "M",
        commit = "*",
      }
    end
  end,
  -- Git graph timestamp style
  timestamp = "%H:%M:%S %d-%m-%Y",
  -- Git graph fields to display
  fields = { "hash", "timestamp", "author", "branch_name", "tag" },
}

-- Highlights module options
M.highlights = {
  -- Excluded buffer types
  exclude = {
    -- +general.buf
  },
}

-- Indent characters
M.ibl = {
  indent_char = {
    fancy = {
      "󰎤",
      "󰎧",
      "󰎪",
      "󰎭",
      "󰎱",
      "󰎳",
      "󰎶",
      "󰎹",
      "󰎼",
      "󰽽",
    },
    none = { " " },
    basic = { "󰇘" },
  },
  scope_char = {
    light = { "" },
    none = { " " },
    fancy = { "‖" },
    strong = { "⦀" },
    basic = { "" },
    arrow = { "" },
    tab = { "󰌒" },
  },
}

M.smart_splits = {
  build = function()
    if require("data.func").is_kitty() then
      return "./kitty/install-kittens.bash"
    else
      return false
    end
  end,
}

M.minimap = {
  -- Width of minimap
  width = 20,
  -- excluded buffer types
  buf = {
    "nofile",
    "nowrite",
    "quickfix",
    "terminal",
    "prompt",
    "alpha",
    "dashboard",
    -- +general.buf
  },
  -- excluded filetypes
  ft = {
    "help",
    "dashboard",
    "neorg",
  },

  -- Function to initialize or manipulate minimap settings
  init = function()
    M.setup()
    vim.g.neominimap = {
      auto_enable = true,
      layout = "float",
      exclude_filetypes = require("data.types").minimap.file,
      exclude_buftypes = require("data.types").minimap.buf,
      x_multiplier = 4,
      y_multiplier = 1,
      click = {
        enabled = true,
      },
      search = {
        enabled = true,
        mode = "line",
      },
      split = {
        minimap_width = M.minimap.width,
        fix_width = false,
      },
      float = {
        window_border = "none",
        minimap_width = M.minimap.width,
      },
    }
  end,

  -- Function to check if minimap should be enabled
  cond = function()
    M.setup()
    local ex_ft = M.minimap.ft
    local ex_buf = M.minimap.buf
    local ft = vim.bo.filetype
    local buf = vim.bo.buftype
    local mod = vim.bo.modifiable
    return not vim.tbl_contains(ex_ft, ft)
      and not vim.tbl_contains(ex_buf, buf)
      and mod == true
  end,
}

M.llama_copilot = {
  host = "localhost",
  port = "11434",
  model = "codellama:7b-code",
  max_completion_size = 15, -- use -1 for limitless
  debug = false,
}

M.substitute = {
  yank_substituted_text = false,
  preserve_cursor_position = true,
  on_substitute = function()
    require("yanky.integration").substitute()
  end,
}

-- Image.nvim filetypes
M.image = "markdown"

-- Todo-comments
M.todo = {
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = {
      icon = "⏲ ",
      color = "test",
      alt = { "TESTING", "PASSED", "FAILED" },
    },
  },
  lualine = function()
    local config = {
      -- The todo-comments types to show & in what order:
      order = { "TODO", "FIX", "HACK", "WARN", "NOTE", "PERF", "TEST" },
      keywords = M.todo.keywords,
      when_empty = "",
    }
    return config
  end,
}

-- Toggleterm plugin options
M.toggleterm = {
  size = function(term)
    if term.direction == "horizontal" then
      return 10
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  autochdir = true,
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = "curved",
    winblend = 3,
    title_pos = "center",
  },
  winbar = {
    enabled = true,
    name_formatter = function(term)
      return term.name
    end,
  },
}

function M.setup()
  -- Extend minimap.buf with general exclusions
  for _, v in ipairs(M.general.buf) do
    table.insert(M.minimap.buf, v)
    table.insert(M.highlights.exclude, v)
  end
  for _, v in ipairs(M.general.ft) do
    table.insert(M.minimap.ft, v)
  end
end

return M
