return {
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    -- Unix commands + :Delete deletes file and buffer https://github.com/tpope/vim-eunuch
    "tpope/vim-eunuch",
    event = "VeryLazy",
  },
  {
    -- Still the most reliable for sending commands to tmux
    "tpope/vim-dispatch",
    keys = {
      { "<leader>dd!", "<cmd>Dispatch!<cr>" },
      { "<leader>dd", "<cmd>Dispatch<cr>" },
    },
    event = "VeryLazy",
    config = function()
      vim.g.dispatch_no_maps = 1
    end,
  },
  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
  },
}
