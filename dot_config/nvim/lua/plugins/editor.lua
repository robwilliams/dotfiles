return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<C-P>", "<cmd>Telescope find_files<cr>", desc = "Find Files (RW)" },
      { "<Space>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers (RW)" },
      {
        "<C-G>",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
        end,
        desc = "Find files using grep (RW)",
      },
    },
    opts = {
      defaults = {},
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      {
        "<leader>fe",
        "<cmd>Telescope file_browser<cr>",
        desc = "Telescope File Browser (root dir) RW",
      },
      {
        "<leader>fE",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "Telescope File Browser (cwd) (RW)",
      },
      { "<leader>e", "<leader>fe", desc = "Telescope File Browser (root dir) (RW)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Telescope File Browser (cwd) (RW)", remap = true },
      { "-", "<leader>fE", desc = "Telescope File Browser (cwd vinegar) (RW)", remap = true },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
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
    -- readline mappings
    "tpope/vim-rsi",
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
}
