return {
  { "tpope/vim-fugitive" }, -- git integration
  { "tpope/vim-rhubarb" }, -- Fugitive github integration
  {
    "sindrets/diffview.nvim",
    keys = {
      { "n", "<leader>dv", "<cmd>DiffviewOpen<CR>", "Open diff view" },
      { "n", "<leader>dc", "<cmd>DiffviewClose<CR>", "Close diff view" },
    },
    config = true,
  },
}
