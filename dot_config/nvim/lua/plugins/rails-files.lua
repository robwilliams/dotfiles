-- TODO: Move to find_files_scoped.lua or extension
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local find_files_scoped = function(opts)
  opts.search_dir = opts.search_dir or ""
  opts.prompt_title = opts.prompt_title or "Find files"
  opts.file_suffix = opts.file_suffix or ""
  opts.file_extension = opts.file_extension or ""
  -- TODO: Loop through projectionist values to create each picker?
  -- TODO: Would git churn be a good sorter?
  -- TODO: Action to open alternate file (using projectionist-vim)
  -- TODO: It doesn't look like path_display allows extensions to be removed (hide_extension), might be a good PR (https://github.com/nvim-telescope/telescope.nvim/blob/942fe5faef47b21241e970551eba407bc10d9547/lua/telescope/utils.lua#L196)
  -- TODO : Could provide camelised class name in display too (More rails convention specific)
  opts.entry_maker = function(line)
    -- Remove search_dirs and path before them
    local scoped_line = line
    scoped_line = scoped_line:gsub(".*" .. opts.search_dir .. "/", "")

    -- Remove extension
    scoped_line = scoped_line:gsub(opts.file_suffix, "")
    scoped_line = scoped_line:gsub(opts.file_extension, "")

    return { ordinal = scoped_line, display = scoped_line, value = line }
  end

  -- TODO: Extension needs to be included in fd, but we need to be able to supply multiple
  -- TODO: Extension is currently taking out the first char so .erb will gsub to . as well as .rb to blank
  pickers
    .new({
      finder = finders.new_oneshot_job({ "fd", ".", opts.search_dir }, opts),
      sorter = conf.generic_sorter(opts),
    }, opts)
    :find()
end

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- {
      --   "<leader>fra",
      --   function()
      --     find_files_scoped({
      --       prompt_title = "Rails App Dir",
      --       search_dir = "app",
      --     })
      --   end,
      --   desc = "Find all files in /app (RW)",
      -- },
      -- {
      --   "<leader>frc",
      --   function()
      --     find_files_scoped({
      --       prompt_title = "Rails Controllers",
      --       search_dir = "app/controllers",
      --       file_suffix = "_controller",
      --       file_extension = ".rb",
      --     })
      --   end,
      --   desc = "Find controllers (RW)",
      -- },
      -- {
      --   "<leader>frm",
      --   function()
      --     find_files_scoped({
      --       prompt_title = "Rails Models",
      --       search_dir = "app/models",
      --       file_extension = ".rb",
      --     })
      --   end,
      --   desc = "Find Rails models (RW)",
      -- },
      -- {
      --   "<leader>frv",
      --   function()
      --     find_files_scoped({
      --       prompt_title = "Rails Views",
      --       search_dir = "app/views",
      --       file_extension = ".rb",
      --     })
      --   end,
      --   desc = "Find Rails views (RW)",
      -- },
      -- {
      --   "<leader>fvc",
      --   function()
      --     find_files_scoped({
      --       prompt_title = "Rails View Components",
      --       search_dir = "app/components",
      --       file_suffix = "_component",
      --       file_extension = ".rb",
      --     })
      --   end,
      --   desc = "Find Rails view components (RW)",
      -- },
      -- {
      --   "<leader>fsc",
      --   function()
      --     find_files_scoped({
      --       prompt_title = "Stimulus Controllers",
      --       search_dir = "app/javascript/controllers",
      --       file_extension = ".js",
      --       file_suffix = "_controller",
      --     })
      --   end,
      --   desc = "Find Stimulus controllers (RW)",
      -- },
    },
    opts = {
      defaults = {},
    },
  },
}
