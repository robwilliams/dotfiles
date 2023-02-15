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
    "RRethy/vim-illuminate",
    event = "InsertEnter",
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
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ["<C-q>"] = function(bufnr)
                require("telescope.actions").smart_send_to_qflist(bufnr)
                require("telescope.builtin").quickfix()
              end,
              ["<C-h>"] = "which_key",
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      require('telescope').load_extension('projects')
      require("telescope").load_extension("notify")


      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader>pb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })

      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]roject [F]ind Files' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find Git Files' })
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "rcarriga/nvim-notify",
    },
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
      vim.keymap.set('n', '<C-g>', ':Ack! ')
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
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>')
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
    end,
  },
  "tpope/vim-rails",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  "vim-test/vim-test",
  {
    "tpope/vim-vinegar",
    config = function()
      vim.keymap.set('n', '<leader>ve', ':Vexplore<CR>', { silent = true })
      vim.keymap.set('n', '<leader>se', ':Sexplore<CR>', { silent = true })
      vim.keymap.set('n', '<leader>e', ':Explore<CR>', { silent = true })
      vim.g.splitbelow = true
      vim.g.splitright = true
    end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    config = function()
      local lsp = require("lsp-zero")

      lsp.preset("recommended")

      lsp.ensure_installed({
        'tsserver',
        'sumneko_lua',
        'rust_analyzer',
      })

      -- Fix Undefined global 'vim'
      lsp.configure('sumneko_lua', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })


      local cmp = require('cmp')
      local cmp_select = {behavior = cmp.SelectBehavior.Select}
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-f>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })

      cmp_mappings['<Tab>'] = nil
      cmp_mappings['<S-Tab>'] = nil

      lsp.setup_nvim_cmp({
        mapping = cmp_mappings
      })

      lsp.set_preferences({
        suggest_lsp_servers = true,
        sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I'
        }
      })

      lsp.on_attach(function(client, bufnr)
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end)

      lsp.setup()
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

      vim.diagnostic.config({
        virtual_text = true
      })
    end,
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional
      { "onsails/lspkind.nvim" },

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  },
  -- Language servers
  --{
    --"williamboman/mason.nvim",
    --config = function()
      --require("mason").setup()
      --local servers = {
        --"ansiblels",
        --"cssls",
        --"dockerls",
        --"eslint",
        --"html",
        --"solargraph",
        --"stylelint_lsp",
        --"sumneko_lua",
        --"tailwindcss",
        --"terraformls",
        --"tflint",
        --"tsserver",
        --"yamlls",
      --}

      --require("mason-null-ls").setup({
        --automatic_setup = true,
      --})

      --local mason_lspconfig = require 'mason-lspconfig'
      --mason_lspconfig.setup({
        --ensure_installed = servers,
      --})

      --require("lsp-format").setup()

      --local on_attach = function(client, bufnr)
        --require("lsp-format").on_attach(client)

        --local nmap = function(keys, func, desc)
          --if desc then
            --desc = 'LSP: ' .. desc
          --end

          --vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        --end

        --nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        --nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        --nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        --nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        --nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        --nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        --nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        --nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        ---- See `:help K` for why this keymap
        --nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        --nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        ---- Lesser used LSP functionality
        --nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        --nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        --nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        --nmap('<leader>wl', function()
          --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, '[W]orkspace [L]ist Folders')
      --end

      --require("neodev").setup(); -- has to be before lspconfig

      --require 'mason-null-ls'.setup_handlers()
      --mason_lspconfig.setup_handlers {
        --function(server_name) -- default handler (optional)
          --require("lspconfig")[server_name].setup({
            --on_attach = on_attach,
            --capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
          --})

        --end,
      --}
    --end,
    --dependencies = {
      --"williamboman/mason-lspconfig.nvim",
      --'jose-elias-alvarez/null-ls.nvim',
      --"neovim/nvim-lspconfig",
      --"nvim-lua/plenary.nvim",
      --"nvim-lua/popup.nvim",
      --"folke/neodev.nvim",
      --"lukas-reineke/lsp-format.nvim",
      --"jay-babu/mason-null-ls.nvim",
    --},
  --},
  {
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  -- Shows what nvim-lsp is doing
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
      vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
      vim.opt.undofile = true
    end,
  },
  {
    'eandrju/cellular-automaton.nvim',
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
      vim.keymap.set("n", "<leader>fts", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
  },

  -- Autocompletion
  --{
    --'hrsh7th/nvim-cmp',
    --event = "InsertEnter",
    --config = function()
      --local cmp = require 'cmp'
      --local lspkind = require 'lspkind'
      --local luasnip = require 'luasnip'

      --local has_words_before = function()
        --unpack = unpack or table.unpack
        --local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        --return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      --end

      --cmp.setup {
        --snippet = {
          --expand = function(args)
            --require('luasnip').lsp_expand(args.body)
          --end,
        --},
        --mapping = {
          --['<C-k>'] = cmp.mapping.select_prev_item(),
          --['<C-j>'] = cmp.mapping.select_next_item(),
          --['<C-d>'] = cmp.mapping.scroll_docs(-4),
          --['<C-f>'] = cmp.mapping.scroll_docs(4),
          --['<C-e>'] = cmp.mapping.close(),
          --["<Tab>"] = cmp.mapping(function(fallback)
            --if cmp.visible() then
              --cmp.select_next_item()
              ---- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              ---- they way you will only jump inside the snippet region
            --elseif luasnip.expand_or_jumpable() then
              --luasnip.expand_or_jump()
            --elseif has_words_before() then
              --cmp.complete()
            --else
              --fallback()
            --end
          --end, { "i", "s" }),
          --["<S-Tab>"] = cmp.mapping(function(fallback)
            --if cmp.visible() then
              --cmp.select_prev_item()
            --elseif luasnip.jumpable(-1) then
              --luasnip.jump(-1)
            --else
              --fallback()
            --end
          --end, { "i", "s" }),
        --},
        --formatting = {
          --format = lspkind.cmp_format({
            --mode = 'symbol',
            --with_text = false,
            --maxwidth = 50
          --}),
        --},
        --sources = {
          ---- Other Sources
          --{ name = "treesitter" },
          --{ name = "nvim_lsp" },
          --{ name = "path" },
          --{ name = "buffer" },
          --{ name = "luasnip" },
          --{ name = "calc" },
          --{ name = "git" },
          --{ name = "lua" },
        --},
        --window = {
          --documentation = {
            --border = "rounded",
            --winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
          --},
          --completion = {
            --border = "rounded",
            --winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
          --},
        --},
        --experimental = {
          --ghost_text = false,
        --},
      --}
    --end,
    --dependencies = {
      --"hrsh7th/cmp-buffer",
      --"hrsh7th/cmp-calc",
      --"hrsh7th/cmp-git",
      --"hrsh7th/cmp-nvim-lua",
      --"hrsh7th/cmp-path",
      --"onsails/lspkind.nvim",
      --"zbirenbaum/copilot-cmp",
      --'L3MON4D3/LuaSnip',
      --'hrsh7th/cmp-nvim-lsp',
      --'saadparwaiz1/cmp_luasnip',
    --},
  --},
  { "sindrets/diffview.nvim" },
  { "preservim/nerdcommenter" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "github/copilot.vim",
    config = function()
      --vim.keymap.set('i', '<C-Space>', "copilot#Accept(<Tab>)", { silent = true, expr = true, script = true })
      --["<C-J>"] = { "copilot#Accept(<Tab>)", silent = true, expr = true, script = true },
    end,

  },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      --pcall(require('nvim-treesitter.install').update { with_sync = true })
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require('nvim-treesitter.configs').setup {
          -- A list of parser names, or "all"
        ensure_installed = { "help", "javascript", "typescript", "lua" },

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
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

      require('treesitter-context').setup {
        enable = true,
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-context',
    },
  },
})
