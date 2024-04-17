# cyber.nvim

## Pre-requisites

- [Mason requirements](https://github.com/williamboman/mason.nvim?tab=readme-ov-file#requirements)
- [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

## Setup Instructions

1. Install [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)

```sh
nvim --version # confirm installation
```

2. Clone [repo](https://github.com/julianstephens/cyber.nvim) to `<user home>/.config/nvim`

```sh
git clone git@github.com:julianstephens/cyber.nvim.git ~/.config/nvim
```

3. Launch nvim to install packages (should start automatically)

4. Turn on/off required language servers with [lspconfig](https://github.com/julianstephens/cyber.nvim/blob/main/lua/core/lspconfig.lua). Most servers are toggled with true/false [here](https://github.com/julianstephens/cyber.nvim/blob/50b76ae9dc87e5bc461199fc837b717f57102291/lua/core/lspconfig.lua#L14-L99). A few servers require unique config and can be turned on/off by [commenting or uncommenting](https://github.com/julianstephens/cyber.nvim/blob/50b76ae9dc87e5bc461199fc837b717f57102291/lua/core/lspconfig.lua#L229-L266).
