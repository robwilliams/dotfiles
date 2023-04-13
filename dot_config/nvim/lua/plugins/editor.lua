return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      pcall(require("telescope").load_extension, 'fzf')
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<C-P>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<Space>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      {
        "<C-G>",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
        end,
        desc = "Find files using grep",
      },
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
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
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
