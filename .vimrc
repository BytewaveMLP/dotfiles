" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Turn on syntax highlighting
syntax on

filetype plugin indent on

" Security
set modelines=0


set number
set ruler
set visualbell
set tabstop=4
set encoding=utf-8

set wrap
set textwidth=79
set formatoptions=tcqrn1

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Formatting
map <leader>q gqip
