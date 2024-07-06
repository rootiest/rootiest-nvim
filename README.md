# Rootiest NVim Configuration

```none
██████╗  ██████╗  ██████╗ ████████╗██╗███████╗███████╗████████╗
██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██║██╔════╝██╔════╝╚══██╔══╝
██████╔╝██║   ██║██║   ██║   ██║   ██║█████╗  ███████╗   ██║
██╔══██╗██║   ██║██║   ██║   ██║   ██║██╔══╝  ╚════██║   ██║
██║  ██║╚██████╔╝╚██████╔╝   ██║   ██║███████╗███████║   ██║
╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝   ╚═╝

            ███╗   ██╗██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██║   ██║██║████╗ ████║
            ██╔██╗ ██║██║   ██║██║██╔████╔██║
            ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```

The rootiest neovim configuration you will ever see!

## Installation

1. Install [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)

2. Backup your current nvim configuration (if you have one)

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

3. Clone the repository

   ```bash
   git clone https://github.com/rootiest/rootiest-nvim.git ~/.config/nvim
   ```

4. Enjoy!

## Features

- Comfortable keybindings and IDE-like features
- Designed to be quick to load and easy to use without compromising on features
- Leans heavily on lazy and luarocks for plugin management
- Catppuccino theme is default but tokyonight is also included
- Automatic light/dark mode switching based on system theme
- Extensive special configurations for kitty, including theme matching
- Image support for kitty when conditions are met
- Special configuration for neovide
- Detects terminal client and adjusts accordingly
- Detects SSH sessions and disables certain plugins for speed and compatibility
- ToggleTerm, fzf, telescope, neotree, etc. for quick access to files and terminal
- LSP support for many languages and automatic setup for many more

## Credits

- [Folke Lamaitre](https://github.com/folke)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [Elijah Manor](https://github.com/elijahmanor/elijahmanor)
