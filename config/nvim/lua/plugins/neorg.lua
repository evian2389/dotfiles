return {
  "nvim-neorg/neorg",
  version = "*",
  lazy = false,
  init = function()
    -- Neorg loads before Lazy adds LuaRocks parser paths to package.cpath.
    local rock_root = vim.fn.stdpath("data") .. "/lazy-rocks"
    for _, parser in ipairs({
      { lang = "norg", rock = "tree-sitter-norg" },
      { lang = "norg_meta", rock = "tree-sitter-norg-meta" },
    }) do
      local paths = vim.fn.glob(
        rock_root .. "/" .. parser.rock .. "/lib*/lua/5.1/parser/" .. parser.lang .. ".so",
        false,
        true
      )
      if paths[1] then
        vim.treesitter.language.add(parser.lang, { path = paths[1] })
      end
    end
  end,
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            neovim = "~/notes/neovim",
          },
          default_workspace = "neovim",
          open_last_workspace = "default",
          index = "index.norg",
        },
      },
      ["core.journal"] = {
        config = {
          workspace = "neovim",
          journal_folder = "journal",
          strategy = "nested",
        },
      },
      ["core.qol.todo_items"] = {},
      ["core.summary"] = {},
    },
  },
  keys = {
    { "<leader>nn", "<cmd>Neorg workspace neovim<cr>", desc = "Neorg: Open workspace" },
    { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Neorg: Open index" },
    { "<leader>nt", "<cmd>edit ~/notes/neovim/tasks.norg<cr>", desc = "Neorg: Open tasks" },
    { "<leader>nj", "<cmd>Neorg journal today<cr>", desc = "Neorg: Open today's journal" },
  },
}
