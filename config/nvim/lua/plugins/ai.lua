return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
    },
    opts = {
      provider = "claude",
      providers = {
        claude = { api_key_name = "ANTHROPIC_API_KEY" },
        openai = { api_key_name = "OPENAI_API_KEY" },
      },
      mode = "legacy",
      behaviour = {
        auto_add_current_file = true,
        auto_apply_diff_after_generation = false,
        auto_approve_tool_permissions = false,
      },
      system_prompt = [[
When the active buffer is a Norg note, interpret its metadata, heading hierarchy, links, and TODO states as structure. Use only the current note and explicitly attached context, and say when related notes are not included. When drafting Jira issues, separate the summary, description, acceptance criteria, and subtasks. Do not create or update Jira issues unless explicitly asked.
]],
    },
    keys = {
      { "<leader>an", "<cmd>AvanteToggle<cr>", desc = "AI: Ask about current note" },
      { "<leader>ap", "<cmd>AvanteSwitchProvider<cr>", desc = "AI: Switch provider" },
    },
  },
}
