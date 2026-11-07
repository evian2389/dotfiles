-- Email client for Neovim, driven by the himalaya CLI v2 (+ sirup sockets).
-- Requires `himalaya` on PATH (see non-guix-packages.sh). Config:
-- ~/.config/himalaya/config.toml. Mail data stays off disk (tmpfs only).
return {
  {
    "knownasnaffy/himalaya.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "Himalaya", "HimalayaWrite", "HimalayaSearch", "HimalayaAccounts" },
    keys = {
      { "<leader>oh", "<Cmd>Himalaya<CR>", desc = "Open Himalaya (mail)" },
    },
    opts = {
      icons_enabled = true,
      wrap_folder_navigation = true,
    },
  },
}
