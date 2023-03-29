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
  {
    -- See `:help lualine.txt`
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "onedark",
          globalstatus = true,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        extensions = {
          'quickfix',
          'fugitive',
          'nvim-tree',
          'fzf',
          'toggleterm'
        }
      })
    end,
  },
  {
    -- See `:help gitsigns.txt`
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
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
  {
    -- See `:help indent_blankline.txt`
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        char = "▏",
        buftype_exclude = { "terminal", "quickfix", "nofile", "help", "alpha", "dashboard", "packer", "lspinfo" },
        filetype_exclude = { "help", "alpha", "dashboard" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "CursorHold",
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
  {
    "mrjones2014/legendary.nvim",
    config = function()
      require('legendary').setup({ which_key = { auto_register = true } })
      -- now this will register them with both which-key.nvim and legendary.nvim (if there is any)
      -- require('which-key').register(your_which_key_tables, your_which_key_opts)
      vim.keymap.set('n', '<C-t>', "<cmd>Legendary<CR>", { desc = 'Open legendary' })
      vim.keymap.set('n', '<C-t><C-t>', "<esc>", { desc = 'Close legendary' })
    end,
    dependencies = {
      'kkharji/sqlite.lua',
    },
  },
  {
    "mcauley-penney/tidy.nvim",
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          -- FIX:
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          -- TODO:
          TODO = { icon = " ", color = "info" },
          -- HACK:
          HACK = { icon = " ", color = "warning" },
          -- WARN:
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          -- PERF:
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          -- NOTE:
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
      })
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },
  { "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- {
  --   "folke/trouble.nvim",
  --   config = function()
  --     require("trouble").setup({
  --       auto_open = false,
  --       auto_close = true,
  --       auto_preview = true,
  --       auto_fold = true,
  --       signs = {
  --         error = "",
  --         warning = "",
  --         hint = "",
  --         information = "",
  --         other = "﫠",
  --       },
  --       use_diagnostic_signs = true,
  --     })
  --     vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  --       { silent = true, noremap = true }
  --     )
  --     vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  --       { silent = true, noremap = true }
  --     )
  --     vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  --       { silent = true, noremap = true }
  --     )
  --     vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  --       { silent = true, noremap = true }
  --     )
  --     vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  --       { silent = true, noremap = true }
  --     )
  --     vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  --       { silent = true, noremap = true }
  --     )
  --     vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>",
  --       { silent = true, noremap = true }
  --     )
  --     vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>",
  --       { silent = true, noremap = true }
  --     )
  --   end,
  -- },
  {
    -- See `:help telescope` and `:help telescope.setup()`
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      local telescopeConfig = require("telescope.config")

      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      -- exclude the `.git` directory.
      table.insert(vimgrep_arguments, "!**/.git/*")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = require("telescope.actions").move_selection_next,
              ["<C-p>"] = require("telescope.actions").move_selection_previous,
              ["<C-h>"] = "which_key",
              ["<esc>"] = require("telescope.actions").close,
              ["<C-f>"] = require("telescope.actions").close, -- acts like a toggle
            },
          },
        },
        pickers = {
          defaults = {
            -- `hidden = true` is not supported in text grep commands.
            vimgrep_arguments = vimgrep_arguments,
          },
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            mappings = {
              n = {
                ["cd"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                  require("telescope.actions").close(prompt_bufnr)
                  -- Depending on what you want put `cd`, `lcd`, `tcd`
                  vim.cmd(string.format("silent lcd %s", dir))
                end
              }
            }
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          }
        }
      })

      require("telescope").load_extension("rails")

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, 'fzf')

      telescope.load_extension("notify")
      telescope.load_extension("ui-select")

      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<C-g>', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = 'Find files using [g]rep' })

      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find existing [b]uffers' })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find [c]ommands' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find [d]iagnostics' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find [h]elp' })
      vim.keymap.set('n', '<leader>fn', require 'telescope'.extensions.notify.notify, { desc = 'Find [n]otifications' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find [r]ecently opened files' })
      vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find [s]tring' })
      vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<cr>", { desc = 'Find [t]odos' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find current [w]ord' })
      vim.keymap.set('n', '<leader>rs', ':Telescope rails specs<CR>', { desc = 'Find rails specs'})
      vim.keymap.set('n', '<leader>rc', ':Telescope rails controllers<CR>', { desc = 'Find rails controllers' })
      vim.keymap.set('n', '<leader>rm', ':Telescope rails models<CR>', { desc = 'Find rails models' })
      vim.keymap.set('n', '<leader>rv', ':Telescope rails views<CR>', { desc = 'Find rails views'})
      vim.keymap.set('n', '<leader>ri', ':Telescope rails migrations<CR>', {desc = 'Find rails migrations'})
      vim.keymap.set('n', '<leader>rl', ':Telescope rails libs<CR>', { desc = 'Find rails libs'})
    end,
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "sato-s/telescope-rails.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'make'
  },
  -- {
  --   "folke/noice.nvim",
  --   config = function()
  --     require("noice").setup({
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true,
  --         },
  --       },
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         bottom_search = true, -- use a classic bottom cmdline for search
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = true, -- enables an input dialog for inc-rename.nvim
  --       },
  --       cmdline_popup = {
  --         border = {
  --           style = "none",
  --           padding = { 2, 3 },
  --         },
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  -- },
  -- {
  --   -- https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
  --   "ahmedkhalf/project.nvim",
  --   config = function()
  --     require("project_nvim").setup({
  --       detection_methods = { "pattern", "lsp" },
  --     })
  --   end,
  -- },
  "christoomey/vim-tmux-navigator",
  "christoomey/vim-tmux-runner",
  "godlygeek/tabular",
  "neomake/neomake",
  "pbrisbin/vim-mkdir",
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  "stefandtw/quickfix-reflector.vim",
  "tpope/vim-endwise",
  "tpope/vim-projectionist",
  "tpope/vim-vinegar",
  "tpope/vim-eunuch",
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>')
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
    end,
  },
  "tpope/vim-rails",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.keymap.set('n', '<leader>t', ':TestNearest<CR>')
      vim.keymap.set('n', '<leader>f', ':TestFile<CR>')
      vim.keymap.set('n', '<leader>l', ':TestLast<CR>')
    end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    config = function()
      local lspkind = require 'lspkind'
      lspkind.init({ mode = 'symbol' })

      local lsp = require('lsp-zero').preset({
        name = 'minimal',
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = true,
      })

      lsp.nvim_workspace()

      lsp.ensure_installed({
        'lua_ls'
      })

      -- Fix Undefined global 'vim'
      lsp.configure('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          },
        }
      })

      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local mapping = lsp.defaults.cmp_mappings({
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
      })

      lsp.setup_nvim_cmp({
        mapping = mapping,
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
          })
        },
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp', keyword_length = 1 },
          { name = 'buffer',   keyword_length = 3 },
          { name = 'luasnip',  keyword_length = 2 },
          { name = 'git' },
        }
      })

      -- `/` cmdline setup.
      -- cmp.setup.cmdline('/', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })

      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline({}),
      --   sources = cmp.config.sources({
      --     {
      --       name = 'cmdline',
      --       option = {
      --         ignore_cmds = { 'Man', '!' }
      --       }
      --     },
      --   })
      -- })

      require("mason-null-ls").setup({
        automatic_setup = true,
      })

      require("lsp-format").setup()

      lsp.on_attach(function(client, bufnr)
        require("lsp-format").on_attach(client)

        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap("[d", vim.diagnostic.goto_next)
        nmap("]d", vim.diagnostic.goto_prev)
        nmap("<leader>rf", vim.lsp.buf.references)
        nmap("<C-h>", vim.lsp.buf.signature_help)


        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

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
        vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
      end)

      require("neodev").setup(); -- has to be before lspconfig
      lsp.setup()

      vim.diagnostic.config({
        virtual_text = true
      })

      require 'luasnip'.filetype_extend("ruby", { "rails" })
    end,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { 'williamboman/mason.nvim' }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      { "onsails/lspkind.nvim" },
      { "folke/neodev.nvim" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' }, -- Optional
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-path' }, -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional
      { 'hrsh7th/cmp-git' }, -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional


      { 'jose-elias-alvarez/null-ls.nvim' },
      { "lukas-reineke/lsp-format.nvim" },
      { "jay-babu/mason-null-ls.nvim" },
    }
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
        }
      })
    end
  },
  -- {
  --   'ThePrimeagen/harpoon',
  --   config = function()
  --     require('harpoon').setup()
  --     local mark = require("harpoon.mark")
  --     local ui = require("harpoon.ui")

  --     vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon [a]dd file" })
  --     vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "[C-e] Open Harpoon quick menu" })

  --     vim.keymap.set("n", "<leader>h1", function() ui.nav_file(2) end)
  --     vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end)
  --     vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end)
  --     vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end)
  --   end,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  -- },
  -- {
  --   'goolord/alpha-nvim',
  --   config = function()
  --     require 'alpha'.setup(require 'alpha.themes.startify'.config)
  --   end
  -- },
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
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup()
      vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>")
      vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>")
    end,
  },
  { "nvim-tree/nvim-web-devicons" },
  { "github/copilot.vim" },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require('nvim-treesitter.configs').setup {
        -- Automatically install missing parsers when entering buffer
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
        autotag = {
          enable = true,
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
      'nvim-treesitter/playground',
      'windwp/nvim-ts-autotag',
    },
  },
})
