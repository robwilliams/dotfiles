return {
  {
    "sindrets/diffview.nvim",
    lazy = true,
    command = "DiffviewOpen",
    config = function()
      require("diffview").setup()
      -- TODO: Move keymaps out
      vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>")
      vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>")
    end,
  },
}
