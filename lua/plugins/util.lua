--- @module "plugins.util"
--- This module defines the utility plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Utilities                        │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Chezmoi
    import = 'lazyvim.plugins.extras.util.chezmoi',
  },
  { -- Dotfiles plugins
    import = 'lazyvim.plugins.extras.util.dot',
  },
  { -- Env file no diagnostics
    'nvim-treesitter/nvim-treesitter',
    opts = function(_)
      vim.api.nvim_create_augroup('EnvFileDiagnostics', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        group = 'EnvFileDiagnostics',
        pattern = { '*.env', '*.env.*' },
        callback = function()
          vim.diagnostic.enable(false)
        end,
      })
    end,
  },
  { -- Wakatime
    'wakatime/vim-wakatime',
    cond = vim.g.usewakatime,
  },
  { -- Link following
    'chrishrb/gx.nvim',
    lazy = true,
    cmd = require('data.cmd').gx,
    keys = require('data.keys').gx,
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = require('data.deps').gx,
    config = true,
  },
  { -- Ripgrep substitute
    'chrisgrieser/nvim-rip-substitute',
    event = 'InsertEnter',
    cmd = require('data.cmd').ripsub,
    keys = require('data.keys').ripsub,
  },
  { -- Unception
    'samjwill/nvim-unception',
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
  { -- Codesnap
    'mistricky/codesnap.nvim',
    cond = require('data.func').check_global_var('codesnap', true, true),
    lazy = true,
    build = 'make',
    opts = require('data.types').codesnap,
    cmd = require('data.cmd').codesnap,
    keys = require('data.keys').codesnap,
  },
  { -- Kulala
    'mistweaverco/kulala.nvim',
    ft = require('data.types').kulala.ft,
    opts = {},
  },
  { -- Hardtime
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = require('data.deps').hardtime,
    opts = function()
      return { enabled = vim.g.usehardtime }
    end,
  },
  { -- CapsWord
    'dmtrKovalenko/caps-word.nvim',
    lazy = true,
    opts = {},
    keys = require('data.keys').capsword,
  },
  { -- Music Controls
    'AntonVanAssche/music-controls.nvim',
    cond = require('data.func').check_global_var('usemusic', true, true),
    dependencies = require('data.deps').musiccontrols,
    opts = {
      default_player = 'YoutubeMusic',
    },
  },
  { -- Qalc
    'Apeiros-46B/qalc.nvim',
    cmd = require('data.cmd').qalc,
    keys = require('data.keys').qalc,
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
  },
  { -- Remote-nvim
    'amitds1997/remote-nvim.nvim',
    lazy = true,
    version = '*', -- Pin to GitHub releases
    dependencies = require('data.deps').remotenvim,
    config = true,
  },
  { -- Encourage
    'r-cha/encourage.nvim',
    cond = require('data.func').check_global_var('encourage', true, true),
    config = true,
  },
  { -- Helpview
    'OXY2DEV/helpview.nvim',
    ft = 'help',
    dependencies = require('data.deps').needs_treesitter,
  },
  { -- Suda
    'lambdalisue/vim-suda',
    cmd = require('data.cmd').suda,
    config = require('data.types').suda,
  },
  -- { -- Pigeon
  --   "Pheon-Dev/pigeon",
  --   config = require('data.types').pigeon,
  -- },
  { -- Discord Presence
    'IogaMaster/neocord',
    event = 'VeryLazy',
    cond = require('data.func').check_global_var('usediscord', true, true),
    opts = {
      logo = 'https://raw.githubusercontent.com/rootiest/rootiest-nvim/b949af32e72db9fc35c18e14e2088710dc36dd15/logo/icon.png',
      main_image = 'logo',
      blacklist = { 'bin: No such file or directory' },
      file_assets = {},
    },
  },
  { -- Floating Help
    'Tyler-Barham/floating-help.nvim',
    opts = {
      width = 0.8, -- Whole numbers are columns/rows
      height = 0.9, -- Decimals are a percentage of the editor
      position = 'C', -- NW,N,NW,W,C,E,SW,S,SE (C==center)
      border = 'rounded', -- rounded,double,single
    },
    cmd = {
      'FloatingHelp',
      'FloatingHelpClose',
      'FloatingHelpToggle',
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
  },
  { -- Timer
    'alex-popov-tech/timer.nvim',
  },
  { -- Image-Clip
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
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
  },
  { -- Multicursor
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
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
  },
  {
    'itsvinayak/nvim-notes.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Add Telescope as a dependency
      'folke/which-key.nvim', -- Add WhichKey as a dependency
    },
    config = function()
      require('notes').setup({
        -- Optional configurations
        path = '~/.my_notes', -- Custom path for notes
        log_enabled = true, -- Enable logging
        log_level = 'INFO', -- Set log level to INFO
      })
    end,
  },
  { -- FloatTerm
    'voldikss/vim-floaterm',
  },
  { -- bufferlist
    'EL-MASTOR/bufferlist.nvim',
    lazy = true,
    keys = { { '<Leader>bl', desc = 'Open bufferlist' } }, -- keymap to load the plugin, it should be the same as keymap.open_buflist
    opts = {},
  },
  { -- showkeys
    'nvchad/showkeys',
    cmd = 'ShowkeysToggle',
    opts = {
      timeout = 1,
      maxkeys = 5,
      -- more opts
    },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  { -- Utlitities Framework
    'jrop/u.nvim',
    lazy = true,
  },
  { -- Co-op (Neovim Co-routines Framework)
    'gregorias/coop.nvim',
    lazy = false,
  },
  {
    'marcussimonsen/let-it-snow.nvim',
    cmd = 'LetItSnow', -- Wait with loading until command is run
    opts = {},
  },
  { -- yazi
    'mikavilpas/yazi.nvim',
    cmd = 'Yazi',
    event = 'VeryLazy',
  },
}
