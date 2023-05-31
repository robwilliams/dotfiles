return {
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline"
      },
      presets = {
        command_palette = false,
      },
      lsp = {
        progress = {
          enabled = false,
        },
        override = {
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        -- don't show messages when buffer is written
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        }
      },
    }
  },
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      {
        "<leader>fml",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Cellular Automaton",
      },
      {
        "<leader>fts",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Cellular Automaton",
      },
    },
  },
}
