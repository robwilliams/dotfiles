return {
  {
    "dense-analysis/ale",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.g.ale_disable_lsp = 1
      vim.g.ale_sign_error = '●'
      vim.g.ale_sign_warning = '.'
      vim.g.ale_lint_on_enter = 0
      vim.g.ale_lint_on_save = 1
      vim.g.ale_lint_on_insert_leave = 1
      vim.g.ale_fix_on_save = 1
      -- " === ale ===
      vim.cmd [[
        let g:ale_linters = {
        \   'javascript': ['eslint', 'autoimport'],
        \   'typescript': ['eslint', 'autoimport'],
        \   'ruby': ['rubocop', 'debride', 'rails_best_practices', 'ruby'],
        \}
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'javascript': ['eslint', 'autoimport','remove_trailing_lines', 'trim_whitespace'],
        \   'typescript': ['eslint', 'autoimport','remove_trailing_lines', 'trim_whitespace'],
        \   'ruby': ['rubocop','remove_trailing_lines', 'trim_whitespace'],
        \}
      ]]
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     table.insert(opts.ensure_installed, "erb-lint")
  --     table.insert(opts.ensure_installed, "rubocop")
  --   end,
  -- },
  {
    "jose-elias-alvarez/null-ls.nvim",
    enabled = false,
    -- opts = function(_, opts)
    --   local null_ls = require("null-ls")
    --   local conditional = function(fn)
    --     local utils = require("null-ls.utils").make_conditional_utils()
    --     return fn(utils)
    --   end
    --
    --   table.insert(opts.sources, null_ls.builtins.formatting.erb_lint)
    --   table.insert(opts.sources, null_ls.builtins.diagnostics.erb_lint)
    --   table.insert(
    --     opts.sources,
    --     conditional(function(utils)
    --       return utils.root_has_file("Gemfile")
    --           and null_ls.builtins.formatting.rubocop.with({
    --             command = "bundle",
    --             args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
    --           })
    --         or null_ls.builtins.formatting.rubocop
    --     end)
    --   )
    --   table.insert(
    --     opts.sources,
    --     conditional(function(utils)
    --       return utils.root_has_file("Gemfile")
    --           and null_ls.builtins.diagnostics.rubocop.with({
    --             command = "bundle",
    --             args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
    --           })
    --         or null_ls.builtins.diagnostics.rubocop
    --     end)
    --   )
    -- end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        ruby_ls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      refactor = {
        highlight_definitions = {
          enable = true,
          -- Set to false if you have an `updatetime` of ~100.
          clear_on_cursor_move = true,
        },
        highlight_current_scope = { enable = true },

        smart_rename = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
          keymaps = {
            smart_rename = "grr",
          },
        },
        navigation = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
          keymaps = {
            goto_definition = false,
            goto_definition_lsp_fallback = "gnd",
            list_definitions = "gnD",
            list_definitions_toc = "gO",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>",
          },
        },
      },
    },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/nvim-treesitter-context", config = true },
      { "nvim-treesitter/playground" },
      {
        "windwp/nvim-ts-autotag",
        opts = {
          filetypes = {
            "eruby",
          },
        },
        config = true,
      },
    },
  },
}
