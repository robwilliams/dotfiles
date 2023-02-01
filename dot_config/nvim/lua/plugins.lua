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
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- tsserver = {},

        sumneko_lua = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      --
      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
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

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
      }
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
      'telescope.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
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

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end

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
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() and has_words_before() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end),
        },
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
            -- See where 'Text' is coming from in you completion menu
            vim_item.menu = ({
              nvim_lsp = "ﲳ",
              nvim_lua = "",
              treesitter = "",
              path = "ﱮ",
              buffer = "﬘",
              zsh = "",
              vsnip = "",
              spell = "暈",
              copilot = ""
            })[entry.source.name]

            return vim_item
          end,
        },
        sources = {
          -- Copilot Source
          { name = "copilot", group_index = 2 },
          -- Other Sources
          { name = "treesitter", group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "path", group_index = 2 },
          { name = "buffers", group_index = 2 },
          { name = "luasnip", group_index = 2 },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            require("copilot_cmp.comparators").score,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
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
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      "zbirenbaum/copilot-cmp",
      "onsails/lspkind.nvim",
    },
  },
  { 
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },
  { 
    "zbirenbaum/copilot-cmp",
    config = true,
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').load()
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
    }
  },
  {
    "onsails/lspkind.nvim",
    config = function()
      require('lspkind').init({
        symbol_map = {
          copilot = "",
        },
      })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
    end,
  },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
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
})
