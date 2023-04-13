return {
  { "vim-ruby/vim-ruby", event = "VeryLazy" },
  { "tpope/vim-rails", event = "VeryLazy" },
  { "tpope/vim-bundler", event = "VeryLazy" },
  { "tpope/vim-rake", event = "VeryLazy" },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "ruby-lsp")
      table.insert(opts.ensure_installed, "rubocop")
      table.insert(opts.ensure_installed, "sorbet")
      table.insert(opts.ensure_installed, "erb-lint")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        standardrb = {},
        ruby_ls = {},
        sorbet = {},
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "ruby",
        })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      table.insert(opts.sources, null_ls.builtins.formatting.rubocop)
      table.insert(opts.sources, null_ls.builtins.formatting.erb_lint)
      table.insert(opts.sources, null_ls.builtins.diagnostics.erb_lint)
    end,
  },
}
