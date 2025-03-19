return {
  { -- Codeium
    import = 'lazyvim.plugins.extras.ai.codeium',
    cond = require('data.cond').codeium,
    event = 'VeryLazy',
    lazy = true,
    opts = function()
      require('codeium.virtual_text').set_statusbar_refresh(function()
        require('lualine').refresh()
      end)
    end,
  },
  { -- Copilot
    import = 'lazyvim.plugins.extras.ai.copilot',
    cond = require('data.cond').copilot,
  },
  { -- Tabnine
    import = 'lazyvim.plugins.extras.ai.tabnine',
    cond = require('data.cond').tabnine,
  },
  { -- luasnip
    import = 'lazyvim.plugins.extras.coding.luasnip',
  },
  { -- Yanky
    import = 'lazyvim.plugins.extras.coding.yanky',
  },
  { -- Neogen
    import = 'lazyvim.plugins.extras.coding.neogen',
  },
  { -- DAP Core
    import = 'lazyvim.plugins.extras.dap.core',
  },
  { -- DAP Neovim Lua Adapter
    import = 'lazyvim.plugins.extras.dap.nlua',
  },
  { -- NeoTest
    import = 'lazyvim.plugins.extras.test.core',
  },
  { import = 'lazyvim.plugins.extras.ui.smear-cursor' },
  { -- Dial
    import = 'lazyvim.plugins.extras.editor.dial',
  },
  { -- Illuminate
    import = 'lazyvim.plugins.extras.editor.illuminate',
  },
  { -- Snacks Picker
    import = 'lazyvim.plugins.extras.editor.snacks_picker',
  },
  { -- IncRename
    import = 'lazyvim.plugins.extras.editor.inc-rename',
  },
  { -- Treesitter-context
    import = 'lazyvim.plugins.extras.ui.treesitter-context',
  },
  { -- Navic
    import = 'lazyvim.plugins.extras.editor.navic',
  },
  { -- Refactoring
    import = 'lazyvim.plugins.extras.editor.refactoring',
  },
  { -- Octo plugin
    import = 'lazyvim.plugins.extras.util.octo',
  },
  { -- JSON
    import = 'lazyvim.plugins.extras.lang.json',
  },
  { -- Markdown
    import = 'lazyvim.plugins.extras.lang.markdown',
  },
  { -- Toml
    import = 'lazyvim.plugins.extras.lang.toml',
  },
  { -- Git
    import = 'lazyvim.plugins.extras.lang.git',
  },
  { -- Python
    import = 'lazyvim.plugins.extras.lang.python',
  },
  { -- Yaml
    import = 'lazyvim.plugins.extras.lang.yaml',
  },
  { -- clangd
    import = 'lazyvim.plugins.extras.lang.clangd',
  },
  { -- cmake
    import = 'lazyvim.plugins.extras.lang.cmake',
  },
  { -- Docker
    import = 'lazyvim.plugins.extras.lang.docker',
  },
  { -- Java
    import = 'lazyvim.plugins.extras.lang.java',
  },
  { -- Sql
    import = 'lazyvim.plugins.extras.lang.sql',
  },
  { -- Rust
    import = 'lazyvim.plugins.extras.lang.rust',
  },
  -- { -- Mini.Indentscope
  --   import = 'lazyvim.plugins.extras.ui.mini-indentscope',
  -- },
  { -- mini.files
    import = 'lazyvim.plugins.extras.editor.mini-files',
  },
  { import = 'lazyvim.plugins.extras.editor.snacks_picker' },
  { import = 'lazyvim.plugins.extras.editor.snacks_explorer' },
  {
    import = 'lazyvim.plugins.extras.editor.fzf',
    cond = function()
      return require('data.func').check_global_var('use_fzf_lua', true, false)
    end,
  },
  { -- Chezmoi
    import = 'lazyvim.plugins.extras.util.chezmoi',
  },
  { -- Dotfiles plugins
    import = 'lazyvim.plugins.extras.util.dot',
  },
  { -- Blink completion
    import = 'lazyvim.plugins.extras.coding.blink',
    cond = function()
      return vim.g.useblinkcmp
    end,
  },
  { -- Nvim-cmp
    import = 'lazyvim.plugins.extras.coding.nvim-cmp',
    cond = function()
      return not vim.g.useblinkcmp
    end,
  },
  { -- Project
    import = 'lazyvim.plugins.extras.util.project',
  },
}
