# Installation Instructions

1. Packer <br>
   ```
   git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```
2. LSP Config
   - `npm i -g bash-language-server`
   - `npm i -g vscode-langservers-extracted`
   - `npm i -g pyright`
   - `npm i -g typescript typescript-language-server`
   - `npm i -g vim-language-server`
   - `npm i -g yaml-language-server`
   - `npm i -g emmet-ls`
3. Null-ls
   - `python3 -m pip install black`
   - `python3 -m pip install codespell`
   - `npm i -g eslint_d`
   - `python3 -m pip install jsontool`
   - `npm i -g prettier`
   - `cargo install stylua`
4. Treesitter
`:TSInstall <Tab>` to view available languages
