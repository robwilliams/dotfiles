call pathogen#infect()

set nocompatible                  " Must come first because it changes other options.

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

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

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

" Useful status information at bottom of screen
set statusline=[%L]               " Total lines
set statusline+=%f                " Path to the file
set statusline+=%=                " Switch to the right side

set ttymouse=xterm2               " Allows mouse support to work in a tmux session
set pastetoggle=<F2>              " Allows you to paste from clipboard without auto-indent.

set background=dark
colorscheme solarized

call togglebg#map("<F6>")

command -nargs=* FindReplace call FindReplace(<f-args>)
function! FindReplace(find, replace)
  exe ':args `ack -l ' . a:find . '`'
  exe ':argdo %s/' . a:find . '/' . a:replace . '/gc | update'
endfunction

map <leader>fr :FindReplace 

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Buffer mappings.
map <leader>bb :badd 
map <leader>bc :bdelete<cr>
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>

nmap <leader>a :Ack 

" Vimux Mappings
let VimuxUseNearestPane = 1
map <leader>vp :VimuxPromptCommand<CR>
map <leader>vl :VimuxRunLastCommand<CR>

" CtrlP Mappings
nmap <leader>t :CtrlP<cr>

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" NERDTree Mappings
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<CR>   " Finds the current file and selects it

nmap <C-N><C-N> :set invnumber<CR> " Double Tap ctrl+n to toggle line numbers.

" Remove trailing whitespace with :RMTWS.
command! RMTWS :execute '%s/\s\+$//e'

" NERDTree config
let NERDTreeChDirMode=2
" let NERDTreeShowBookmarks=1
let NERDTreeHightlightCursorline=1

" Intelligent search settings
set incsearch
set ignorecase
set wildmenu
set wildignore+=.git,.bundle

" Highlight long lines.
if version >= 703
  highlight ColorColumn ctermbg=233
  set cc=+1 tw=80
endif

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE

let LOCALVIMRC = expand("~/.vimrc.local")
if filereadable(LOCALVIMRC)
  exe "source " . LOCALVIMRC 
endif
