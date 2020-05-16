set nocompatible                  " Must come first because it changes other options.
filetype off

let mapleader = " "

runtime macros/matchit.vim        " Load the matchit plugin.

if filereadable(expand("~/.vimrc.plugins"))
  source ~/.vimrc.plugins
endif

syntax on
set t_Co=256                      " 256 colors.
set mouse=a                       " Enable mouse support.

set hidden                     " TextEdit might fail if hidden is not set.
set cmdheight=2                " Give more space for displaying messages.
set updatetime=300             " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set shortmess+=c               " Don't pass messages to |ins-completion-menu|.

set signcolumn=yes             " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.

set autoindent                 " Indentation and
set smartindent                " Smart indentation

set iskeyword +=-              " Treat '-' as part of word (for tab completion, etc)
set showcmd                    " Display incomplete commands.
set showmode                   " Display the mode you're in.

set backspace=indent,eol,start " Intuitive backspacing.

set wildmenu                   " Enhanced command line completion.
set wildmode=list:longest      " Complete files like a shell.
set wildignore+=.git,.bundle

set number                     " Show line numbers.
set ruler                      " Show cursor position.
set ls=2

set incsearch                  " Highlight matches as you type.
set hlsearch                   " Highlight matches.

set wrap                       " Turn on line wrapping.
set scrolloff=3                " Show 3 lines of context around the cursor.

set title                      " Set the terminal's title

set visualbell                 " No beeping.

set nobackup                   " Don't make a backup before overwriting a file.
set nowritebackup              " And again.
set noswapfile                 " Disable swap files

set tabstop=2                  " Global tab width.
set shiftwidth=2               " And again, related.
set expandtab                  " Use spaces instead of tabs
set laststatus=2               " Show the status line all the time

set splitbelow                 " Open new split panes to right and bottom, which feels more natural
set splitright

set pastetoggle=<F2>           " Allows you to paste from clipboard without auto-indent.

set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

set colorcolumn=80

set background=dark

autocmd vimenter * colorscheme gruvbox

" bind K to grep word under cursor
nnoremap K :Ack "<C-R><C-W>"<CR>
" bind K to grep selection
vnoremap K y:Ack "<C-r>""<CR>

nmap <leader><CR> a<CR><Esc> " Insert new line and pop out of insert mode

nnoremap <leader><leader> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <leader><leader> zf

command -nargs=+ -complete=file -bar Copy saveas %:p:h/<args> " Like :saveas but saves to the current directory.

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>

" NetRW Mappings
nmap <leader>e :Explore<cr>
nmap <leader>ve :Vexplore<cr>
nmap <leader>te :Texplore<cr>
nmap <leader>se :Sexplore<cr>

" No arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

let g:ctrlp_working_path_mode = 'r'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:neomake_ruby_enabled_makers = ['rubocop']
call neomake#configure#automake('w') " When writing (no delay)

" The Silver Searcher
if executable('ag')

  let g:ackprg = 'ag -Q --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -Q --follow -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let LOCALVIMRC = expand("~/.vimrc.local")

if filereadable(LOCALVIMRC)
  exe "source " . LOCALVIMRC
endif


