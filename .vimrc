set nocompatible
filetype off

set incsearch
set hlsearch
set ignorecase

set tabstop=4
set shiftwidth=4
set ruler
set showcmd		" display incomplete commands
set autoindent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup	
syntax enable

set history=50		" keep 50 lines of command line history



au BufRead,BufNewFile *.ejs set filetype=html

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Solarized'
Bundle 'daveray/vimclojure-easy'
Bundle 'VimClojure'

Bundle 'elzr/vim-json'

filetype plugin indent on
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"
map <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>


" Ctrl-P settings
 let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\._',
  \ 'link': 'some_bad_symbolic_links',
  \ }

nmap <Leader><Left> :tabp<CR>
nmap <Leader><Right> :tabn<CR>

set background=dark
colorscheme solarized

set number

nnoremap <CR> :noh<CR><CR>


