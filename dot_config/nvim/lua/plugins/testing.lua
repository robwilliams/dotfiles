return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>ctn", "<cmd>TestNearest<cr>", desc = "Test Nearest (RW)" },
      { "<leader>ctf", "<cmd>TestFile<cr>", desc = "Test File (RW)" },
      { "<leader>ctl", "<cmd>TestLast<cr>", desc = "Test Last (RW)" },
    },
    config = function()
      vim.g["test#strategy"] = "dispatch"
    end,
    dependencies = {
      "tpope/vim-dispatch",
    },
  },
  {
    "nvim-neotest/neotest",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec"),
        },
      })
    end,
    keys = {
      { "<leader>cnt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Nearest" },
      { "<leader>cna", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach to the nearest test" },
      { "<leader>cnd", "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", desc = "Debug nearest test" },
      { "<leader>cnf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test File" },
    },
    dependencies = {
      "olimorris/neotest-rspec",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  },
}
