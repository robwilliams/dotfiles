return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-P>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<Space>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    },
    opts = {
      defaults = {
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      },
    },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      {
        "<leader>fe",
        "<cmd>Telescope file_browser<cr>",
        desc = "Telescope File Browser (root dir) ",
      },
      {
        "<leader>fE",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "Telescope File Browser (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "File Browser (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "File Browser (cwd)", remap = true },
      { "-", "<leader>fE", desc = "File Browser (cwd)", remap = true },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    -- https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/
    "mileszs/ack.vim",
    keys = {
      {
        "<C-G>",
        ":Ack<space>",
        desc = "Find files using rgrep",
      },
    },
    config = function()
      vim.g.ackprg = "rg --vimgrep --no-heading --hidden --glob '!**/.git/*' --type-not sql --smart-case"

      -- Auto close the Quickfix list after pressing '<enter>' on a list item
      vim.g.ack_autoclose = 1

      -- Search for word under cursor
      vim.g.ack_use_cword_for_empty_search = 1

      -- TODO: Allow for C-g search for visual selection

      -- Don't jump to the first match
      vim.cmd("cnoreabbrev Ack Ack!")
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        "<cmd>UndotreeToggle<cr>",
        desc = "Undo Tree",
      },
    },
    config = function()
      vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
      vim.opt.undofile = true
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      },
      highlight = {
        before = "",
        keyword = "wide",
        after = "fg",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        delete = { text = "▎" },
        topdelete = { text = "▎" },
      },
    },
  },
  {
    -- automatically detect and set tabstop
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    -- cs"' changes quotes to single quotes https://github.com/tpope/vim-surround
    "tpope/vim-surround",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    -- Adds end automatically
    "tpope/vim-endwise",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    -- coercion https://github.com/tpope/vim-abolish
    "tpope/vim-abolish",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    -- Edit lines of files in a quickfix window
    "stefandtw/quickfix-reflector.vim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    --  It makes the gutter too noisy
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = false },
  },
}
