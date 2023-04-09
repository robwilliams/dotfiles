return {
  {
    "vim-test/vim-test",
    lazy = true,
    keys = {
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test Nearest (RW)" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File (RW)" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test Last (RW)" },
    },
    config = function()
      vim.g["test#strategy"] = "dispatch"
    end,
    dependencies = {
      "tpope/vim-dispatch",
    },
  },
}
