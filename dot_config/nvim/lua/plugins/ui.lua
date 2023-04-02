return {
  {
    "navarasu/onedark.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load first
    config = function()
      require("onedark").setup({
        style = "deep",
      })
    end,
  },

  -- Configure LazyVim to load onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
  {
    "christoomey/vim-tmux-navigator",
  },
}
