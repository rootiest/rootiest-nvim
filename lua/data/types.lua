---@module "M"
--- This module aggregates various types used throughout the configuration.
--- Plugin opts/config tables/functions are defined in this module.
--- Other general tables and lists are also defined here.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          TYPES                          │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Get color theme data ━━━━━━━━━━━━━━━━━━━━━
-- File path to the theme.txt file
local theme_file = vim.fn.expand('~/.config/wezterm/changer/theme.txt')

-- A variable to hold the colorscheme name
local colorscheme_name = 'catppuccin-mocha' -- Default to Mocha

-- Try to read the theme name from the file
local file = io.open(theme_file, 'r')
if file then
  local content = file:read('*a')
  file:close()
  if content then
    -- Trim leading/trailing whitespace and newlines from the string
    colorscheme_name = content:gsub('^%s*(.-)%s*$', '%1')
  end
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Mode Indicators ━━━━━━━━━━━━━━━━━━━━━━━━━━━
--- A collection of functions that return icons and names for
--- the current mode.
M.mode = {
  n = { -- Normal mode
    icon = '',
    name = 'NORMAL',
    color = 'Special',
  },
  no = { -- Operator-pending mode
    icon = '',
    name = 'NORMAL OPERATOR PENDING',
    color = 'Special',
  },
  nov = { -- Operator-pending (charwise) mode
    icon = '',
    name = 'NORMAL OP (CHARWISE)',
    color = 'Special',
  },
  nt = { -- Terminal-mode within Normal mode
    icon = '',
    name = 'NORMAL TERMINAL',
    color = 'Special',
  },
  i = { -- Insert mode
    icon = '',
    name = 'INSERT',
    color = 'Special',
  },
  ic = { -- Insert completion mode
    icon = '',
    name = 'INSERT COMPLETION',
    color = 'Special',
  },
  R = { -- Replace mode
    icon = '',
    name = 'REPLACE',
    color = 'Special',
  },
  Rv = { -- Virtual replace mode
    icon = '',
    name = 'REPLACE VIRT',
    color = 'Special',
  },
  v = { -- Visual mode
    icon = '󰸿',
    name = 'VISUAL',
    color = 'Special',
  },
  V = { -- Visual Line mode
    icon = '󰸽',
    name = 'VISUAL LINE',
    color = 'Special',
  },
  [''] = { -- Visual Block mode
    icon = '󰹀',
    name = 'VISUAL BLOCK',
    color = 'Special',
  },
  c = { -- Command mode
    icon = '󰑮',
    name = 'COMMAND',
    color = 'Special',
  },
  s = { -- Select mode
    icon = '',
    name = 'SELECT',
    color = 'Special',
  },
  S = { -- Select Line mode
    icon = '',
    name = 'SELECT LINE',
    color = 'Special',
  },
  t = { -- Terminal mode
    icon = '',
    name = 'INSERT TERMINAL',
    color = 'Special',
  },

  --- A collection of functions that return icons and names for
  --- the current mode.
  --- These use the tables defined above in `M.mode`.
  current = {
    --- Returns an icon representing the current mode
    --- Ex: ""
    ---@return string|function icon The current mode icon
    icon = function()
      local current_mode = vim.api.nvim_get_mode().mode
      -- Check if current_mode exists in full in M.mode
      if M.mode[current_mode] then
        return M.mode[current_mode].icon
      end
      -- Fallback to single-character mode if full mode isn't available
      local fallback_mode = current_mode:sub(1, 1)
      return M.mode[fallback_mode] and M.mode[fallback_mode].icon or ''
    end,

    --- Returns the name of the current mode
    --- Ex: "NORMAL"
    ---@return string|function name The current mode name
    name = function()
      local current_mode = vim.api.nvim_get_mode().mode
      -- Check if current_mode exists in full in M.mode
      if M.mode[current_mode] then
        return M.mode[current_mode].name
      end
      -- Fallback to single-character mode if full mode isn't available
      local fallback_mode = current_mode:sub(1, 1)
      return M.mode[fallback_mode] and M.mode[fallback_mode].name or 'UNKNOWN'
    end,

    --- Returns a string representing the current mode with icon and name
    --- Ex: " NORMAL"
    ---@return string|function icon_text The current mode icon and name
    icon_text = function()
      return M.mode.current.icon() .. ' ' .. M.mode.current.name()
    end,

    --- Returns a string representing the current mode with icon and name
    --- Ex: " NORMAL"
    ---@return string|function icon_text The current mode icon and name
    lualine = function()
      return M.mode.current.icon_text()
    end,
  },
}

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Border Styles ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--- Border configuration options
M.border = {
  round = function()
    return {
      { '╭', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '╮', 'FloatBorder' },
      { '│', 'FloatBorder' },
      { '╯', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '╰', 'FloatBorder' },
      { '│', 'FloatBorder' },
    }
  end,
  simple = function()
    return {
      { '─', 'FloatBorder' },
      { '│', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '│', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '│', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '│', 'FloatBorder' },
    }
  end,
}

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Cursor Styles ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
M.cursors = {
  smooth = '',
  block = '█',
  line = '⎸',
  underline = '_',
}

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Other Styles ━━━━━━━━━━━━━━━━━━━━━━━━━
M.script_glyphs = {
  superscript = {
    '⁰',
    '¹',
    '²',
    '³',
    '⁴',
    '⁵',
    '⁶',
    '⁷',
    '⁸',
    '⁹',
  },
  subscript = {
    '₀',
    '₁',
    '₂',
    '₃',
    '₄',
    '₅',
    '₆',
    '₇',
    '₈',
    '₉',
  },
}

M.roman_numerals = {
  'Ⅰ',
  'Ⅱ',
  'Ⅲ',
  'Ⅳ',
  'Ⅴ',
  'Ⅵ',
  'Ⅶ',
  'Ⅷ',
  'Ⅸ',
  'Ⅹ',
  'Ⅺ',
  'Ⅻ',
}
--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Type tables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- General exclusion list for buffers and filetypes
M.general = {
  -- Excluded buffer types
  buf = {
    'help',
    'alpha',
    'dashboard',
    'neo-tree',
    'Trouble',
    'trouble',
    'lazy',
    'mason',
    'notify',
    'toggleterm',
    'lazyterm',
  },
  -- excluded filetypes
  ft = {
    'help',
    'dashboard',
    'snacks_dashboard',
    'neorg',
  },
}

--- All-modes table for keymaps
M.all_modes = {
  'n',
  'i',
  'v',
  'x',
  's',
  'o',
  'c',
  't',
}

M.picker_sets = {
  pickers = {
    'fzf-lua',
    'telescope',
  },
  cpp_files = {
    'cpp',
    'c',
    'h',
    'hpp',
  },
  python_files = {
    'py',
    'pyw',
  },
  nvim_files = {
    'lua',
    'vim',
    'vimdoc',
  },
  vim_files = {
    'vim',
    'vimdoc',
  },
  java_files = {
    'java',
    'properties',
    'xml',
    'jar',
    'gradle',
    'yaml',
  },
  js_files = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
  },
  html_files = {
    'html',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
  },
  rust_files = {
    'rust',
    'toml',
    'rs',
    'rsx',
    'rsproj',
  },
}

--- Filetypes for Alternate plugin
M.alternate = {
  'cpp',
  'h',
  'hpp',
  'c',
}

--- Arrow config options
M.arrow = {
  show_icons = true,
  leader_key = ';', -- Recommended to be a single key
  buffer_leader_key = 'm', -- Per Buffer Mappings
}

M.avante = {
  provider = 'openai',
  auto_suggestions_provider = 'openai',
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = true,
    support_paste_from_clipboard = false,
  },
  hints = { enabled = false },
  highlights = {
    diff = {
      current = 'MiniDiffOverChange',
      incoming = 'MiniDiffOverAdd',
    },
  },
}

--- Bufferline configuration options
M.bufferline = {
  enabled = function()
    if
      require('data.func').check_global_var(
        'tabline',
        'bufferline',
        'bufferline'
      )
      or require('data.func').check_global_var(
        'tabline',
        'barsNlines',
        'bufferline'
      )
    then
      return true
    end
    return false
  end,
  opts = {
    options = {
      themable = true,
      color_icons = true,
      numbers = function(opts)
        local get_suffix = require('data.func').get_ordinal_suffix
        return get_suffix(opts.ordinal) .. '⦂'
      end,
      separator_style = 'slant',
      auto_toggle_bufferline = true,
      buffer_close_icon = '󱎘',
      modified_icon = ' ',
      close_icon = '󱎘',
      left_trunc_marker = ' ',
      right_trunc_marker = ' ',
      always_show_bufferline = false,
      show_close_icon = true,
      show_buffer_close_icon = true,
      diagnostics_indicator = function(_, _, diagnostics_dict, _)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local sym = e == 'error' and ' '
            or (e == 'warning' and ' ' or ' ')
          s = s .. sym .. n
        end
        return s
      end,
    },
  },
}

-- Code-Coompanion configuration options
M.codecompanion = {
  opts = {
    adapters = {
      openai = function()
        return require('codecompanion.adapters').extend('openai', {
          env = {
            api_key = 'cmd: echo $OPENAI_API_KEY',
          },
          schema = {
            model = {
              default = 'gpt-4o-mini',
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = 'openai',
      },
      inline = {
        adapter = 'copilot',
      },
    },
  },
}

--- CodeSnap configuration options
M.codesnap = {
  save_path = '~/Pictures/Screenshots/',
  has_breadcrumbs = true,
  show_workspace = true,
  bg_theme = 'default',
  watermark = 'Rootiest Snippets',
  code_font_family = 'Iosevka NF',
  code_font_size = 12,
}

M.neocord = {
  opts = {
    logo = 'https://raw.githubusercontent.com/rootiest/rootiest-nvim/b949af32e72db9fc35c18e14e2088710dc36dd15/logo/icon.png',
    main_image = 'logo',
    blacklist = { 'bin: No such file or directory' },
    file_assets = {},
  },
}

--- Flash configuration options
M.flash = {
  modes = { char = { jump_labels = true } },
}

M.floating_help = {
  opts = {
    width = 0.8, -- Whole numbers are columns/rows
    height = 0.9, -- Decimals are a percentage of the editor
    position = 'C', -- NW,N,NW,W,C,E,SW,S,SE (C==center)
    border = 'rounded', -- rounded,double,single
  },
  init = function()
    vim.g.floating_help = true
    -- Only replace cmds, not search; only replace the first instance
    --- Replace commands in the form of 'cabbr <abbrev> <expansion>'
    ---@param abbrev string The abbreviation to replace
    ---@param expansion string The expansion to replace it with
    local function cmd_abbrev(abbrev, expansion)
      local cmd = 'cabbr '
        .. abbrev
        .. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
        .. expansion
        .. '" : "'
        .. abbrev
        .. '")<CR>'
      vim.cmd(cmd)
    end
    -- Replace native help commands with floating help
    cmd_abbrev('h', 'FloatingHelp')
    cmd_abbrev('help', 'FloatingHelp')
    cmd_abbrev('helpc', 'FloatingHelpClose')
    cmd_abbrev('helpclose', 'FloatingHelpClose')
  end,
}

M.gx = {
  init = function()
    vim.g.netrw_nogx = 1
  end,
}

M.hardtime = {
  opts = function()
    return { enabled = vim.g.usehardtime }
  end,
}

M.imgclip = {
  opts = {
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
      -- required for Windows users
      use_absolute_path = true,
    },
  },
}

M.multicursor = {
  config = function()
    local mc = require('multicursor-nvim')

    mc.setup({
      -- set to true if you want multicursor undo history
      -- to clear when clearing cursors
      shallowUndo = false,

      -- set to empty table to disable signs
      signs = { '⎸', '󰇀', '⎹' },
    })
  end,
}

M.qalc = {
  opts = {
    bufname = 'qalc',
    set_ft = 'qalc',
    yank_default_register = '+',
    diagnostics = {
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = true,
      severity_sort = true,
    },
  },
}

M.showkeys = {
  opts = {
    timeout = 1,
    maxkeys = 5,
    -- more opts
  },
}

--- Smart-Scrolloff configuration options
M.smartscrolloff = { scrolloff_percentage = 0.25 }

--- AutoCursorline configuration options
M.autocursorline = { wait_ms = 2000 }

--- SmoothCursor
M.smoothcursor = {
  cursor = M.cursors.smooth,
}

--- Suda configuration options
M.suda = function()
  vim.g.suda_smart_edit = 1
  vim.cmd("let g:suda#prompt = '   Enter Sudo Password  '")
end

M.treesitter = {
  opts = function(opts)
    vim.api.nvim_create_augroup('EnvFileDiagnostics', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      group = 'EnvFileDiagnostics',
      pattern = { '*.env', '*.env.*' },
      callback = function()
        vim.diagnostic.enable(false)
      end,
    })
  end,
}

M.tokyonight = {
  opts = {
    style = 'night',
  },
}

--- Autosave configuration options
M.autosave = {}

--- DiffView configuration options
M.diffview = {
  opts = {
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
      },
    },
  },
}

--- Kulala plugin types
M.kulala = {
  ft = { 'http', 'https', 'ftp', 'ftps' },
}

--- LazyVim configuration options
M.lazyvim = {
  opts = {
    colorscheme = colorscheme_name,
    -- colorscheme = 'catppuccin-mocha',
    news = {
      lazyvim = true,
      neovim = true,
    },
  },
}

M.lazydev = {
  opts = {
    library = {
      { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      { path = 'LazyVim', words = { 'LazyVim' } },
      { path = 'snacks.nvim', words = { 'Snacks' } },
      { path = 'lazy.nvim', words = { 'LazyVim' } },
      -- Load the wezterm types when the `wezterm` module is required
      -- Needs `justinsgithub/wezterm-types` to be installed
      { path = 'wezterm-types', mods = { 'wezterm' } },
    },
  },
}

M.lazy = { -- Lazy.nvim
  disabled_plugins = {
    --"gzip",
    'netrwPlugin',
    --"tarPlugin",
    -- "tohtml",
    --"tutor",
    --"zipPlugin",
  },
}

--- Nvim-cmp excluded filetypes
M.cmp = {
  'dashboard',
  'qalc',
}

M.neotree = {
  opts = {
    default_component_configs = {
      git_status = {
        symbols = {
          untracked = '󱀶',
          ignored = '',
          unstaged = '󰄱',
          staged = '󰱒',
          conflict = '',
        },
      },
    },
  },
}

M.minifiles = {
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 80,
    },
    options = {
      -- Whether to use for editing directories
      -- Disabled by default in LazyVim because neo-tree is used for that
      use_as_default_explorer = false,
      -- Whether to permanently delete or use trash
      permanent_delete = false,
    },
  },
  config = function(_, opts)
    require('mini.files').setup(opts)

    local show_dotfiles = true
    local filter_show = function(_)
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require('mini.files').refresh({ content = { filter = new_filter } })
    end

    local map_split = function(buf_id, lhs, direction, close_on_file)
      local rhs = function()
        local new_target_window
        local cur_target_window = require('mini.files').get_target_window()
        if cur_target_window ~= nil then
          vim.api.nvim_win_call(cur_target_window, function()
            vim.cmd('belowright ' .. direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          require('mini.files').set_target_window(new_target_window)
          require('mini.files').go_in({ close_on_file = close_on_file })
        end
      end

      local desc = 'Open in ' .. direction .. ' split'
      if close_on_file then
        desc = desc .. ' and close'
      end
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    local files_set_cwd = function()
      ---@diagnostic disable-next-line: undefined-global
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      if cur_directory ~= nil then
        vim.fn.chdir(cur_directory)
      end
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set(
          'n',
          opts.mappings and opts.mappings.toggle_hidden or 'g.',
          toggle_dotfiles,
          { buffer = buf_id, desc = 'Toggle hidden files' }
        )

        vim.keymap.set(
          'n',
          opts.mappings and opts.mappings.change_cwd or 'gc',
          files_set_cwd,
          { buffer = args.data.buf_id, desc = 'Set cwd' }
        )

        map_split(
          buf_id,
          opts.mappings and opts.mappings.go_in_horizontal or '<C-w>s',
          'horizontal',
          false
        )
        map_split(
          buf_id,
          opts.mappings and opts.mappings.go_in_vertical or '<C-w>v',
          'vertical',
          false
        )
        map_split(
          buf_id,
          opts.mappings and opts.mappings.go_in_horizontal_plus or '<C-w>S',
          'horizontal',
          true
        )
        map_split(
          buf_id,
          opts.mappings and opts.mappings.go_in_vertical_plus or '<C-w>V',
          'vertical',
          true
        )
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        ---@diagnostic disable-next-line: undefined-field
        LazyVim.lsp.on_rename(event.data.from, event.data.to)
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })

    -- include git signs
    require('config.minifiles')
  end,
}

--- Git-Blame configuration options
M.gitblame = {
  opts = function()
    if vim.g.statusline == 'lualine' or vim.g.statusline == nil then
      -- Get the current lualine configuration
      local config = require('lualine').get_config() or {}
      local git_blame = require('gitblame')
      local funcs = require('data.func')
      -- Define the width limit for displaying the Git blame component
      local width_limit = 245 -- Adjust this value as needed
      -- Add Git-blame to lualine_c section
      table.insert(config.sections.lualine_c, {
        git_blame.get_current_blame_text,
        cond = function() -- Only show if text is available
          return git_blame.is_blame_text_available()
            and funcs.is_window_wide_enough(width_limit)
        end,
        color = {
          fg = require('snacks').util.color('GitSignsCurrentLineBlame'),
        },
        padding = { left = 1, right = 0 },
        on_click = function()
          if vim.g.statusline_clickable_git ~= false then
            Snacks.lazygit()
          end
        end,
      })
      -- Apply the lualine configuration
      require('lualine').setup(config)
    end
    -- Return the git-blame options
    return M.gitblame.style
  end,
  style = {
    display_virtual_text = 0, -- Disable virtual text
    date_format = '%r', -- Relative date format
    message_when_not_committed = '  Not yet committed',
    message_template = '<author> • <date> • <summary>',
  },
}

--- ChatGPT configuration options
M.chatgpt = {
  openai_params = {
    model = 'gpt-4o-mini',
  },
}

M.dirtytalk = {
  init = function()
    vim.cmd('set spelllang=en,programming')
  end,
}

-- GP ChatBot configuration options
M.gp = function()
  require('which-key').setup({
    triggers = '<C-g>',
    mode = M.all_modes,
  })
  return {
    hooks = {
      -- example of adding command which writes unit tests for the selected code
      UnitTests = function(gp, params)
        local template = 'I have the following code from {{filename}}:\n\n'
          .. '```{{filetype}}\n{{selection}}\n```\n\n'
          .. 'Please respond by writing table driven unit tests for the code above.'
        local agent = gp.get_command_agent()
        gp.Prompt(params, gp.Target.vnew, agent, template)
      end,
      -- example of adding command which explains the selected code
      Explain = function(gp, params)
        local template = 'I have the following code from {{filename}}:\n\n'
          .. '```{{filetype}}\n{{selection}}\n```\n\n'
          .. 'Please respond by explaining the code above.'
        local agent = gp.get_chat_agent()
        gp.Prompt(params, gp.Target.popup, agent, template)
      end,
      -- example of usig enew as a function specifying type for the new buffer
      CodeReview = function(gp, params)
        local template = 'I have the following code from {{filename}}:\n\n'
          .. '```{{filetype}}\n{{selection}}\n```\n\n'
          .. 'Please analyze for code smells and suggest improvements.'
        local agent = gp.get_chat_agent()
        gp.Prompt(params, gp.Target.enew('markdown'), agent, template)
      end,
      -- example of adding command which opens new chat dedicated for translation
      Translator = function(gp, params)
        local chat_system_prompt =
          'You are a Translator, please translate between English and Chinese.'
        gp.cmd.ChatNew(params, chat_system_prompt)
      end,
      -- example of making :%GpChatNew a dedicated command which
      -- opens new chat with the entire current buffer as a context
      BufferChatNew = function(gp, _)
        -- call GpChatNew command in range mode on whole buffer
        vim.api.nvim_command('%' .. gp.config.cmd_prefix .. 'ChatNew')
      end,
    },
  }
end

--- Telescope configuration options
M.telescope = {
  cmdline = {
    extensions = {
      cmdline = {
        icons = {
          history = ' ',
          command = ' ',
          number = '󰴍 ',
          system = '',
          unknown = '',
        },
        picker = {
          layout_config = {
            width = vim.fn.floor(vim.o.columns * 0.25),
            height = vim.fn.floor(vim.o.lines * 0.25),
          },
        },
        completions = {
          'command',
        },
        mappings = {
          complete = '<Tab>',
          run_selection = '<C-CR>',
          run_input = '<CR>',
        },
        overseer = {
          enabled = true,
        },
      },
    },
  },
}

--- Neocodeium configuration options
M.neocodeium = {
  opts = {
    manual = false,
    silent = true,
    debounce = false,
    filetypes = {
      TelescopePrompt = false,
      ['dap-repl'] = false,
    },
  },
}

--- Thanks configuration options
M.thanks = {
  opts = {
    star_on_install = false,
  },
}

--- Which-Key configuration options
M.whichkey = {
  opts = {
    preset = 'helix',
    win = {
      wo = {
        winblend = 10,
      },
      col = vim.fn.floor(vim.o.columns * 0.82),
      height = { min = 4, max = vim.fn.floor(vim.o.lines * 0.90) },
    },
    triggers = {
      { '<auto>', mode = { 'n', 'x' } },
      { '<leader>', mode = { 'n', 'v' } },
      { '<localleader>', mode = { 'n', 'v' } },
      { 's', mode = { 'n', 'x' } },
      { 'g', mode = { 'n', 'x' } },
    },
  },
}

--- Git-Graph plugin options
M.gitgraph = {
  opts = {
    -- GitGraph Hooks
    hooks = {
      -- Check diff of a commit
      on_select_commit = function(commit)
        vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
        vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
      end,
      -- Check diff from commit a -> commit b
      on_select_range_commit = function(from, to)
        vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
      end,
    },
    --- Git-graph symbols check for kitty
    symbols = function()
      if require('data.func').is_kitty() then
        return {
          merge_commit = '',
          commit = '',
          merge_commit_end = '',
          commit_end = '',

          -- Advanced symbols
          GVER = '',
          GHOR = '',
          GCLD = '',
          GCRD = '╭',
          GCLU = '',
          GCRU = '',
          GLRU = '',
          GLRD = '',
          GLUD = '',
          GRUD = '',
          GFORKU = '',
          GFORKD = '',
          GRUDCD = '',
          GRUDCU = '',
          GLUDCD = '',
          GLUDCU = '',
          GLRDCL = '',
          GLRDCR = '',
          GLRUCL = '',
          GLRUCR = '',
        }
      else
        -- Fallback
        return {
          merge_commit = '',
          commit = '',
          merge_commit_end = '',
          commit_end = '',
        }
      end
    end,
    format = {
      -- Git graph timestamp style
      timestamp = '%H:%M:%S %d-%m-%Y',
      -- Git graph fields to display
      fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
    },
  },
}

--- Highlights module options
M.highlights = {
  -- Excluded buffer types
  exclude = {
    -- +general.buf
  },
}

--- Indent characters
M.ibl = {
  char = {
    none = { ' ' },
    light_vert = { '' },
    scope = { '│' },
    fancy_vert = { '‖' },
    strong_vert = { '⦀' },
    zigzag = { '⦚' },
    basic = { '' },
    simple = { '' },
    arrow = { '' },
    tab = { '󰌒' },
    mini = { '' },
    light_arrow = { '⤑' },
    block = { '█' },
    block_75 = { '▓' },
    block_50 = { '▒' },
    block_25 = { '░' },
    block_0 = { ' ' },
    baric = { '󰇘' },
    fish = { '⤕' },
    dot = { '⋅' },
    dots = { '⋯' },
    circle = { '' },
    dot_circle = { '󱥸' },
    dot_square = { '󱗽' },
    dot_hex = { '󱗿' },
    dot_tri = { '󱗾' },
    dot_grid = { '󱗼' },
    solid = {
      '▏',
      '▎',
      '▍',
      '▌',
      '▋',
      '▊',
      '▉',
      '█',
    },
    fancy = {
      '󰎤',
      '󰎧',
      '󰎪',
      '󰎭',
      '󰎱',
      '󰎳',
      '󰎶',
      '󰎹',
      '󰎼',
      '󰽽',
    },
    funky = {
      '󰌒',
      '󰌓',
      '󰌔',
      '󰌕',
      '󰌖',
      '󰌗',
      '󰌘',
      '󰌙',
      '󰌚',
      '󰌛',
    },
  },
}

M.miniicons = {
  opts = {
    file = {
      ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
      ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    },
    filetype = {
      dotenv = { glyph = '', hl = 'MiniIconsYellow' },
    },
  },
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}

--- Mini.Indentscope configuration options
M.miniindentscope = {
  opts = {
    options = { try_as_border = true, border = 'both' },
  },
  init = function()
    -- Set default scope char
    local scope_char
    if vim.g.scope_char then
      scope_char = vim.g.scope_char
    elseif vim.g.scope_char_name then
      scope_char = M.ibl.char[vim.g.scope_char_name][1]
    else
      scope_char = M.ibl.char.scope[1]
    end
    M.miniindentscope.opts.symbol = scope_char
  end,
}

--- Navic Icons
M.navic = {
  icons = {
    classic = {
      File = '󰈙 ',
      Module = ' ',
      Namespace = '󰌗 ',
      Package = ' ',
      Class = '󰌗 ',
      Method = '󰆧 ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = '󰕘',
      Interface = '󰕘',
      Function = '󰊕 ',
      Variable = '󰆧 ',
      Constant = '󰏿 ',
      String = '󰀬 ',
      Number = '󰎠 ',
      Boolean = '◩ ',
      Array = '󰅪 ',
      Object = '󰅩 ',
      Key = '󰌋 ',
      Null = '󰟢 ',
      EnumMember = ' ',
      Struct = '󰌗 ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = '󰊄 ',
    },
    trouble = {
      File = ' ',
      Module = ' ',
      Namespace = ' ',
      Package = ' ',
      Class = ' ',
      Method = ' ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = ' ',
      Interface = ' ',
      Function = ' ',
      Variable = ' ',
      Constant = ' ',
      String = ' ',
      Number = ' ',
      Boolean = ' ',
      Array = ' ',
      Object = ' ',
      Key = ' ',
      Null = ' ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },
    vscode = {
      File = ' ',
      Module = ' ',
      Namespace = ' ',
      Package = ' ',
      Class = ' ',
      Method = ' ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = ' ',
      Interface = ' ',
      Function = ' ',
      Variable = ' ',
      Constant = ' ',
      String = ' ',
      Number = ' ',
      Boolean = ' ',
      Array = ' ',
      Object = ' ',
      Key = ' ',
      Null = ' ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },
  },
}

--- Smart-Splits plugin options
M.smart_splits = {
  --- Function to check if kitty is running
  --- and install Smart-Splits kittens if it is.
  build = function()
    if require('data.func').is_kitty() then
      return './kitty/install-kittens.bash'
    else
      return false
    end
  end,
}

--  ───────────────────────────── NeoMiniMap ──────────────────────────
local extmark_handler = {
  name = 'Todo Comment',
  mode = 'icon',
  namespace = vim.api.nvim_create_namespace('neominimap_todo_comment'),
  init = function() end,
  autocmds = {
    {
      event = { 'TextChanged', 'TextChangedI' },
      opts = {
        callback = function(apply, args)
          local bufnr = tonumber(args.buf) ---@cast bufnr integer
          vim.schedule(function()
            apply(bufnr)
          end)
        end,
      },
    },
    {
      event = 'WinScrolled',
      opts = {
        callback = function(apply)
          local winid = vim.api.nvim_get_current_win()
          if not winid or not vim.api.nvim_win_is_valid(winid) then
            return
          end
          local bufnr = vim.api.nvim_win_get_buf(winid)
          vim.schedule(function()
            if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
              apply(bufnr)
            end
          end)
        end,
      },
    },
  },
  get_annotations = function(bufnr)
    local ok, _ = pcall(require, 'todo-comments')
    if not ok then
      return {}
    end
    local ns_id = vim.api.nvim_get_namespaces()['todo-comments']
    local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {
      details = true,
    })
    local icons = {
      FIX = ' ',
      TODO = ' ',
      HACK = ' ',
      WARN = ' ',
      PERF = ' ',
      NOTE = ' ',
      TEST = '⏲ ',
    }
    local id =
      { FIX = 1, TODO = 2, HACK = 3, WARN = 4, PERF = 5, NOTE = 6, TEST = 7 }
    return vim.tbl_map(function(extmark)
      local detail = extmark[4] ---@type vim.api.keyset.extmark_details
      local group = detail.hl_group ---@type string
      local kind = string.sub(group, 7)
      local icon = icons[kind]
      return {
        lnum = extmark[2],
        end_lnum = extmark[2],
        id = id[kind],
        highlight = 'TodoFg' .. kind, --- You can customize the highlight here.
        icon = icon,
        priority = detail.priority,
      }
    end, extmarks)
  end,
}

--- Neominiap plugin options
M.minimap = {
  -- Width of minimap
  width = 20,
  -- excluded buffer types
  buf = {
    'nofile',
    'nowrite',
    'quickfix',
    'terminal',
    'prompt',
    'alpha',
    'dashboard',
    'qalc',
    -- +general.buf
  },
  -- excluded filetypes
  ft = {
    'help',
    'dashboard',
    'neorg',
    'qalc',
  },

  --- Function to initialize or manipulate minimap settings
  init = function()
    M.setup()
    vim.g.neominimap = {
      auto_enable = true,
      layout = 'float',
      exclude_filetypes = M.minimap.ft,
      exclude_buftypes = M.minimap.buf,
      x_multiplier = 4,
      y_multiplier = 1,
      click = {
        enabled = true,
      },
      diagnostic = {
        mode = 'icon',
        icon = {
          ERROR = '󰅚 ',
          WARN = '󰀪 ',
          INFO = '󰌶 ',
          HINT = ' ',
        },
      },
      git = {
        enabled = true,
        mode = 'sign',
        priority = 6,
        icon = {
          add = '󰐖 ',
          change = '󰏬 ',
          delete = '󰍵 ',
        },
      },
      search = {
        enabled = true,
        mode = 'icon',
        icon = '󱋞 ',
      },
      treesitter = {
        enabled = true,
        priority = 200,
      },
      mark = {
        enabled = true,
        mode = 'icon',
        priority = 10,
        key = 'm',
        show_builtins = true,
      },
      split = {
        minimap_width = M.minimap.width,
        fix_width = false,
      },
      float = {
        window_border = 'none',
        minimap_width = M.minimap.width,
      },
      handlers = {
        extmark_handler,
      },
    }
  end,

  --- Function to check if minimap should be enabled
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

--- Llama Copilot plugin options
M.llama_copilot = {
  host = 'localhost',
  port = '11434',
  model = 'codellama:7b-code',
  max_completion_size = 15, -- use -1 for limitless
  debug = false,
}

--- Plugin reloader function options
M.plugin_reloader = {
  exclusion_list = { -- Define the exclusion list
    -- stylua: ignore start
    ["lazy.nvim"]      = true,
    ["noice.nvim"]     = true,
    ["unception.nvim"] = true,
    ["nvim-unception"] = true,
    ["nui.nvim"]       = true,
    ["nui"]            = true,
    ["packer.nvim"]    = true,
    ["packer"]         = true,
    ["trouble.nvim"]   = true,
    ["trouble"]        = true,
    ["which-key.nvim"] = true,
    ["which-key"]      = true,
    -- stylua: ignore end
    -- Add any other plugins you want to exclude here
  },
}

M.trouble = {
  opts = {
    modes = {
      symbols = { -- Configure symbols mode
        focus = true,
        win = {
          type = 'split', -- split window
          relative = 'win', -- relative to current window
          position = 'right', -- right side
          size = 0.3, -- 30% of the window
        },
      },
    },
    icons = {
      indent = {
        top = ' ',
        -- middle = "├╴",
        middle = '',
        -- last = "└╴",
        -- last = "-╴",
        last = '╰╴',
        fold_open = ' ',
        fold_closed = ' ',
        ws = '  ',
      },
      folder_closed = ' ',
      folder_open = ' ',
      kinds = M.navic.icons.vscode,
    },
  },
}

--- Function to set up bars-n-lines plugin options
M.barsNlines = {
  enabled = function()
    if
      require('data.func').check_global_var(
        'statuscolumn',
        'barsNlines',
        'native'
      )
      or require('data.func').check_global_var(
        'tabline',
        'barsNlines',
        'bufferline'
      )
      or require('data.func').check_global_var(
        'statusline',
        'barsNlines',
        'lualine'
      )
    then
      return true
    end
    return false
  end,
  config = function()
    require('bars').setup({
      exclude_filetypes = M.minimap.ft,
      exclude_buftypes = M.minimap.buf,
      statuscolumn = {
        enable = require('data.func').check_global_var(
          'statuscolumn',
          'barsNlines',
          'native'
        ),
        parts = {
          {
            type = 'fold',
            markers = {
              default = {
                content = { '  ' },
              },
              open = {
                { ' ', 'BarsStatuscolumnFold1' },
              },
              close = {
                { '╴', 'BarsStatuscolumnFold1' },
              },
              scope = {
                { ' ', 'BarsStatuscolumnFold1' },
              },
              divider = {
                { '╴', 'BarsStatuscolumnFold1' },
              },
              foldend = {
                { '╼', 'BarsStatuscolumnFold1' },
              },
            },
          },
          {
            type = 'number',
            mode = 'hybrid',
            hl = 'LineNr',
            lnum_hl = 'BarsStatusColumnNum',
            relnum_hl = 'LineNr',
            virtnum_hl = 'TablineSel',
            wrap_hl = 'TablineSel',
          },
        },
      },
      tabline = {
        enable = require('data.func').check_global_var(
          'tabline',
          'barsNlines',
          'bufferline'
        ),
        parts = {
          {
            -- Part name
            type = 'bufs',

            -- Active buffer configuration
            active = {
              corner_left = { '', 'BarsTablineBufActiveSep' },
              corner_right = { '', 'BarsTablineBufActiveSep' },

              padding_left = { ' ', 'BarsTablineBufActive' },
              padding_right = { ' ' },
            },

            -- Inactive buffer configuration
            inactive = {
              corner_left = { '', 'BarsTablineBufInactiveSep' },
              corner_right = { '', 'BarsTablineBufInactiveSep' },

              padding_left = { ' ', 'BarsTablineBufInactive' },
              padding_right = { ' ' },
            },

            -- List of patterns to ignore
            ignore = {},
          },
        },
      },
      statusline = {
        enable = require('data.func').check_global_var(
          'statusline',
          'barsNlines',
          'lualine'
        ),
      },
    })
  end,
}

M.duck = function()
  local add_km = require('data.func').add_keymap
  add_km({
    lhs = '<leader>uD',
    group = 'Duck',
    icon = { icon = '󰇥', color = 'yellow' },
  })
  add_km({
    '<leader>uDd',
    function()
      require('duck').hatch()
    end,
    desc = 'Hatch',
  })
  add_km({
    '<leader>uDk',
    function()
      require('duck').cook()
    end,
    desc = 'Cook',
  })
  add_km({
    '<leader>uDa',
    function()
      require('duck').cook_all()
    end,
    desc = 'Cook All',
  })
end

--- Function to setup Pigeon plugin options
M.pigeon = function()
  local platform = require('data.func').get_os('platform')
  local lazy_installed = pcall(require, 'lazy')
  local packer_installed = pcall(require, 'packer_plugins')
  local pigeon_enabled = true -- default
  local plugman = 'lazy' -- default package manager
  if lazy_installed then
    plugman = 'lazy'
  elseif packer_installed then
    plugman = 'packer'
  elseif vim.fn.exists('g:plugs') == 1 then
    plugman = 'vim-plug'
  else
    require('data.func').notify(
      'Failed to detect package manager.\nPigeon disabled.',
      'ERROR'
    )
    pigeon_enabled = false
    return
  end
  local config = {
    enabled = pigeon_enabled,
    os = platform,
    plugin_manager = plugman,
    callbacks = {
      killing_pigeon = nil,
      respawning_pigeon = nil,
    },
    -- more config options here
  }

  require('pigeon').setup(config)
end

--- Substitute plugin options
M.substitute = {
  yank_substituted_text = false,
  preserve_cursor_position = true,
  on_substitute = function()
    require('yanky.integration').substitute()
  end,
}

M.undotree = function()
  -- Layout
  vim.g.undotree_ShortIndicators = 0
  vim.g.undotree_SplitWidth = 32
  -- Set focus to the tree when it's toggled
  vim.g.undotree_SetFocusWhenToggle = 1
  -- Set up tree shape
  vim.g.undotree_TreeNodeShape = ''
  vim.g.undotree_TreeVertShape = ''
  vim.g.undotree_TreeSplitShape = ''
  vim.g.undotree_TreeReturnShape = ''
  -- Hide helpline
  vim.g.undotree_HelpLine = 0
  -- Hide diff panel
  vim.g.undotree_DiffAutoOpen = 0
end

M.yanky = {
  ring = {
    history_length = 200,
    -- storage = 'sqlite',
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  preserve_cursor_position = {
    enabled = true,
  },
  textobj = {
    enabled = true,
  },
}

M.comment = {
  opleader = {
    line = 'gC',
  },
}

M.mason_lsp_config = { opts = {
  automatic_installation = true,
} }

--- Hightlight-colors plugin options
M.hightlight_colors = {
  render = 'virtual',
  virtual_symbol = '',
  virtual_symbol_prefix = '',
  virtual_symbol_suffix = '',
  virtual_symbol_position = 'inline',
  ---Highlight hex colors, e.g. '#FFFFFF' more text
  enable_hex = true,
  ---Highlight short hex colors e.g. '#fff more text'
  enable_short_hex = true,
  ---Highlight rgb colors, e.g. 'rgb(0 0 0) more text'
  enable_rgb = true,
  ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%) more text'
  enable_hsl = true,
  ---Highlight CSS variables, e.g. 'var(--testing-color) more text'
  enable_var_usage = true,
  ---Highlight named colors, e.g. 'green more text'
  enable_named_colors = true,
  ---Highlight tailwind colors, e.g. 'bg-blue-500 more text'
  enable_tailwind = true,
  exclude_filetypes = { 'lazy', 'lazygit' },
  exclude_buftypes = {},
}

--- Catppuccin options
M.catppuccin = {
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  -- color_overrides = { -- OLED black background
  --   mocha = {
  --     base = '#000000',
  --     mantle = '#000000',
  --     crust = '#000000',
  --   },
  -- },
  transparent_background = false,
  integrations = {
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
        ok = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
        ok = { 'underline' },
      },
      inlay_hints = {
        background = true,
      },
    },
    dadbod_ui = true,
    indent_blankline = {
      enabled = true,
      scope_color = 'mauve',
      colored_indent_levels = true,
    },
    grug_far = true,
    mason = true,
    markview = true,
    mini = {
      enabled = true,
      indentscope_color = 'mauve',
    },
    neotree = true,
    noice = true,
    notify = true,
    nvim_surround = true,
    octo = true,
    overseer = true,
    rainbow_delimiters = true,
    snacks = true,
    which_key = true,
    diffview = true,
    flash = true,
    fzf = true,
    ts_rainbow2 = true,
    ts_rainbow = true,
    lsp_trouble = true,
  },
}

--- Auto Dark Mode plugin options
M.auto_dark_mode = {
  update_interval = 2000,
  --- Function that runs when dark mode is enabled
  set_dark_mode = function()
    vim.o.background = 'dark'
    vim.cmd.colorscheme(
      require('astral').colortheme or 'catppuccin-mocha' or 'tokyonight'
    )
  end,
  --- Function that runs when light mode is enabled
  set_light_mode = function()
    vim.o.background = 'light'
    vim.cmd.colorscheme(
      require('astral').colortheme or 'catppuccin-latte' or 'tokyonight-day'
    )
  end,
}

M.illuminate = {
  opts = {
    providers = {
      -- Disable LSP proovider due to deprecation warnings
      -- 'lsp',
      'treesitter',
      'regex',
    },
  },
}

--- Image.nvim enabled filetypes
M.image = 'markdown'

--- Noice configuration options
M.noice = {
  presets = {
    inc_rename = true,
  },
  routes = {
    {
      filter = {
        find = 'position_encoding param is required',
      },
      opts = { skip = true },
    },
  },
  lsp = {
    progress = {
      enabled = false,
    },
  },
}

M.grug_far = {
  opts = {
    showCompactInputs = true,
    showInputsTopPadding = false,
    showInputsBottomPadding = false,
    helpLine = {
      enabled = false,
    },
    enabledEngines = { 'ripgrep', 'astgrep' },
    engines = {
      astgrep = {
        path = 'ast-grep',
        placeholders = {
          enabled = false,
        },
      },
      ripgrep = {
        placeholders = {
          enabled = false,
        },
      },
      ['astgrep-rules'] = {
        path = 'ast-grep',
      },
    },
    engine = 'ripgrep',
  },
}

--- Smear Cursor
M.smearcursor = function()
  local bg = require('data.func').get_bg_color('Normal') or '#1d1d2d'
  local fg = require('data.func').get_fg_color('Normal') or '#f7e0dc'

  return {
    -- Cursor color. Defaults to Normal gui foreground color
    cursor_color = fg,

    -- Background color. Defaults to Normal gui background color
    normal_bg = bg,

    -- Smear cursor when switching buffers
    smear_between_buffers = true,

    scroll_buffer_space = false,

    -- Smear cursor when moving within line or to neighbor lines
    smear_between_neighbor_lines = false,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = true,
    transparent_bg_fallback_color = bg,

    -- How fast the smear's head moves towards the target.
    -- 0: no movement, 1: instantaneous, default: 0.6
    stiffness = 0.6,

    -- How fast the smear's tail moves towards the head.
    -- 0: no movement, 1: instantaneous, default: 0.3
    trailing_stiffness = 0.2,

    -- How much the tail slows down when getting close to the head.
    -- 0: no slowdown, more: more slowdown, default: 0.1
    trailing_exponent = 0.1,

    -- Stop animating when the smear's tail is within this distance (in characters) from the target.
    -- Default: 0.1
    distance_stop_animating = 0.25,

    -- Attempt to hide the real cursor when smearing.
    hide_target_hack = true,
  }
end

M.symbols = {
  config = function()
    local r = require('symbols.recipes')
    require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, {
      sidebar = {
        auto_peek = false,
        show_guide_lines = true,
        chars = {
          folded = '',
          unfolded = '',
          guide_vert = '',
          guide_middle_item = '',
          guide_last_item = '',
        },
        preview = {
          show_always = true,
        },
      },
    })
  end,
}

-- Tiny Inline Diagnostic config
M.tiny_inline_diagnostic = {
  config = function()
    require('tiny-inline-diagnostic').setup({
      -- Style preset for diagnostic messages
      -- Available options:
      -- "modern", "classic", "minimal", "powerline",
      -- "ghost", "simple", "nonerdfont", "amongus"
      preset = 'modern',
      options = {
        overflow = {
          -- Trigger wrapping to occur this many characters earlier when mode == "wrap".
          -- Increase this value appropriately if you notice that the last few characters
          -- of wrapped diagnostics are sometimes obscured.
          padding = 20,
        },
      },
    })
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function()
        vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
      end,
    })
  end,
}
--- Todo-comments plugin options
M.todo = {
  opts = {
    keywords = {
      FIX = {
        icon = ' ', -- icon used for the sign, and in search results
        color = 'error', -- can be a hex color, or a named color
        alt = { -- a set of other keywords that all map to this FIX keywords
          'FIXME',
          'BUG',
          'FIXIT',
          'ISSUE',
        },
      },
      TODO = { icon = ' ', color = 'info' },
      HACK = { icon = ' ', color = 'warning' },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      BUST = {
        icon = '󰇷 ',
        color = 'broken',
        alt = { 'BROKEN', 'UNAVAILABLE', 'POOP' },
      },
      JUNK = {
        icon = ' ',
        color = 'trash',
        alt = { 'TRASH', 'WASTE', 'DUMP', 'GARBAGE' },
      },
      TEST = {
        icon = ' ',
        color = 'test',
        alt = { 'TESTING', 'PASSED', 'FAILED' },
      },
    },
    colors = {
      error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
      warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
      info = { 'DiagnosticInfo', '#2563EB' },
      hint = { 'DiagnosticHint', '#10B981' },
      default = { 'Identifier', '#7C3AED' },
      test = { 'Identifier', '#FF00FF' },
      broken = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
      trash = { 'DiagnosticUnnecessary', 'Comment', '#DC2626' },
    },
    search = {
      command = 'rg',
      args = {
        '--no-messages',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      },
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    },
  },
  lualine = function()
    local config = {
      -- The todo-comments types to show & in what order:
      order = {
        'TODO',
        'FIX',
        'WARN',
        'BUST',
        'JUNK',
      },
      keywords = M.todo.opts.keywords,
      when_empty = '',
    }
    return config
  end,
}

--- Colorful Window Separators plugin options
M.colorful_winsep = {
  symbols = { '─', '│', '╭', '╮', '╰', '╯' },
  no_exec_files = {
    'packer',
    'TelescopePrompt',
    'mason',
    'CompetiTest',
    'NvimTree',
    'neotree',
    'lazy',
    'neominimap',
  },
}

--- Colorful Window Separators configuration options
M.winsep = {
  only_line_seq = false,
  symbols = M.colorful_winsep.symbols,
  no_exec_files = M.colorful_winsep.no_exec_files,
}

---@alias Mode "n" | "i" | "?"

--- @class TerminalState
--- @field mode Mode

--- @class Terminal
--- @field newline_chr string
--- @field cmd string
--- @field direction string the layout style for the terminal
--- @field id number
--- @field bufnr number
--- @field window number
--- @field job_id number
--- @field highlights table<string, table<string, string>>
--- @field dir string the directory for the terminal
--- @field name string the name of the terminal
--- @field count number the count that triggers that specific terminal
--- @field hidden boolean whether or not to include this terminal in the terminals list
--- @field close_on_exit boolean? whether or not to close the terminal window when the process exits
--- @field auto_scroll boolean? whether or not to scroll down on terminal output
--- @field float_opts table<string, any>?
--- @field display_name string?
--- @field env table<string, string> environmental variables passed to jobstart()
--- @field clear_env boolean use clean job environment, passed to jobstart()
--- @field on_stdout fun(t: Terminal, job: number, data: string[]?, name: string?)?
--- @field on_stderr fun(t: Terminal, job: number, data: string[], name: string)?
--- @field on_exit fun(t: Terminal, job: number, exit_code: number?, name: string?)?
--- @field on_create fun(term:Terminal)?
--- @field on_open fun(term:Terminal)?
--- @field on_close fun(term:Terminal)?
--- @field _display_name fun(term: Terminal): string
--- @field __state TerminalState

--- Toggleterm plugin options
M.toggleterm = {
  --- Sets the terminal panel size
  ---@param term Terminal The terminal object
  ---@return number|nil The terminal size
  size = function(term)
    if term.direction == 'horizontal' then
      return 10
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  --- Function that runs when terminal is opened
  ---@param term Terminal The ToggleTerm terminal object
  on_open = function(term)
    vim.wo[term.window].foldmethod = 'manual'
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
  direction = 'horizontal',
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved',
    winblend = 3,
    title_pos = 'center',
  },
  winbar = {
    enabled = true,
    --- Function that formats the name of the terminal
    ---@param term table The terminal object
    ---@return string The formatted name
    name_formatter = function(term)
      return term.name
    end,
  },
}

M.ts = { disabled_highlights = { 'text' } }

local no_highlight = M.ts.disabled_highlights

M.treesitter = {
  opts = {
    highlight = {
      disable = function(lang, buf)
        if vim.tbl_contains(no_highlight, lang) then
          return true
        end
        local max_filesize = 1000 * 1024 -- 1 MB
        ---@diagnostic disable-next-line undefined-field
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    matchup = {
      enable = true, -- mandatory, false will disable the whole extension
      disable = { 'c', 'ruby' }, -- optional, list of language that will be disabled
      -- [options]
    },
    auto_install = true,
    ensure_installed = {
      'bash',
      'c',
      'css',
      'diff',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'latex',
      'lua',
      'luadoc',
      'luap',
      'markdown',
      'markdown_inline',
      'printf',
      'python',
      'query',
      'regex',
      'ssh_config',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    },
  },
}

M.twilight = {
  dimming = {
    alpha = 0.25, -- amount of dimming
    -- we try to get the foreground from the highlight groups or fallback color
    color = { 'Normal', '#cdd6f4' },
    term_bg = '#1e1e2e', -- if guibg=NONE, this will be used to calculate text color
    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
}

M.zen = {
  window = {
    backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 0.9, -- width of the Zen window
    height = 1, -- height of the Zen window
    options = {
      signcolumn = 'no', -- disable signcolumn
      -- number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = '0', -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
      -- you may turn on/off statusline in zen mode by setting 'laststatus'
      -- statusline will be shown only if 'laststatus' == 3
      laststatus = 0, -- turn off the statusline in zen mode
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
    kitty = {
      enabled = require('data.func').is_kitty(),
      font = '+1', -- font size increment
    },
    alacritty = {
      enabled = require('data.func').is_alacritty(),
      font = '14', -- font size
    },
    wezterm = {
      enabled = require('data.func').is_wezterm(),
      -- can be either an absolute font size or the number of incremental steps
      font = '+2', -- (10% increase per step)
    },
    neovide = {
      enabled = require('data.func').is_neovide(),
      -- Will multiply the current scale factor by this number
      scale = 1.2,
      -- disable the Neovide animations while in Zen mode
      disable_animations = false,
      -- disable_animations = {
      --   neovide_animation_length = 0,
      --   neovide_cursor_animate_command_line = false,
      --   neovide_scroll_animation_length = 0,
      --   neovide_position_animation_length = 0,
      --   neovide_cursor_animation_length = 0,
      --   neovide_cursor_vfx_mode = '',
      -- },
    },
  },
}

--- Function to extend minimap.buf with general exclusions
---@private
---@return nil
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
