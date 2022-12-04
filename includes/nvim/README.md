# README


## Installation

Install [packer.nvim](https://github.com/wbthomason/packer.nvim)I

```shell
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Install dependencies

```shell
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

