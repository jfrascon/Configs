" Place this file inside the folder ~/.vim

if exists("did_load_filetypes")
  finish
endif

augroup filetype_remaps
  autocmd! BufNewFile,BufRead *.launch setf xml
  " C files with embedded SQL statements are highlighted as standard C files.
  autocmd! BufNewFile,BufRead *.pgc set filetype=c
  "autocmd! BufNewFile,BufRead *.markdown set filetype=mkd
  "autocmd! BufNewFile,BufRead *.md set filetype=mkd
augroup END

augroup comment_line_different_languages
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType h nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType pgc nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType html nnoremap <buffer> <localleader>c I<!--<esc>A-->
augroup END

autocmd! Filetype php set keywordprg=pman
"autocmd! BufNewFile,BufRead *.c,*.h,*.cpp,*.pgc % set formatprg="astyle --mode=c --style=allman -A1s4NCSpwYfUxek1W1yxbjxpxC100"
"autocmd! BufNewFile,BufRead *.c,*.h,*.cpp,*.pgc % set formatprg="astyle --mode=c"
autocmd! FileType c,h,cpp setlocal equalprg=clang-format
