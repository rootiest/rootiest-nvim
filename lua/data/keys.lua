---@module "data.keys"
--- This module contains the keymaps for the plugins and commands.
--- Keymaps use the add_keymap function from data.func for flexible
--- keybinding functionality.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        KEYS DATA                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Load utils
local rootiest = require('config.rootiest')

M.alternate = {
  { -- Toggle Alternate
    '<leader>A',
    '<cmd>Alternate<cr>',
    desc = 'Toggle Alternate',
  },
}

M.autosave = function()
  local group = vim.api.nvim_create_augroup('autosave', {})

  vim.api.nvim_create_autocmd('User', {
    pattern = 'AutoSaveEnable',
    group = group,
    callback = function()
      vim.g.auto_save_enabled = true
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'AutoSaveDisable',
    group = group,
    callback = function()
      vim.g.auto_save_enabled = false
    end,
  })

  require('snacks.toggle')
    .new({
      id = 'autosave',
      name = 'Auto-Write',
      get = function()
        return vim.g.auto_save_enabled
      end,
      set = function()
        require('auto-save').toggle()
      end,
    })
    :map('<leader>uW')
end

M.blink = function()
  require('snacks.toggle')
    .new({
      name = 'Completion',
      which_key = true,
      get = function()
        if vim.g.cmp_auto_show == false then
          return false
        end
        return true
      end,

      set = function(state)
        if state then
          vim.g.cmp_auto_show = true
        else
          vim.g.cmp_auto_show = false
        end
      end,
    })
    :map('<leader>uB')
end

M.capsword = {
  {
    '<C-s>',
    function()
      require('caps-word').toggle()
    end,
    desc = 'Toggle CapsWord',
    mode = { 'i', 'n' },
  },
}

M.chatgpt = {
  func = function()
    -- Add ChatGPT menu
    require('data.func').add_keymap(M.group.chatgpt)
    -- Add ChatGPT keys
    return M.chatgpt.keys
  end,
  keys = {
    {
      '<leader>cxc',
      '<cmd>ChatGPT<cr>',
      desc = 'ChatGPT',
    },
    {
      '<leader>cxe',
      '<cmd>ChatGPTEditWithInstruction<cr>',
      desc = 'Edit with instruction',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxg',
      '<cmd>ChatGPTRun grammar_correction<cr>',
      desc = 'Grammar Correction',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxt',
      '<cmd>ChatGPTRun translate<cr>',
      desc = 'Translate',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxk',
      '<cmd>ChatGPTRun keywords<cr>',
      desc = 'Keywords',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxd',
      '<cmd>ChatGPTRun docstring<cr>',
      desc = 'Docstring',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxa',
      '<cmd>ChatGPTRun add_tests<cr>',
      desc = 'Add Tests',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxo',
      '<cmd>ChatGPTRun optimize_code<cr>',
      desc = 'Optimize Code',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxs',
      '<cmd>ChatGPTRun summarize<cr>',
      desc = 'Summarize',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxf',
      '<cmd>ChatGPTRun fix_bugs<cr>',
      desc = 'Fix Bugs',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxr',
      '<cmd>ChatGPTRun explain_code<cr>',
      desc = 'Explain Code',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxr',
      '<cmd>ChatGPTRun roxygen_edit<cr>',
      desc = 'Roxygen Edit',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cxl',
      '<cmd>ChatGPTRun code_readability_analysis<cr>',
      desc = 'Code Readability Analysis',
      mode = { 'n', 'v' },
    },
  },
}

M.codesnap = {
  { -- Save selected code snapshot into clipboard
    '<leader>cy',
    '<cmd>CodeSnap<cr>',
    desc = 'Save selected code snapshot into clipboard',
    mode = 'x',
  },
  { -- Save selected code snapshot in ~/Pictures
    '<leader>cs',
    '<cmd>CodeSnapSave<cr>',
    desc = 'Save selected code snapshot in ~/Pictures',
    mode = 'x',
  },
  { -- Highlight and snapshot selected code into clipboard
    '<leader>ch',
    '<cmd>CodeSnapHighlight<cr>',
    desc = 'Highlight and snapshot selected code into clipboard',
    mode = 'x',
  },
  { -- Save ASCII code snapshot into clipboard
    '<leader>ci',
    '<cmd>CodeSnapASCII<cr>',
    desc = 'Save ASCII code snapshot into clipboard',
    mode = 'x',
  },
}

M.easyalign = {
  { -- EasyAlign
    '<leader>g\\',
    '<Plug>(EasyAlign)',
    desc = 'EasyAlign',
    mode = { 'n', 'x' },
  },
}

M.cipher = {
  base64 = {
    {
      lhs = 'g?',
      rhs = function()
        require('data.func').base64_encode_text()
      end,
      desc = 'Base64 Encode',
      mode = 'n',
    },
    {
      lhs = 'g?',
      rhs = function()
        require('data.func').base64_encode_visual()
      end,
      desc = 'Base64 Encode',
      mode = 'v',
    },
    {
      lhs = 'g/',
      rhs = function()
        require('data.func').base64_decode_text()
      end,
      desc = 'Base64 Decode',
      mode = 'n',
    },
    {
      lhs = 'g/',
      rhs = function()
        require('data.func').base64_decode_visual()
      end,
      desc = 'Base64 Decode',
      mode = 'v',
    },
  },
  hex = {
    {
      lhs = 'g?',
      rhs = function()
        require('data.func').hex_encode_text()
      end,
      desc = 'Hex Encode',
      mode = 'n',
    },
    {
      lhs = 'g?',
      rhs = function()
        require('data.func').hex_encode_visual()
      end,
      desc = 'Hex Encode',
      mode = 'v',
    },
    {
      lhs = 'g/',
      rhs = function()
        require('data.func').hex_decode_text()
      end,
      desc = 'Hex Decode',
      mode = 'n',
    },
    {
      lhs = 'g/',
      rhs = function()
        require('data.func').hex_decode_visual()
      end,
      desc = 'Hex Decode',
      mode = 'v',
    },
  },
  rot47 = {
    {
      lhs = 'g?',
      rhs = function()
        require('data.func').rot47_text()
      end,
      desc = 'ROT47 Encode',
      mode = 'n',
    },
    {
      lhs = 'g?',
      rhs = function()
        require('data.func').rot47_visual()
      end,
      desc = 'ROT47 Encode',
      mode = 'v',
    },
  },
}

M.cmd_mode = function()
  if not require('data.func').is_installed('which_key', { load = true }) then
    -- Disable the original `q:` mapping
    vim.keymap.set('n', 'q:', '<Nop>', { noremap = true, silent = true })

    -- Remap `q:` functionality to `<Leader>q:`
    vim.keymap.set(
      'n',
      '<Leader>q:',
      'q:',
      { noremap = true, silent = false, desc = 'Command Mode' }
    )
  else
    -- Disable the original `q:` mapping and hide it from which-key
    require('which-key').add({
      lhs = 'q:',
      rhs = '<Nop>',
      mode = 'n',
      hidden = true,
      noremap = true,
      silent = true,
    })

    -- Remap `q:` functionality to `<Leader>q:`
    require('which-key').add({
      lhs = '<Leader>q:',
      rhs = 'q:',
      mode = 'n',
      noremap = true,
      silent = false,
      desc = 'Command Mode',
    })
  end
end

M.cpp_picker = {
  { -- Cpp Picker
    '<leader>fC',
    function()
      require('data.func').search_cpp_files()
    end,
    desc = 'Pick C++ and H files',
  },
}

M.flash = {
  { -- Flash jump to next
    '<CR>',
    function()
      require('flash').jump()
    end,
    desc = 'Flash jump',
    mode = { 'n', 'o', 'v' },
  },
}

M.minimap = {
  func = function()
    -- Add NeoMiniMap menu
    require('data.func').add_keymap(M.group.minimap)
    -- Add NeoMiniMap keys
    return M.minimap.keys
  end,
  keys = {
    { -- Toggle minimap
      '<leader>nt',
      '<cmd>Neominimap toggle<cr>',
      desc = 'Toggle minimap',
    },
    { -- Enable minimap
      '<leader>no',
      '<cmd>Neominimap on<cr>',
      desc = 'Enable minimap',
    },
    { -- Disable minimap
      '<leader>nc',
      '<cmd>Neominimap off<cr>',
      desc = 'Disable minimap',
    },
    { -- Refresh minimap
      '<leader>nf',
      '<cmd>Neominimap focus<cr>',
      desc = 'Focus on minimap',
    },
    { -- Unfocus minimap
      '<leader>nu',
      '<cmd>Neominimap unfocus<cr>',
      desc = 'Unfocus minimap',
    },
    { -- Toggle focus
      '<leader>ns',
      '<cmd>Neominimap toggleFocus<cr>',
      desc = 'Toggle focus on minimap',
    },
    { -- Toggle minimap for current window
      '<leader>nwt',
      '<cmd>Neominimap winToggle<cr>',
      desc = 'Toggle minimap for current window',
    },
    { -- Refresh minimap for current window
      '<leader>nwr',
      '<cmd>Neominimap winRefresh<cr>',
      desc = 'Refresh minimap for current window',
    },
    { -- Enable minimap for current window
      '<leader>nwo',
      '<cmd>Neominimap winOn<cr>',
      desc = 'Enable minimap for current window',
    },
    { -- Disable minimap for current window
      '<leader>nwc',
      '<cmd>Neominimap winOff<cr>',
      desc = 'Disable minimap for current window',
    },
    { -- Toggle minimap for current buffer
      '<leader>nbt',
      '<cmd>Neominimap bufToggle<cr>',
      desc = 'Toggle minimap for current buffer',
    },
    { -- Refresh minimap for current buffer
      '<leader>nbr',
      '<cmd>Neominimap bufRefresh<cr>',
      desc = 'Refresh minimap for current buffer',
    },
    { -- Enable minimap for current buffer
      '<leader>nbo',
      '<cmd>Neominimap bufOn<cr>',
      desc = 'Enable minimap for current buffer',
    },
    { -- Disable minimap for current buffer
      '<leader>nbc',
      '<cmd>Neominimap bufOff<cr>',
      desc = 'Disable minimap for current buffer',
    },
  },
}

M.neocodeium = {
  { -- Accept suggestion
    '<c-y>',
    function()
      require('neocodeium').accept()
    end,
    desc = 'Accept suggestion',
    mode = 'i',
  },
  { -- Accept word
    '<c-w>',
    function()
      require('neocodeium').accept_word()
    end,
    desc = 'Accept word',
    mode = 'i',
  },
  { -- Accept line
    '<c-l>',
    function()
      require('neocodeium').accept_line()
    end,
    desc = 'Accept line',
    mode = 'i',
  },
  { -- Cycle or complete (previous)
    '<c-p>',
    function()
      require('neocodeium').cycle_or_complete(-1)
    end,
    desc = 'Cycle or complete (previous)',
    mode = 'i',
  },
  { -- Cycle or complete (next)
    '<c-n>',
    function()
      require('neocodeium').cycle_or_complete()
    end,
    desc = 'Cycle or complete (next)',
    mode = 'i',
  },
  { -- NeoCodeium Chat
    '<leader>ch',
    function()
      require('neocodeium').chat()
    end,
    desc = 'NeoCodeium Chat',
  },
}

M.foldnav = {
  { -- Goto Start
    '<C-h>',
    function()
      require('foldnav').goto_start()
    end,
  },
  { -- Goto Next
    '<C-j>',
    function()
      require('foldnav').goto_next()
    end,
  },
  { -- Goto Prev
    '<C-k>',
    function()
      require('foldnav').goto_prev_start()
    end,
  },
  { -- Goto End
    '<C-l>',
    function()
      require('foldnav').goto_end()
    end,
  },
}

M.gitlinker = {
  { -- Yank git link
    '<leader>gy',
    '<cmd>GitLink<cr>',
    mode = { 'n', 'v' },
    desc = 'Yank git link',
  },
  { -- Open git link
    '<leader>gY',
    '<cmd>GitLink!<cr>',
    mode = { 'n', 'v' },
    desc = 'Open git link',
  },
}

M.gitgraph = {
  { -- gitgraph_toggle
    '<leader>gm',
    function()
      require('utils.git').gitgraph_toggle()
    end,
    desc = 'GitGraph - Toggle',
  },
}

M.gist = {
  func = function()
    -- Add gists menu
    require('data.func').add_keymap(M.group.gist)
    -- Add gists keys
    return M.gist.keys
  end,
  keys = {
    { -- Create Gist
      '<leader>gnc',
      '<cmd>GistCreate<cr>',
      desc = 'Create Gist',
      mode = { 'n', 'x' },
    },
    { -- Find Gists
      '<leader>gnf',
      '<cmd>GistList<cr>',
      desc = 'Find Gists',
    },
  },
}

M.undotree = function()
  require('data.func').add_keymap(
    '<leader>uu',
    '<cmd>UndotreeToggle<cr>',
    'Toggle UndoTree'
  )
end

M.gp = {
  func = function()
    -- Use which-key directly
    if pcall(require, 'which-key') then
      require('which-key').add(M.gp.keys)
    end
  end,
  keys = {
    -- VISUAL mode mappings
    -- s, x, v modes are handled the same way by which_key
    {
      mode = { 'v' },
      nowait = true,
      remap = false,
      {
        '<C-g><C-t>',
        ":<C-u>'<,'>GpChatNew tabnew<cr>",
        desc = 'ChatNew tabnew',
      },
      {
        '<C-g><C-v>',
        ":<C-u>'<,'>GpChatNew vsplit<cr>",
        desc = 'ChatNew vsplit',
      },
      {
        '<C-g><C-x>',
        ":<C-u>'<,'>GpChatNew split<cr>",
        desc = 'ChatNew split',
      },
      { '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
      {
        '<C-g>b',
        ":<C-u>'<,'>GpPrepend<cr>",
        desc = 'Visual Prepend (before)',
      },
      { '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", desc = 'Visual Chat New' },
      { '<C-g>g', group = 'generate into new ..' },
      { '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
      { '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
      { '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
      { '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },
      { '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
      { '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },
      { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
      { '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
      { '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
      { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
      { '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },
      { '<C-g>w', group = 'Whisper' },
      { '<C-g>wa', ":<C-u>'<,'>GpWhisperAppend<cr>", desc = 'Whisper Append' },
      {
        '<C-g>wb',
        ":<C-u>'<,'>GpWhisperPrepend<cr>",
        desc = 'Whisper Prepend',
      },
      { '<C-g>we', ":<C-u>'<,'>GpWhisperEnew<cr>", desc = 'Whisper Enew' },
      { '<C-g>wn', ":<C-u>'<,'>GpWhisperNew<cr>", desc = 'Whisper New' },
      { '<C-g>wp', ":<C-u>'<,'>GpWhisperPopup<cr>", desc = 'Whisper Popup' },
      {
        '<C-g>wr',
        ":<C-u>'<,'>GpWhisperRewrite<cr>",
        desc = 'Whisper Rewrite',
      },
      { '<C-g>wt', ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = 'Whisper Tabnew' },
      { '<C-g>wv', ":<C-u>'<,'>GpWhisperVnew<cr>", desc = 'Whisper Vnew' },
      { '<C-g>ww', ":<C-u>'<,'>GpWhisper<cr>", desc = 'Whisper' },
      { '<C-g>x', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual GpContext' },
    },

    -- NORMAL mode mappings
    {
      mode = { 'n' },
      nowait = true,
      remap = false,
      { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
      { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
      { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
      { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
      { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
      { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
      { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
      { '<C-g>g', group = 'generate into new ..' },
      { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
      { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
      { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
      { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
      { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
      { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
      { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
      { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
      { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
      { '<C-g>w', group = 'Whisper' },
      {
        '<C-g>wa',
        '<cmd>GpWhisperAppend<cr>',
        desc = 'Whisper Append (after)',
      },
      {
        '<C-g>wb',
        '<cmd>GpWhisperPrepend<cr>',
        desc = 'Whisper Prepend (before)',
      },
      { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
      { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
      { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
      {
        '<C-g>wr',
        '<cmd>GpWhisperRewrite<cr>',
        desc = 'Whisper Inline Rewrite',
      },
      { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
      { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
      { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
      { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
    },

    -- INSERT mode mappings
    {
      mode = { 'i' },
      nowait = true,
      remap = false,
      { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
      { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
      { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
      { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
      { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
      { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
      { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
      { '<C-g>g', group = 'generate into new ..' },
      { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
      { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
      { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
      { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
      { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
      { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
      { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
      { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
      { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
      { '<C-g>w', group = 'Whisper' },
      {
        '<C-g>wa',
        '<cmd>GpWhisperAppend<cr>',
        desc = 'Whisper Append (after)',
      },
      {
        '<C-g>wb',
        '<cmd>GpWhisperPrepend<cr>',
        desc = 'Whisper Prepend (before)',
      },
      { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
      { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
      { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
      {
        '<C-g>wr',
        '<cmd>GpWhisperRewrite<cr>',
        desc = 'Whisper Inline Rewrite',
      },
      { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
      { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
      { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
      { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
    },
  },
}

M.group = {
  avante = {
    { -- Avante
      lhs = '<leader>a',
      icon = { icon = '', color = 'red' },
      group = 'Avante',
    },
  },
  chatgpt = { -- ChatGPT
    lhs = '<leader>cx',
    group = 'ChatGPT',
    icon = { icon = '', color = 'blue' },
  },
  gist = { -- Gists menu
    lhs = '<leader>gn',
    group = 'Gists',
    icon = { icon = '', color = 'orange' },
  },
  minimap = { -- MiniMap menu
    lhs = '<leader>n',
    group = 'MiniMap',
    icon = { icon = '', color = 'green' },
  },
  nvimup = {
    { -- Neovim Updater menu
      lhs = '<leader>qu',
      group = 'Neovim Updater',
      icon = { icon = '', color = 'red' },
    },
    { -- Neovim Updater Commits menu
      lhs = '<leader>quc',
      group = 'New Commits',
      icon = { icon = '', color = 'green' },
    },
    { -- MultiCursor
      lhs = '<leader>m',
      group = 'MultiCursor',
      icon = { icon = '󰬸', color = 'green' },
    },
  },
}

M.groups = {
  { -- Lazy menu
    lhs = '<leader>l',
    group = 'Lazy',
    icon = { icon = '󰒲', color = 'red' },
  },
}

M.help = {
  { -- Lookup word
    lhs = '<leader>h',
    rhs = "<cmd>execute 'help ' . expand('<cword>')<cr>",
    desc = 'Lookup word',
  },
  { -- Lookup selection
    lhs = '<leader>h',
    rhs = function()
      require('data.func').help_lookup_visual()
    end,
    desc = 'Lookup selection',
    mode = 'v',
  },
}

M.multicursor = {
  {
    '<leader><up>',
    function()
      require('multicursor-nvim').addCursor('k')
    end,
    mode = { 'n', 'v' },
    desc = 'Add Cursor Above',
  },
  {
    '<leader><down>',
    function()
      require('multicursor-nvim').addCursor('j')
    end,
    mode = { 'n', 'v' },
    desc = 'Add Cursor Below',
  },
  {
    '<leader><c-n>',
    function()
      require('multicursor-nvim').addCursor('*')
    end,
    desc = 'Add Cursor and Skip Word',
    mode = { 'n', 'v' },
  },
  {
    '<leader><c-s>',
    function()
      require('multicursor-nvim').skipCursor('*')
    end,
    desc = 'Skip Word',
    mode = { 'n', 'v' },
  },
  {
    '<leader><left>',
    function()
      require('multicursor-nvim').nextCursor()
    end,
    desc = 'Next Cursor',
    mode = { 'n', 'v' },
  },
  {
    '<leader><right>',
    function()
      require('multicursor-nvim').prevCursor()
    end,
    desc = 'Previous Cursor',
    mode = { 'n', 'v' },
  },
  {
    '<leader>mx',
    function()
      require('multicursor-nvim').deleteCursor()
    end,
    desc = 'Delete Cursor',
    mode = { 'n', 'v' },
  },
  {
    '<c-leftmouse>',
    function()
      require('multicursor-nvim').handleMouse()
    end,
    desc = 'Add/Remove Cursor',
    mode = 'n',
  },
  {
    '<leader><c-q>',
    function()
      if require('multicursor-nvim').cursorsEnabled() then
        require('multicursor-nvim').disableCursors() -- Stop other cursors from moving, allowing main cursor repositioning.
      else
        require('multicursor-nvim').addCursor() -- Add a cursor if none are enabled.
      end
    end,
    desc = 'Add Cursor',
    mode = { 'n', 'v' },
  },
  {
    '<esc>',
    function()
      if not require('multicursor-nvim').cursorsEnabled() then
        require('multicursor-nvim').enableCursors() -- Enable cursors.
      elseif require('multicursor-nvim').hasCursors() then
        require('multicursor-nvim').clearCursors() -- Clear all cursors.
      else
        -- Default <esc> handler can be defined here if needed.
      end
    end,
    desc = 'Escape Handler',
    mode = 'n',
  },
  {
    '<leader>ma',
    function()
      require('multicursor-nvim').alignCursors()
    end,
    desc = 'Align Cursors',
    mode = 'n',
  },
  {
    '<leader>mS',
    function()
      require('multicursor-nvim').splitCursors()
    end,
    desc = 'Split Cursors',
    mode = 'v',
  },
  {
    '<leader>mI',
    function()
      require('multicursor-nvim').insertVisual()
    end,
    desc = 'Insert Visual',
    mode = 'v',
  },
  {
    '<leader>mA',
    function()
      require('multicursor-nvim').appendVisual()
    end,
    desc = 'Append Visual',
    mode = 'v',
  },
  {
    '<leader>mM',
    function()
      require('multicursor-nvim').matchCursors()
    end,
    desc = 'Match Cursors',
    mode = 'v',
  },
  {
    '<leader>mt',
    function()
      require('multicursor-nvim').transposeCursors(1)
    end,
    desc = 'Transpose Cursors  ',
    mode = 'v',
  },
  {
    '<leader>mT',
    function()
      require('multicursor-nvim').transposeCursors(-1)
    end,
    desc = 'Transpose Cursors  ',
    mode = 'v',
  },
}

M.nvimup = {
  { -- Update Neovim from source
    '<Leader>quU',
    ':UpdateNeovim<CR>',
    desc = 'Update Neovim',
  },
  { -- Update Neovim from source in debug mode
    '<Leader>quD',
    function()
      require('nvim_updater').update_neovim({ build_type = 'Debug' })
    end,
    desc = 'Debug Build Neovim',
  },
  { -- Update Neovim from source in release mode
    '<Leader>quR',
    function()
      require('nvim_updater').update_neovim({ build_type = 'Release' })
    end,
    desc = 'Release Build Neovim',
  },
  { -- Remove Neovim Source directory
    '<Leader>quX',
    function()
      require('nvim_updater').remove_source_dir()
    end,
    desc = 'Remove Neovim Source',
  },
  { -- Show new nvim source commits in Telescope
    '<Leader>quct',
    function()
      require('nvim_updater').show_new_commits_in_telescope()
    end,
    desc = 'Show New Commits in Telescope',
  },
  { -- Show new nvim source commits in DiffView
    '<Leader>qucd',
    function()
      require('nvim_updater').show_new_commits_in_diffview()
    end,
    desc = 'Show New Commits in DiffView',
  },
  { -- Show new nvim source commits in terminal
    '<Leader>qucc',
    function()
      require('nvim_updater').show_new_commits()
    end,
    desc = 'Show New Commits in terminal',
  },
}

M.gx = {
  { -- Open URL/Link
    'gx',
    '<cmd>Browse<cr>',
    mode = { 'n', 'x' },
    desc = 'Open URL/Link',
  },
}

M.indentor = {
  { -- Indentor
    '<C-i>',
    function()
      require('utils.indentor').insert_previous_line_indentation()
    end,
    'Insert Previous Line Indentation',
    { 'i', 'n' },
  },
}

M.lazygit = {
  { -- LazyGit
    '<leader>lg',
    function()
      require('data.func').open_lazygit_popup()
    end,
    desc = 'LazyGit',
  },
}

---@function Helper function to toggle mini.files explorer
---@param ... any Optional arguments to pass to mini.files.open
local minifiles_toggle = function(...)
  if not require('mini.files').close() then
    require('mini.files').open(...)
  end
end

--- MiniFiles keymaps
M.minifiles = {
  {
    '<leader>fm',
    function()
      minifiles_toggle(vim.api.nvim_buf_get_name(0), true)
    end,
    desc = 'Open mini.files',
  },
  {
    '<leader>fM',
    function()
      minifiles_toggle(vim.uv.cwd(), true)
    end,
    desc = 'Open mini.files (CWD)',
  },
  { -- Mini.files
    '<leader>\\',
    function()
      minifiles_toggle(vim.api.nvim_buf_get_name(0), true)
    end,
    desc = 'Open mini.files',
  },
  { -- Mini.files
    '<leader>sf',
    function()
      minifiles_toggle(vim.api.nvim_buf_get_name(0), true)
    end,
    desc = 'Open mini.files',
  },
}

--- Misc keymaps
M.misc = {
  { -- jk in insert and visual to escape
    'jk',
    '<esc>',
    mode = { 'i', 'v' },
    desc = 'Escape',
  },
  { -- Clear search highlight
    '<leader>s<Esc>',
    '<cmd>noh<cr><esc>',
    desc = 'Clear search',
  },
  { -- Modeline
    '<leader>cM',
    function()
      require('data.func').append_modeline()
    end,
    desc = 'Add Modeline',
  },
  { -- Yank line (without whitespace)
    lhs = 'yo',
    rhs = function()
      rootiest.yank_line()
    end,
    desc = 'Yank Line-text',
  },
  { -- Yank and trim selection
    lhs = '<leader>y',
    rhs = function()
      require('data.func').trim_yank()
    end,
    desc = 'Yank and trim selection',
  },
  { -- Hardmode
    lhs = '<leader>uH',
    rhs = function()
      rootiest.toggle_hardmode()
    end,
    desc = 'Toggle Hardmode',
  },
  { -- Reload config
    lhs = '<leader>qr',
    rhs = function()
      require('data.func').reload_config()
    end,
    desc = 'Reload Config',
  },
  { -- Yank buffer
    lhs = '<leader>Y',
    rhs = '<cmd>%y<cr>',
    desc = 'Yank buffer contents',
  },
  { -- Select all
    lhs = '<C-a>',
    rhs = '<cmd>norm ggVG<cr>',
    desc = 'Select all',
  },
  { -- Neotree
    lhs = '|',
    rhs = '<cmd>Neotree reveal toggle<cr>',
    desc = 'Neotree toggle',
  },
  { -- Neotree
    lhs = '<leader>F',
    rhs = '<cmd>Neotree reveal toggle<cr>',
    desc = 'Neotree toggle',
  },
  { -- Telescope Find Files
    lhs = '<leader><leader>',
    rhs = function()
      require('data.func').pick()
    end,
    desc = 'Find Files',
  },
  { -- Grep files
    lhs = '<leader>/',
    rhs = function()
      require('data.func').pick({ cmd = 'grep' })
    end,
    desc = 'Grep Files',
  },
  { -- Exit Neovim
    lhs = '<leader>Q',
    rhs = "<cmd>lua require('data').func.exit()<cr>",
    desc = 'Exit Neovim',
  },
  { -- LazyVim
    lhs = '<leader>lv',
    rhs = '<cmd>Lazy<cr>',
    desc = 'LazyVim',
  },
  { -- LazyExtras
    lhs = '<leader>lx',
    rhs = '<cmd>LazyExtras<cr>',
    desc = 'LazyExtras',
  },
  { -- De-map Ctrl+Shift+LeftClick to avoid conflicts with WezTerm
    lhs = '<C-S-LeftMouse>',
    rhs = '<Nop>',
    desc = 'Prevent conflict with WezTerm hyperlinks',
    mode = 'n',
    hidden = true,
  },
  { -- Visual mode: Move selected block of text up
    lhs = 'K',
    rhs = function()
      local count = vim.v.count1
      require('data.func').move_visual(true, count)
    end,
    desc = 'Move block of text up',
    mode = 'v',
  },
  { -- Visual mode: Move selected block of text down
    lhs = 'J',
    rhs = function()
      local count = vim.v.count1
      require('data.func').move_visual(false, count)
    end,
    desc = 'Move block of text down',
    mode = 'v',
  },
  { -- Test Prompt: Enter your name
    lhs = '<leader>qP',
    rhs = function()
      require('data.func').InputPrompt('Enter your name: ', function(input)
        if input then
          -- trim whitespace from end of input
          input = input:gsub('%s+$', '')
          print('👋😎 Hello ' .. input .. '!')
        else
          print('Input was canceled')
        end
      end)
    end,
    desc = 'Test Prompt',
  },
  { -- Paste over text with overwrite
    lhs = '<leader>cp',
    rhs = function()
      require('data.func').paste_overwrite()
    end,
    desc = 'Paste overwrite',
    mode = 'n',
  },
  { -- Dump buffer contents to a table in register
    lhs = '<leader>bY',
    rhs = function()
      require('data.func').dump_buffer_to_table('+')
    end,
    desc = 'Yank buffer as table',
    mode = 'n',
  },
  { -- Yank buffer
    lhs = '<leader>by',
    rhs = '<cmd>%y<cr>',
    desc = 'Yank buffer',
    mode = 'n',
  },
}

M.nekifoch = {
  { -- List Fonts
    '<leader>u,l',
    '<cmd>Nekifoch list<cr>',
    desc = 'Fonts list',
  },
  { -- Check Font
    '<leader>u,c',
    '<cmd>Nekifoch check<cr>',
    desc = 'Check current font settings',
  },
  { -- Set Font Family
    '<leader>u,f',
    function()
      require('nekifoch.nui_set_font')()
    end,
    desc = 'Set font family',
  },
  { -- Set Font Size
    '<leader>u,s',
    function()
      require('nekifoch.nui_set_size')()
    end,
    desc = 'Set font size',
  },
}

M.precog = {
  { -- Toggle Precognition
    'zk',
    function()
      require('config.rootiest').toggle_precognition()
    end,
    desc = 'Toggle Precognition',
  },
}

M.qalc = {
  -- { -- Open Qalc
  --   "<leader>qc",
  --   "<cmd>Qalc<cr>",
  --   desc = "Qalc",
  -- },
  { -- Set a key mapping to run :Qalc and enter insert mode
    '<leader>qc',
    function()
      -- Run the Qalc command
      vim.cmd('Qalc')
      -- Enter insert mode directly
      vim.cmd('startinsert')
    end,
    desc = 'Qalc',
  },
}

M.ripsub = {
  { -- Rip Substitute
    '<leader>fs',
    function()
      require('rip-substitute').sub()
    end,
    mode = { 'n', 'x' },
    desc = 'Rip Substitute',
  },
}

M.splitjoin = {
  toggle = 'gJ',
}

M.splits = {
  resize = {
    { -- Resize split leftwards
      '<A-h>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize split left',
    },
    { -- Resize split downwards
      '<A-j>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize split down',
    },
    { -- Resize split upwards
      '<A-k>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize split up',
    },
    { -- Resize split rightwards
      '<A-l>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize split right',
    },
    { -- Start interactive split resizing
      '<A-r>',
      function()
        require('smart-splits').start_resize_mode()
      end,
      desc = 'Resize split interactively',
    },
  },
  move = {
    { -- Move cursor to split left
      '<C-S-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Move to split left',
    },
    { -- Move cursor to split below
      '<C-S-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Move to split below',
    },
    { -- Move cursor to split above
      '<C-S-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Move to split above',
    },
    { -- Move cursor to split right
      '<C-S-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Move to split right',
    },
    { -- Move cursor to previous split
      '<C-\\>',
      function()
        require('smart-splits').move_cursor_previous()
      end,
      desc = 'Move to previous split',
    },
  },
  swap = {
    { -- Swap buffer with the one to the left
      '<A-S-h>',
      function()
        require('smart-splits').swap_buf_left()
      end,
      desc = 'Swap buffer left',
    },
    { -- Swap buffer with the one below
      '<A-S-j>',
      function()
        require('smart-splits').swap_buf_down()
      end,
      desc = 'Swap buffer down',
    },
    { -- Swap buffer with the one above
      '<A-S-k>',
      function()
        require('smart-splits').swap_buf_up()
      end,
      desc = 'Swap buffer up',
    },
    { -- Swap buffer with the one to the right
      '<A-S-l>',
      function()
        require('smart-splits').swap_buf_right()
      end,
      desc = 'Swap buffer right',
    },
  },
}

M.substitute = {
  { -- Substitute operator in normal mode
    'x',
    function()
      require('substitute').operator()
    end,
    desc = 'Substitute operator',
  },
  { -- Substitute line in normal mode
    'xx',
    function()
      require('substitute').line()
    end,
    desc = 'Substitute line',
  },
  { -- Substitute end of line in normal mode
    'X',
    function()
      require('substitute').eol()
    end,
    desc = 'Substitute end of line',
  },
  { -- Substitute visual selection in visual mode
    'x',
    function()
      require('substitute').visual()
    end,
    desc = 'Substitute visual selection',
    mode = 'x',
  },
  { -- Substitute visual selection in visual mode
    '<leader>m',
    function()
      require('substitute').visual()
    end,
    desc = 'Substitute',
    mode = 'x',
  },
}

M.overrides = {
  { -- De-map 's' to avoid conflicts with mini.surround
    lhs = 's',
    rhs = '<Nop>', -- This disables the keymap
    desc = 'Surround',
    mode = { 'n', 'x' },
  },
  { -- Stop snippet when leaving insert mode
    lhs = '<Esc>',
    rhs = function()
      vim.snippet.stop()
      return '<Esc>'
    end,
  },
}

M.telescope = {
  cmdline = {
    {
      ':',
      function()
        require('telescope').extensions.cmdline.cmdline()
      end,
      desc = 'Cmdline',
    },
  },
  lazy = {
    {
      '<leader>fz',
      function()
        require('telescope').extensions.lazy.lazy()
      end,
      desc = 'Lazy Picker',
    },
  },
  symbols = {
    { -- Telescope Symbols
      '<leader>f.',
      function()
        require('telescope.builtin').symbols({
          sources = {
            'nerd',
            'emoji',
            'kaomoji',
            'gitmoji',
            'math',
            'latex',
            'julia',
          },
        })
      end,
      desc = 'Pick Icons',
    },
    { -- Pick Icon in insert mode
      '<C-.>',
      function()
        require('telescope.builtin').symbols({
          sources = {
            'nerd',
            'emoji',
            'kaomoji',
            'gitmoji',
            'math',
            'latex',
            'julia',
          },
        })
      end,
      desc = 'Pick Icon',
      mode = 'i',
    },
  },
  toggleterm = {
    { -- Pick ToggleTerms
      '<leader>ft',
      function()
        require('toggleterm-manager').open({})
      end,
      desc = 'Pick Terminals',
      mode = 'n',
    },
  },
  filebrowser = {
    {
      '<leader>e',
      function()
        require('telescope').extensions.file_browser.file_browser()
      end,
      desc = 'Telescope File Browser',
      mode = 'n',
    },
    {
      '<leader>sF',
      function()
        require('telescope').extensions.file_browser.file_browser()
      end,
      desc = 'Telescope File Browser',
      mode = 'n',
    },
  },
}

M.toggleterm = {
  { -- Toggle Terminal
    '<c-/>',
    '<cmd>ToggleTerm<cr>',
    desc = 'Toggle Terminal',
    mode = 'n',
  },
}

M.transparent = {
  {
    '<leader>wt',
    function()
      require('transparent').toggle()
    end,
    desc = 'Toggle Transparency',
  },
}

M.yanky = {
  { -- Yanky put after
    'P',
    '<Plug>(YankyPutAfter)',
    desc = 'Yanky put after',
    mode = { 'n', 'x' },
  },
  { -- Yanky put before
    'p',
    '<Plug>(YankyPutBefore)',
    desc = 'Yanky put before',
    mode = { 'n', 'x' },
  },
  { -- Yanky gput after
    'gP',
    '<Plug>(YankyGPutAfter)',
    desc = 'Yanky gput after',
    mode = { 'n', 'x' },
  },
  { -- Yanky gput before
    'gp',
    '<Plug>(YankyGPutBefore)',
    desc = 'Yanky gput before',
    mode = { 'n', 'x' },
  },
  { -- Yanky previous entry
    '<c-p>',
    '<Plug>(YankyPreviousEntry)',
    desc = 'Yanky previous entry',
    mode = 'n',
  },
  { -- Yanky next entry
    '<c-n>',
    '<Plug>(YankyNextEntry)',
    desc = 'Yanky next entry',
    mode = 'n',
  },
  { -- Put indent after linewise
    ']p',
    '<Plug>(YankyPutIndentAfterLinewise)',
    desc = 'Put indent after linewise',
  },
  { -- Put indent before linewise
    '[p',
    '<Plug>(YankyPutIndentBeforeLinewise',
    desc = 'Put indent before linewise',
  },
  { -- Put indent after linewise (uppercase)
    ']P',
    '<Plug>(YankyPutIndentAfterLinewise)',
    desc = 'Put indent after linewise (uppercase)',
  },
  { -- Put indent before linewise (uppercase)
    '[P',
    '<Plug>(YankyPutIndentBeforeLinewise)',
    desc = 'Put indent before linewise (uppercase)',
  },
  { -- Put indent after shift right
    '>p',
    '<Plug>(YankyPutIndentAfterShiftRight)',
    desc = 'Put indent after shift right',
  },
  { -- Put indent after shift left
    '<p',
    '<Plug>(YankyPutIndentAfterShiftLeft)',
    desc = 'Put indent after shift left',
  },
  { -- Put indent before shift right
    '>P',
    '<Plug>(YankyPutIndentBeforeShiftRight)',
    desc = 'Put indent before shift right',
  },
  { -- Put indent before shift left
    '<P',
    '<Plug>(YankyPutIndentBeforeShiftLeft)',
    desc = 'Put indent before shift left',
  },
  { -- Put after filter
    '=p',
    '<Plug>(YankyPutAfterFilter)',
    desc = 'Put after filter',
  },
  { -- Put before filter
    '=P',
    '<Plug>(YankyPutBeforeFilter)',
    desc = 'Put before filter',
  },
  { -- Last put in operator-pending mode
    'lp', -- Left-hand side (key combination)
    function()
      require('yanky.textobj').last_put()
    end,
    desc = 'Last put',
    mode = { 'x', 'o' },
  },
  { -- Open Yank History
    '<leader>p', -- Left-hand side (key combination)
    function()
      if pcall(require, 'telescope') then
        require('telescope').extensions.yank_history.yank_history()
      else
        vim.cmd('YankyRingHistory')
      end
    end,
    desc = 'Yank History',
  },
}

M.zen = {
  { -- Toggle ZenMode
    '<leader>z',
    function()
      require('zen-mode').toggle()
    end,
    desc = 'Toggle ZenMode',
  },
}

return M
