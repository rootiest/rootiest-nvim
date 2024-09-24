--- @module "plugins.languages"
--- This module defines the languages plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Languages                        │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- none-ls
    import = "lazyvim.plugins.extras.lsp.none-ls",
  },
  { -- JSON
    import = "lazyvim.plugins.extras.lang.json",
  },
  { -- Markdown
    import = "lazyvim.plugins.extras.lang.markdown",
  },
  { -- Toml
    import = "lazyvim.plugins.extras.lang.toml",
  },
  { -- Git
    import = "lazyvim.plugins.extras.lang.git",
  },
  { -- Python
    import = "lazyvim.plugins.extras.lang.python",
  },
  { -- Yaml
    import = "lazyvim.plugins.extras.lang.yaml",
  },
  { -- clangd
    import = "lazyvim.plugins.extras.lang.clangd",
  },
  { -- cmake
    import = "lazyvim.plugins.extras.lang.cmake",
  },
  { -- Docker
    import = "lazyvim.plugins.extras.lang.docker",
  },
  { -- Java
    import = "lazyvim.plugins.extras.lang.java",
  },
  { -- Sql
    import = "lazyvim.plugins.extras.lang.sql",
  },
  { -- Jinja
    "armyers/Vim-Jinja2-Syntax",
  },
  { -- Render-markdown
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        -- Determins if a border is added above and below headings
        border = true,
        above = "▂",
        -- Used below heading for border
        below = "🮂",
      },
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
}
