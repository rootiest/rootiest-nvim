--- @module "config.rocks"
--- This module bootstraps rocks.nvim.
--- Rocks is a package manager for Neovim.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          ROCKS                          │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

--  ━━━━━━━━━━━━━━━━━━━━━━━━ Bootstrap rocks.nvim ━━━━━━━━━━━━━━━━━━━━━
function M.bootstrap()
  do
    local rocks_config = {
      rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
    }

    vim.g.rocks_nvim = rocks_config

    local luarocks_path = {
      vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
      vim.fs.joinpath(
        rocks_config.rocks_path,
        "share",
        "lua",
        "5.1",
        "?",
        "init.lua"
      ),
    }
    package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

    local luarocks_cpath = {
      vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
      vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
      -- Remove the dylib and dll paths if you do not need macos or windows support
      vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
      vim.fs.joinpath(
        rocks_config.rocks_path,
        "lib64",
        "lua",
        "5.1",
        "?.dylib"
      ),
      vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
      vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
    }
    package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

    vim.opt.runtimepath:append(
      vim.fs.joinpath(
        rocks_config.rocks_path,
        "lib",
        "luarocks",
        "rocks-5.1",
        "rocks.nvim",
        "*"
      )
    )
  end

  -- If rocks.nvim is not installed then install it!
  if not pcall(require, "rocks") then
    local rocks_location =
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.fs.joinpath(vim.fn.stdpath("cache"), "rocks.nvim")

    if not vim.uv.fs_stat(rocks_location) then
      -- Pull down rocks.nvim
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/nvim-neorocks/rocks.nvim",
        rocks_location,
      })
    end

    -- If the clone was successful then source the bootstrapping script
    assert(
      vim.v.shell_error == 0,
      "rocks.nvim installation failed. Try exiting and re-entering Neovim!"
    )

    vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))

    vim.fn.delete(rocks_location, "rf")
  end
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Ensure Luarocks ━━━━━━━━━━━━━━━━━━━━━━━
function M.ensure_luarocks()
  -- Check if 'luarocks' command is available
  if os.execute("luarocks --version") ~= 0 then
    -- 'luarocks' is not installed, set up 'luarocks.nvim' plugin
    local status_ok, lazy = pcall(require, "lazy")
    if not status_ok then
      vim.notify(
        "Lazy.nvim not found. Please install it to manage plugins.",
        vim.log.levels.ERROR
      )
      return
    end

    lazy.setup({
      {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Ensure this plugin loads first
        opts = {
          rocks = { "magick" }, -- Example of a rock that you want to install
        },
        config = function()
          -- Restart Neovim to apply changes after 'luarocks.nvim' sets up
          vim.cmd("source $MYVIMRC | qa")
        end,
      },
    })
  end
end
--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Rocks plugin spec ━━━━━━━━━━━━━━━━━━━━━━
M.plugin_spec = {
  "vhyrro/luarocks.nvim",
  priority = 1000, -- Very high priority is required
  opts = {
    rocks = { "magick" }, -- specifies a list of rocks to install
  },
}

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Load plugins ━━━━━━━━━━━━━━━━━━━━━━━━━
-- Load rocks package manager
M.load_rocks = function()
  require("rocks")
end

-- Perform setup
M.setup = function()
  M.bootstrap()
  M.ensure_luarocks()
  M.load_rocks()
end

-- Execute the setup function
M.setup()

return M
