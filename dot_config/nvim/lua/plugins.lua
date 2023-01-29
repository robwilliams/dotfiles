require("lazy").setup({
  {
    "navarasu/onedark.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load first
    config = function()
      require("onedark").setup({
        style = "deep"
      })
      vim.cmd([[colorscheme onedark]])
    end,
  },

  -- See `:help lualine.txt`
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "onedark",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },

  -- See `:help gitsigns.txt`
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitGutterAdd", text = "▎" },
          change = { hl = "GitGutterChange", text = "▎" },
          delete = { hl = "GitGutterDelete", text = "▎" },
          topdelete = { hl = "GitGutterDelete", text = "▎" },
          changedelete = { hl = "GitGutterChange", text = "▎" },
        },
      })
    end,
  },

  -- See `:help indent_blankline.txt`
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "▏",
        buftype_exclude = { "terminal" },
        filetype_exclude = { "help", "startify", "dashboard" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
      })
    end,
  },
  -- See `:help telescope` and `:help telescope.setup()`
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      require('telescope').load_extension('projects')
      require("telescope").load_extension("notify")
      
      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })
      
      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- old habits, die hard
      vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Search Files' })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'make'
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section:
        -- https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "fade_in_slide_out",
      })

      vim.notify = require("notify")
    end,
  },
  "christoomey/vim-tmux-navigator",
  "christoomey/vim-tmux-runner",
  "dense-analysis/ale",
  "github/copilot.vim",
  "godlygeek/tabular",
  {
    "mileszs/ack.vim",
    config = function()
      -- uses ripgrep
      -- case-insensitive search unless the search term contains an uppercase letter
      vim.g.ackprg = "rg --vimgrep --no-heading --type-not sql --smart-case"
      vim.g.ack_autoclose = 0
      vim.g.ack_use_cword_for_empty_search = 1
      -- Don't jump to the first match
      vim.cmd([[ cnoreabbrev Ack Ack! ]])

      vim.keymap.set("n", "<leader><leader>", ":Ack!<space>")
      vim.keymap.set("n", "<C-g>", ":Ack!<space>")
      vim.keymap.set("n", "<C-g>", ":Ack!<space>")
    end,
  },
  "neomake/neomake",
  "pbrisbin/vim-mkdir",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  "stefandtw/quickfix-reflector.vim",
  "tpope/vim-endwise",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-rails",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  { 
    "tpope/vim-vinegar",
    config = function()
      vim.keymap.set('n', '<leader>ve', ':Vexplore<CR>', { silent = true })
      vim.keymap.set('n', '<leader>se', ':Sexplore<CR>', { silent = true })
      vim.keymap.set('n', '<leader>e', ':Explore<CR>', { silent = true })
    end,
  },
  "vim-test/vim-test",
})
