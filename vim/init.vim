" Place this file in
" ~/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" Solve problem with cursor rendering in some terminals using neovim
" https://github.com/neovim/neovim/issues/5990
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
let $VTE_VERSION="100"
source ~/.vimrc
