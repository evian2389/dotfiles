local function resolve_reference_path(input, workspace)
  local name = vim.trim(input):gsub("\\", "/")
  local basename = name:match("([^/]+)$")
  if name == "" or name:sub(-1) == "/" or basename == "." or basename == ".." then
    return nil, "Enter a document name or path"
  end

  if not name:match("%.norg$") then
    name = name .. ".norg"
  end

  local path
  if name:sub(1, 2) == "~/" then
    path = vim.fn.expand(name)
  elseif name:sub(1, 1) == "/" then
    path = name
  else
    if not name:find("/", 1, true) then
      name = "references/" .. name
    end
    path = vim.fs.joinpath(workspace, name)
  end

  path = vim.fs.normalize(path)
  local relative = vim.fs.relpath(workspace, path)
  if not relative or relative == ".." or relative:sub(1, 3) == "../" then
    return nil, "Path must stay within the Neorg workspace"
  end
  return path
end

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
        vim.opt.runtimepath:append(vim.fn.fnamemodify(paths[1], ":h:h"))
        vim.treesitter.language.add(parser.lang, { path = paths[1] })
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "norg",
      callback = function(event)
        vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", {
          buffer = event.buf,
          desc = "[neorg] Jump to Link",
        })
        vim.keymap.set("n", "<leader>nl", "<Plug>(neorg.esupports.hop.hop-link)", {
          buffer = event.buf,
          desc = "Neorg: Follow link",
        })
      end,
    })
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
    {
      "<leader>nf",
      function()
        local workspace = vim.fn.expand("~/notes/neovim")
        local copied_path
        Snacks.picker.files({
          cwd = workspace,
          ft = "norg",
          on_change = function(picker, item)
            if picker:current_win() ~= "list" or not item then
              return
            end

            local path = Snacks.picker.util.path(item)
            if not path then
              return
            end
            local relative = vim.fs.relpath(workspace, path)
            if not relative or relative == ".." or relative:sub(1, 3) == "../" then
              return
            end
            if not relative:find("/", 1, true) then
              relative = "./" .. relative
            end

            copied_path = relative
            if picker.input:get() ~= relative then
              picker.input:set(relative, relative)
              picker:find({ refresh = false })
            end
          end,
          actions = {
            confirm = function(picker, item, action)
              local input = vim.trim(picker.input:get())
              local path_changed = copied_path ~= nil and input ~= copied_path
              if item and not path_changed then
                return Snacks.picker.actions.jump(picker, item, action)
              end

              local path, err = resolve_reference_path(input, workspace)
              if not path then
                vim.notify(err, vim.log.levels.WARN)
                return
              end

              local dir = vim.fs.dirname(path)
              picker:norm(function()
                picker:close()
                vim.fn.mkdir(dir, "p")
                if vim.fn.filereadable(path) ~= 1 and vim.fn.writefile({}, path) ~= 0 then
                  vim.notify("Failed to create Neorg document: " .. path, vim.log.levels.ERROR)
                  return
                end
                vim.cmd.edit(vim.fn.fnameescape(path))
              end)
            end,
          },
        })
      end,
      desc = "Neorg: Find/create reference",
    },
    {
      "<leader>ns",
      function()
        Snacks.picker.grep({
          cwd = vim.fn.expand("~/notes/neovim"),
          glob = "*.norg",
        })
      end,
      desc = "Neorg: Search workspace",
    },
    { "<leader>nt", "<cmd>edit ~/notes/neovim/tasks.norg<cr>", desc = "Neorg: Open tasks" },
    { "<leader>nj", "<cmd>Neorg journal today<cr>", desc = "Neorg: Open today's journal" },
  },
}
