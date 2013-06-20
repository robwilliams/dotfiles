set nocompatible                  " Must come first because it changes other options.
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ervandew/supertab'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'godlygeek/tabular'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'elixir-lang/vim-elixir'

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set t_Co=256                      " 256 colors.
set mouse=a                       " Enable mouse support.

set autoindent                    " Indentation and
set smartindent                   " Smart indentation

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore+=.git,.bundle

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set ls=2

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Disable swap files

set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs
set laststatus=2                  " Show the status line all the time

set ttymouse=xterm2               " Allows mouse support to work in a tmux session
set pastetoggle=<F2>              " Allows you to paste from clipboard without auto-indent.

set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" Intelligent search settings
set colorcolumn=80

colorscheme railscasts-256

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>

" CtrlP
let g:ctrlp_working_path_mode = 0

" NetRW Mappings
nmap <leader>e :Explore<cr>
nmap <leader>ve :Vexplore<cr>
nmap <leader>se :Sexplore<cr>

nmap <C-N><C-N> :set invnumber<CR> " Double Tap ctrl+n to toggle line numbers.

" Remove trailing whitespace with :RMTWS.
command! RMTWS :execute '%s/\s\+$//e'

let LOCALVIMRC = expand("~/.vimrc.local")
if filereadable(LOCALVIMRC)
  exe "source " . LOCALVIMRC
endif
