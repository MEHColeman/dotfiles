set encoding=utf-8

let mapleader = ","
let g:airline_powerline_fonts=1

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
"
" My Bundles here:
"
" original repos on github
" i want to use ctags too
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-scripts/vroom'

" Language support
" (I found these via carlhuda/janus)
Bundle 'tpope/vim-bundler'
Bundle 'kchmck/vim-coffee-script'
Bundle 'chrisbra/csv.vim'
Bundle 'tpope/vim-cucumber'
Bundle 'elixir-lang/vim-elixir'
Bundle 'jimenezrick/vimerl'
Bundle 'tpope/vim-git'
Bundle 'jnwhiteh/vim-golang'
Bundle 'tpope/vim-haml'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-markdown'
Bundle 'sunaku/vim-ruby-minitest'
Bundle 'mmalecki/vim-node.js'
Bundle 'ajf/puppet-vim'
Bundle 'tpope/vim-rails'
Bundle 'skwp/vim-rspec'
Bundle 'vim-ruby/vim-ruby'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'slim-template/vim-slim'
Bundle 'timcharper/textile.vim'

" vim-scripts repos
"Bundle 'L9'
Bundle 'AutoTag'
" non github repos
" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'

filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" KEYS
" ----
"
" Change movement keys for Colemak keyboard
noremap h k
noremap j h
noremap k j

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>

map <leader>t :CtrlP<cr>
map <leader>n :NERDTree<cr>

set tabstop =2
set sw=2

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

" ADDON-OPTIONS
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

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
