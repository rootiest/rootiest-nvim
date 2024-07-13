# Rootiest NeoVim Configuration

```none
██████╗  ██████╗  ██████╗ ████████╗██╗███████╗███████╗████████╗
██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██║██╔════╝██╔════╝╚══██╔══╝
██████╔╝██║   ██║██║   ██║   ██║   ██║█████╗  ███████╗   ██║
██╔══██╗██║   ██║██║   ██║   ██║   ██║██╔══╝  ╚════██║   ██║
██║  ██║╚██████╔╝╚██████╔╝   ██║   ██║███████╗███████║   ██║
╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝   ╚═╝
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║

      ,l;             c,
   .:ooool'           loo:.
 .,oooooooo:.         looooc,      /VVVVVVVV\++++  /VVVVVVVV\
ll:,loooooool,        looooool     \VVVVVVVV/++++++\VVVVVVVV/
llll,;ooooooooc.      looooooo      |VVVVVV|++++++++/VVVVV/'
lllllc,coooooooo;     looooooo      |VVVVVV|++++++/VVVVV/'
lllllll;,loooooool'   looooooo     +|VVVVVV|++++/VVVVV/'+
lllllllc .:oooooooo:. looooooo   +++|VVVVVV|++/VVVVV/'+++++
lllllllc   'loooooool,:ooooooo +++++|VVVVVV|/VVV___++++++++++
lllllllc     ;ooooooooc,cooooo   +++|VVVVVVVVVV/##/ +_+_+_+
lllllllc      .coooooooo;;looo     +|VVVVVVVVV___ +/#_#,#_#,\
lllllllc        ,loooooool,:ol      |VVVVVVV//##/+/#/+/#/'/#/
 'cllllc         .:oooooooo;.       |VVVVV/'+/#/+/#/+/#/ /#/
   .;llc           .loooo:.         |VVV/'++/#/+/#/ /#/ /#/
      ,;             ;l;            'V/'  /##//##//##//###/
```

The rootiest neovim configuration you will ever see!

## Installation

1. Install [NeoVim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
2. Install Pre-requisites

   - Required

     - [git](https://git-scm.com/) -
       Version control system
     - [luarocks](https://luarocks.org/) -
       Lua package manager
     - A terminal with [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/) support

   - Optional (but recommended for the full experience)
     - [ripgrep](https://github.com/BurntSushi/ripgrep) -
       A faster grep
     - [fzf](https://github.com/junegunn/fzf) -
       A command-line fuzzy finder
     - [fd](https://github.com/sharkdp/fd) -
       A simple, fast and user-friendly alternative to 'find'
     - [lazygit](https://github.com/jesseduffield/lazygit) -
       A simple terminal UI for git commands
     - [tree-sitter](https://github.com/tree-sitter/tree-sitter/) -
       A parser generator tool and an incremental parsing library
     - [kitty](https://sw.kovidgoyal.net/kitty/) -
       A fast, featureful, GPU based terminal emulator
     - [neovide](https://neovide.dev/) -
       A simple, fast, featureful, and modern NeoVim GUI
     - [fish](https://fishshell.com/) -
       A smart and user-friendly command line shell

3. Backup your current nvim configuration (if you have one)

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

4. Clone the repository

   ```bash
   git clone https://github.com/rootiest/rootiest-nvim.git ~/.config/nvim
   ```

5. Enjoy! 🎉

## Features

- Comfortable keybindings and IDE-like features
- Designed to be quick to load and easy to use without compromising on features
- Leans heavily on lazy and luarocks for plugin management and lazy-loading
- Catppuccino theme is default but a selection of others are also included
- Automatic light/dark mode switching based on system theme
- Extensive special configurations for kitty, including theme matching
- Kitty scrollback and keybinding support
- Special configuration for neovide
- Detects terminal client and adjusts accordingly
- ToggleTerm, fzf, telescope, neotree, etc. for quick access to files and terminal
- Many UI elements to enhance the experience
- LSP support for many languages and automatic setup for many more
- Remotely spawn a NeoVim instance over ssh, in a container, or from a git repo
- Dashboard logo adjusts to the size of the window
- Codeium-powered AI completion
- Lean and fast while providing a complete professional experience

## Companion Tools

[Rootiest Kitty Conf](https://github.com/rootiest/rootiest-kitty) -
A kitty configuration that is designed to work with this NeoVim configuration

[Rootiest Fish Conf](https://github.com/rootiest/rootiest-fish-conf) -
A fish configuration that pairs well with this NeoVim configuration

[Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/) -
A collection of fonts that include many icons and glyphs that are used in this configuration.

## Dotfiles

[Rootiest Dotfiles](https://github.com/rootiest/dotfiles)

## Credits

- [Folke Lamaitre](https://github.com/folke)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [Elijah Manor](https://github.com/elijahmanor/elijahmanor)
