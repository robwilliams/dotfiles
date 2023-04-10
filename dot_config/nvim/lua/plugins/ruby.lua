return {
  { "vim-ruby/vim-ruby", event = "VeryLazy" },
  { "tpope/vim-rails", event = "VeryLazy", dev = true },
  { "tpope/vim-bundler", event = "VeryLazy" },
  { "tpope/vim-rake", event = "VeryLazy" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {
          root_dir = function(fname)
            return require("lspconfig").util.root_pattern("Gemfile", ".git")(fname) or vim.fn.getcwd()
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ruby" })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      table.insert(opts.sources, null_ls.builtins.formatting.rubocop)
      table.insert(opts.sources, null_ls.builtins.diagnostics.rubocop)
    end,
  },
}
