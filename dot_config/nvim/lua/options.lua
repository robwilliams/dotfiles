---[[ opts.lua ]]
-- See `:help vim.o`
-- See `:help vim.g`
-- See `:help vim.wo`

local g = vim.g
local o = vim.o
local wo = vim.wo

o.nocompatible = true

-- Set 256 colours.
g.t_co = 256
o.termguicolors = true

g.background = "dark"

-- Show cursor position.
g.ruler = true

-- Set highlight on search.
o.hlsearch = false

-- Make line numbers default.
wo.number = true

o.nu = true

-- Enable mouse mode.
o.mouse = 'a'

-- Enable break indent.
o.breakindent = true

-- Save undo history.
o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search.
o.ignorecase = true
o.smartcase = true

-- Decrease update time.
o.updatetime = 250

-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved..
wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience.
o.completeopt = 'menuone,noselect'

-- Give more space for displaying messages.
o.cmdheight = 2

-- Don't pass messages to |ins-completion-menu|.
o.shortmess = o.shortmess .. "c"

-- Indentation and..
o.autoindent = true

-- Smart indentation
o.smartindent = true

-- Treat '-' as part of word (for tab completion, etc)
vim.opt.iskeyword:append("-")

-- Display incomplete commands.
o.showcmd = true

-- Display the mode you're in.
o.showmode = true

-- Intuitive backspacing.
o.backspace = "indent,eol,start"

-- Enhanced command line completion.
o.wildmenu = true

-- Complete files like a shell.
o.wildmode = "list:longest"
o.wildignore = o.wildignore .. ".git,.bundle"

o.ls=2

-- Highlight matches as you type.
o.incsearch = true

-- Highlight matches.
o.hlsearch = true

-- Turn off line wrapping.
o.wrap = false

-- Show 8 lines of context around the cursor.
o.scrolloff = 8

-- Set the terminal's title.
o.title = true

-- No beeping.
o.visualbell = true
 
-- Don't make a backup before overwriting a file.
o.nobackup = true
o.nowritebackup = true

-- Disable swap files.
o.swapfile = false

-- Global tab width.
o.tabstop = 2
o.shiftwidth = 2

-- Use spaces instead of tabs.
o.expandtab = true

-- Show the status line all the time.
o.laststatus = 2

-- Open new split panes to right and bottom, which feels more natural.
o.splitbelow = true
o.splitright = true

-- Allows you to paste from clipboard without auto-indent.
o.pastetoggle = "<F2>"

-- Don't have a need for perl and keeps checkhealth clean.
g.loaded_perl_provider = 0

-- Use ripgrep for searching.
g.grepprg = "rg --vimgrep --no-heading --smart-case --hidden --follow --glob '!{.git,node_modules}/*'"
g.grepformat = "%f:%l:%c:%m,%f:%l:%m"
