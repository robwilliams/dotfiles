return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = true,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-Enter>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<M-Esc>",
        },
      },
      filetypes = {
        markdown = true, -- overrides default
        yaml = true, -- overrides default
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
    },
  },
}
