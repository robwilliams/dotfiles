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

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme onehalfdark
highlight ColorColumn ctermbg=0

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

command -nargs=+ -complete=file -bar Copy saveas %:p:h/<args> " Like :saveas but saves to the current directory.

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>


" No arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" === Fern ===
nmap <leader>e :Fern %:h<cr>
let g:fern#renderer = "nerdfont"

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END

" === deoplete  ===
let g:deoplete#enable_at_startup = 1
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

" === ale ===
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'autoimport'],
\}

" === fzf ===
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

" bind K to grep word under cursor
nnoremap K :Rg <C-R><C-W><CR>
" bind K to grep selection
vnoremap K y:Rg <C-r>"<CR>

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ -S
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

let LOCALVIMRC = expand("~/.vimrc.local")

if filereadable(LOCALVIMRC)
  exe "source " . LOCALVIMRC
endif
