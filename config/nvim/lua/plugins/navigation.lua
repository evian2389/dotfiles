return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find files" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live grep" },
      { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Telescope: Buffers" },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Telescope: Help tags" },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "Harpoon: Add file" })
      vim.keymap.set("n", "<leader>hm", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: Open menu" })

      for index = 1, 4 do
        vim.keymap.set("n", "<leader>h" .. index, function()
          harpoon:list():select(index)
        end, { desc = "Harpoon: Select file " .. index })
      end
    end,
  },
}
