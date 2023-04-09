return {
  { "tpope/vim-fugitive", event = "VeryLazy" }, -- git integration
  { "tpope/vim-rhubarb", event = "VeryLazy" }, -- Fugitive github integration
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<CR>", "Open diff view" },
      { "<leader>dc", "<cmd>DiffviewClose<CR>", "Close diff view" },
    },
    config = true,
  },
}
