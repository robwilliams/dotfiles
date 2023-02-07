require("lazy").setup({
  {
    "navarasu/onedark.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load first
    config = function()
      require("onedark").setup({
        style = "deep"
      })
      vim.cmd([[colorscheme onedark]])
    end,
  },
  -- See `:help lualine.txt`
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "onedark",
          component_separators = "▎",
          section_separators = "",
        },
      })
    end,
  },

  -- See `:help gitsigns.txt`
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitGutterAdd", text = "▎" },
          change = { hl = "GitGutterChange", text = "▎" },
          delete = { hl = "GitGutterDelete", text = "▎" },
          topdelete = { hl = "GitGutterDelete", text = "▎" },
          changedelete = { hl = "GitGutterChange", text = "▎" },
        },
      })
    end,
  },

  -- See `:help indent_blankline.txt`
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "▏",
        buftype_exclude = { "terminal" },
        filetype_exclude = { "help", "startify", "dashboard" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
      })
    end,
  },
  { "RRethy/vim-illuminate" },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
  -- See `:help telescope` and `:help telescope.setup()`
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      require('telescope').load_extension('projects')
      require("telescope").load_extension("notify")

      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })

      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- old habits, die hard
      vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Search Files' })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'make'
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section:
        -- https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "fade_in_slide_out",
      })

      vim.notify = require("notify")
    end,
  },
  "christoomey/vim-tmux-navigator",
  "christoomey/vim-tmux-runner",
  -- "dense-analysis/ale",
  "godlygeek/tabular",
  {
    "mileszs/ack.vim",
    config = function()
      -- uses ripgrep
      -- case-insensitive search unless the search term contains an uppercase letter
      vim.g.ackprg = "rg --vimgrep --no-heading --type-not sql --smart-case"
      vim.g.ack_autoclose = 0
      vim.g.ack_use_cword_for_empty_search = 1
      -- Don't jump to the first match
      vim.cmd([[ cnoreabbrev Ack Ack! ]])

      vim.keymap.set("n", "<leader><leader>", ":Ack!<space>")
      vim.keymap.set("n", "<C-g>", ":Ack!<space>")
      vim.keymap.set("n", "<C-g>", ":Ack!<space>")
    end,
  },
  "neomake/neomake",
  "pbrisbin/vim-mkdir",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  "stefandtw/quickfix-reflector.vim",
  "tpope/vim-endwise",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-rails",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  {
    "tpope/vim-vinegar",
    config = function()
      vim.keymap.set('n', '<leader>ve', ':Vexplore<CR>', { silent = true })
      vim.keymap.set('n', '<leader>se', ':Sexplore<CR>', { silent = true })
      vim.keymap.set('n', '<leader>e', ':Explore<CR>', { silent = true })
    end,
  },
  "vim-test/vim-test",
  -- Language servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      local servers = {
        "ansiblels",
        "cssls",
        "dockerls",
        "eslint",
        "sorbet",
        "terraformls",
        "tflint",
        "tsserver",
        "yamlls",
        "sumneko_lua"
      }

      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup({
        ensure_installed = servers,
      })

      require("lsp-format").setup()

      local on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)

        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      require("neodev").setup(); -- has to be before lspconfig

      mason_lspconfig.setup_handlers {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
          })

        end,
      }
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "folke/neodev.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
  },
  -- Shows what nvim-lsp is doing
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    config = function()
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'

      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            with_text = false,
            maxwidth = 50
          }),
        },
        sources = {
          -- Other Sources
          { name = "treesitter" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "calc" },
          { name = "git" },
          { name = "lua" },
        },
        window = {
          documentation = {
            border = "rounded",
            winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
          },
          completion = {
            border = "rounded",
            winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
          },
        },
        experimental = {
          ghost_text = true,
        },
      }
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-git",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "zbirenbaum/copilot-cmp",
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  { "sindrets/diffview.nvim" },
  { "preservim/nerdcommenter" },
  { "nvim-tree/nvim-web-devicons" },
  { "github/copilot.vim" },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').load()
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
    }
  },
  { "onsails/lspkind.nvim" },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls');
      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.gitrebase,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.ansiblelint,
          null_ls.builtins.diagnostics.dotenv_linter,
          null_ls.builtins.diagnostics.erb_lint,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.fish,
          null_ls.builtins.diagnostics.gitlint,
          null_ls.builtins.diagnostics.hadolint, -- docker brew install hadolint
          null_ls.builtins.diagnostics.jshint,
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.standardrb,
          null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.diagnostics.tidy,
          null_ls.builtins.diagnostics.trail_space,
          null_ls.builtins.diagnostics.tsc,
          null_ls.builtins.diagnostics.vint,
          null_ls.builtins.diagnostics.write_good,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.beautysh,
          null_ls.builtins.formatting.cbfmt,
          null_ls.builtins.formatting.erb_lint,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.mdformat,
          null_ls.builtins.formatting.nginx_beautifier,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.pg_format,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.shellharden,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.standardrb,
          null_ls.builtins.formatting.stylelint,
          null_ls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "postgres" }, -- change to your dialect
          }),
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.tidy,
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.hover.printenv,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },
})
