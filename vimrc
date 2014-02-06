set nocompatible                  " Must come first because it changes other options.
filetype off

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'SirVer/ultisnips'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'elixir-lang/vim-elixir'
Bundle 'ervandew/supertab'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'rking/ag.vim'
Bundle 'rodjek/vim-puppet'
Bundle 'scrooloose/nerdcommenter'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'

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

"set number                        " Show line numbers.
set relativenumber                " Relative numbers make jumping easier
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

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set ttymouse=xterm2               " Allows mouse support to work in a tmux session
set pastetoggle=<F2>              " Allows you to paste from clipboard without auto-indent.

set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" Intelligent search settings
set colorcolumn=80

colorscheme railscasts-256

nmap <C-N><C-N> :set invnumber<CR> " Double Tap ctrl+n to toggle line numbers.

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>

" NetRW Mappings
nmap <leader>e :Explore<cr>
nmap <leader>ve :Vexplore<cr>
nmap <leader>se :Sexplore<cr>

" Rspec Mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch zeus rspec {spec}"

let g:ctrlp_working_path_mode = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
let LOCALVIMRC = expand("~/.vimrc.local")

if filereadable(LOCALVIMRC)
  exe "source " . LOCALVIMRC
endif
