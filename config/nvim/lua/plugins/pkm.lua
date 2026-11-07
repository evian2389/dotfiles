-- PKM: edit the ai-wiki as an OKF (Open Knowledge Format v0.2) bundle.
-- Bundle root: <pkm_root>/docs. Override with `vim.g.pkm_root = "/path/to/ai-wiki"`.
-- Uses only built-in Telescope pickers (see navigation.lua) and marksman from
-- LazyVim's lang.markdown extra for link navigation. No extra plugins.
local function root()
  return vim.fn.expand(vim.g.pkm_root or "~/work/ai-wiki")
end

local function docs()
  return root() .. "/docs"
end

local function today()
  return os.date("%Y-%m-%d")
end

local function slugify(s)
  s = s:lower():gsub("[^%w]+", "-"):gsub("^-+", ""):gsub("-+$", "")
  return s
end

local function new_note()
  vim.ui.input({ prompt = "Title: " }, function(title)
    if not title or title == "" then
      return
    end
    vim.ui.select({ "How-To", "Concept", "Reference", "Meta", "Plan", "Spec" }, { prompt = "type" }, function(ty)
      if not ty then
        return
      end
      local layer = ({ ["How-To"] = "howto", Concept = "concept", Reference = "reference", Meta = "meta" })[ty]
        or "reference"
      vim.ui.input({ prompt = "Subdir under docs/ (e.g. guix): " }, function(sub)
        sub = sub or ""
        local dir = docs() .. (sub ~= "" and ("/" .. sub) or "")
        vim.fn.mkdir(dir, "p")
        local path = dir .. "/" .. slugify(title) .. ".md"
        if vim.uv.fs_stat(path) then
          vim.notify("exists: " .. path, vim.log.levels.WARN)
          vim.cmd.edit(path)
          return
        end
        local lines = {
          "---",
          'type: "' .. ty .. '"',
          'title: "' .. title:gsub('"', '\\"') .. '"',
          "tags: []",
          "status: draft",
          "layer: " .. layer,
          "harnesses: [all]",
          "audience: [human, agent]",
          "updated: " .. today(),
          "---",
          "",
          "# " .. title,
          "",
          "> TL;DR: ",
          "",
          "## See Also",
          "",
        }
        vim.fn.writefile(lines, path)
        vim.cmd.edit(path)
        vim.api.nvim_win_set_cursor(0, { 14, 9 })
      end)
    end)
  end)
end

local function run(cmd, on_done)
  vim.system(cmd, { text = true }, function(res)
    vim.schedule(function()
      local out = (res.stdout or "") .. (res.stderr or "")
      vim.notify(out ~= "" and out or ("exit " .. res.code), res.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
      if on_done then
        on_done(res)
      end
    end)
  end)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      {
        "<leader>kf",
        function()
          require("telescope.builtin").find_files({ cwd = docs(), prompt_title = "Wiki notes" })
        end,
        desc = "PKM: find note",
      },
      {
        "<leader>kg",
        function()
          require("telescope.builtin").live_grep({ cwd = docs(), prompt_title = "Wiki grep" })
        end,
        desc = "PKM: grep notes",
      },
      {
        "<leader>kb",
        function()
          -- backlinks: notes linking to the current file
          local name = vim.fn.expand("%:t")
          require("telescope.builtin").grep_string({ cwd = docs(), search = "](" .. name, prompt_title = "Backlinks: " .. name })
        end,
        desc = "PKM: backlinks to current note",
      },
      {
        "<leader>kt",
        function()
          require("telescope.builtin").live_grep({ cwd = docs(), default_text = "^type: ", prompt_title = "By type" })
        end,
        desc = "PKM: notes by type",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = { spec = { { "<leader>k", group = "pkm (wiki)" } } },
  },
  {
    "LazyVim/LazyVim",
    optional = true,
    init = function()
      local map = vim.keymap.set
      map("n", "<leader>kn", new_note, { desc = "PKM: new note (OKF frontmatter)" })
      map("n", "<leader>ki", function()
        vim.cmd.edit(docs() .. "/index.md")
      end, { desc = "PKM: open index" })
      map("n", "<leader>kl", function()
        vim.cmd.edit(docs() .. "/log.md")
      end, { desc = "PKM: open change log" })
      vim.api.nvim_create_user_command("PkmNormalize", function(o)
        local cmd = { root() .. "/scripts/okf-normalize.py" }
        if o.bang then
          table.insert(cmd, "--apply")
        end
        run(cmd)
      end, { bang = true, desc = "OKF normalize (dry-run; ! to apply)" })
      vim.api.nvim_create_user_command("PkmViz", function()
        local out = vim.fn.stdpath("cache") .. "/pkm-viz.html" -- stays in cache, not in the wiki
        run({ "reference-agent", "visualize", "--bundle", docs(), "--out", out, "--name", "ai-wiki" }, function(res)
          if res.code == 0 then
            vim.ui.open(out)
          end
        end)
      end, { desc = "Render the OKF graph (needs reference-agent) and open it" })
      map("n", "<leader>kN", "<cmd>PkmNormalize<cr>", { desc = "PKM: OKF normalize (dry-run)" })
      map("n", "<leader>kv", "<cmd>PkmViz<cr>", { desc = "PKM: graph view" })
    end,
  },
}
