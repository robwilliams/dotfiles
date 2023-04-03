return {
  {
    "tpope/vim-eunuch",
    command = {
      "Delete",
      "Move",
      "Rename",
      "SudoWrite",
      "Unlink",
      "Copy",
      "Duplicate",
    },
  },
  {
    "tpope/vim-projectionist",
    config = function()
      vim.g.rails_projections = {
        ["app/components/*.rb"] = {
          type = "component",
          alternate = {
            "app/components/{}.html.erb",
            "spec/components/{}_spec.rb",
          },
        },
        ["app/components/*.html.erb"] = {
          type = "component",
          alternate = {
            "spec/components/{}_spec.rb",
            "app/components/{}.rb",
          },
        },
        ["spec/components/*_spec.rb"] = {
          type = "component",
          alternate = {
            "app/components/{}.rb",
            "app/components/{}.html.erb",
          },
        },
      }
    end,
  },
  { "tpope/vim-rails" },
  { "tpope/vim-dispatch" },
}
