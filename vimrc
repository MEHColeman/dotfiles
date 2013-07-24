set encoding=utf-8

let mapleader = ","
let g:airline_powerline_fonts=1

source ~/.vimrc.add-ons
source ~/.vimrc.key_mappings

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

" highlight beyond 80 characters
let &colorcolumn=join(range(81,337),",")
hi ColorColumn guibg=#2d2d2d ctermbg=Grey

runtime macros/matchit.vim

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

"autocmd FileType c,cpp,java,php,ruby,python
autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" I think you need to have the rubocop gem installed for this...
let g:syntastic_ruby_checkers=['rubocop']

source ~/.vimrc.local
