let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"

set encoding=utf-8

let mapleader = ","
let g:airline_powerline_fonts=1
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" add python support to neovim
let g:python_host_prog = '/usr/local/opt/python/libexec/bin/python'

source ~/.vimrc.vundle
source ~/.vimrc.add-ons
source ~/.vimrc.key_mappings

map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <F3> :call TextWrap()<CR>
map <F4> :call TextWidth()<CR>

" tmux-vim-navigator bindings - use ctrl-arrows
set tabstop=2  " a tab is two spaces
set sw=2
set shiftwidth=2 " an autoindent (with <<) is two spaces
set expandtab " use spaces, not tabs
set winwidth=84
set nowrap  " don't wrap lines
set list " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set relativenumber
set nojoinspaces    " don't add double spaces at the end of sentences
set pastetoggle=<F2>

" split panes nicely
set splitbelow
set splitright

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

" use par for formatting
set formatprg=par\ -w80

"" Searching
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

"" Backup and swap files
set backupdir=$HOME/.vim/_backup//    " where to put backup files.
set directory=$HOME/.vim/_temp//      " where to put swap files.

" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=15
set winminheight=15
set winheight=999

" highlight beyond 80 characters
let &colorcolumn=join(range(81,337),",")
hi ColorColumn guibg=#2d2d2d ctermbg=Grey

" make insert mode clearer
autocmd InsertEnter,InsertLeave * set cul!

runtime macros/matchit.vim

:set tags=./tags;~

function! TextWrap()
  set wrap linebreak nolist
endfunction

function! TextWidth()
  set textwidth=79
endfunction

function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype !='diff'
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endif
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
hi Repeat guibg=#2020d0 ctermbg=blue

set spelllang=en_gb
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd FileType gitcommit setlocal spell

let g:daylight_morning_color_gvim = "github"
let g:daylight_afternoon_color_gvim = "github"
let g:daylight_evening_color_gvim = "railscasts"
let g:daylight_late_color_gvim = "railscasts"

let g:daylight_morning_color_term = "github"
let g:daylight_afternoon_color_term = "github"
let g:daylight_evening_color_term = "railscasts"
let g:daylight_late_color_term = "railscasts"

let g:daylight_morning_hour = 6
let g:daylight_afternoon_hour = 12
let g:daylight_evening_hour = 18
let g:daylight_late_hour = 22

" Create function to highlight repeated rows and mark them blue
function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

set nohidden

source ~/.vimrc.local
