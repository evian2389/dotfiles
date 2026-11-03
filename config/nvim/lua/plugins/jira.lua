local jira_env_keys = {
  "JIRA_URL",
  "JIRA_BASE_URL",
  "JIRA_SERVER",
  "JIRA_EMAIL",
  "JIRA_USER",
  "JIRA_USERNAME",
  "JIRA_API_TOKEN",
  "JIRA_TOKEN",
  "JIRA_PAT",
  "JIRA_PERSONAL_ACCESS_TOKEN",
  "JIRA_PERSONAL_TOKEN",
  "JIRA_AUTH_TYPE",
  "JIRA_API_VERSION",
}

local function first_nonempty(values, keys)
  for _, key in ipairs(keys) do
    local value = values[key]
    if value and value ~= "" then
      return value
    end
  end
end

local function load_jira_env()
  local env_path = vim.fn.expand("~/.env")
  if vim.fn.filereadable(env_path) ~= 1 then
    return false, "Cannot read ~/.env"
  end

  local ok, lines = pcall(vim.fn.readfile, env_path)
  if not ok then
    return false, "Failed to read ~/.env: " .. tostring(lines)
  end

  local values = {}
  -- Read Jira assignments only; never execute ~/.env as shell code.
  for line_number, line in ipairs(lines) do
    local content = line:gsub("^%s*export%s+", "")
    if content:match("^%s*JIRA_") then
      local key, raw_value = content:match("^%s*([%a_][%w_]*)%s*=%s*(.-)%s*$")
      if not key then
        return false, string.format("Invalid Jira variable in ~/.env at line %d", line_number)
      end

      local value = vim.trim(raw_value)
      local quote = value:sub(1, 1)
      if quote == "'" or quote == '"' then
        local closing_quote = value:find(quote, 2, true)
        if not closing_quote then
          return false, string.format("Unclosed quote in ~/.env at line %d", line_number)
        end
        local suffix = vim.trim(value:sub(closing_quote + 1))
        if suffix ~= "" and suffix:sub(1, 1) ~= "#" then
          return false, string.format("Invalid value in ~/.env at line %d", line_number)
        end
        value = value:sub(2, closing_quote - 1)
      else
        value = vim.trim(value:gsub("%s+#.*$", ""))
      end

      values[key] = value
    end
  end

  for _, key in ipairs(jira_env_keys) do
    vim.env[key] = nil
  end
  for key, value in pairs(values) do
    vim.env[key] = value
  end

  local base = first_nonempty(values, { "JIRA_BASE_URL", "JIRA_URL", "JIRA_SERVER" })
  if base then
    vim.env.JIRA_BASE_URL = base
  end

  local token = first_nonempty(values, {
    "JIRA_API_TOKEN",
    "JIRA_TOKEN",
    "JIRA_PAT",
    "JIRA_PERSONAL_ACCESS_TOKEN",
    "JIRA_PERSONAL_TOKEN",
  })
  if token then
    vim.env.JIRA_API_TOKEN = token
  end

  if not first_nonempty(values, { "JIRA_AUTH_TYPE" })
    and first_nonempty(values, { "JIRA_PERSONAL_ACCESS_TOKEN", "JIRA_PERSONAL_TOKEN" })
  then
    vim.env.JIRA_AUTH_TYPE = "bearer"
  end

  return true
end

local env_loaded, env_error = load_jira_env()
if not env_loaded then
  vim.notify("Jira environment: " .. env_error, vim.log.levels.WARN)
end

local function reload_jira_auth()
  local ok, err = load_jira_env()
  if not ok then
    vim.notify("Jira environment: " .. err, vim.log.levels.ERROR)
    return
  end

  local auth = require("jira.common.auth")
  if auth.load() then
    vim.notify(
      "A saved Jira auth file overrides ~/.env. Run :Jira auth logout to switch to environment-only auth; no file was changed.",
      vim.log.levels.WARN
    )
    return
  end

  local credentials = auth.get_auth()
  local missing = {}
  if not credentials.base or credentials.base == "" then
    table.insert(missing, "JIRA_URL")
  end
  if not credentials.token or credentials.token == "" then
    table.insert(missing, "JIRA_PERSONAL_ACCESS_TOKEN or JIRA_API_TOKEN")
  end
  if not auth.is_bearer(credentials.type) and (not credentials.email or credentials.email == "") then
    table.insert(missing, "JIRA_EMAIL or JIRA_USERNAME")
  end

  if #missing > 0 then
    vim.notify("Missing Jira environment variables: " .. table.concat(missing, ", "), vim.log.levels.ERROR)
    return
  end

  vim.notify("Jira credentials loaded from ~/.env; no auth file was written.", vim.log.levels.INFO)
end

return {
  {
    "letieu/jira.nvim",
    cmd = { "Jira" },
    opts = {
      jira = {
        api_version = "3",
        limit = 200,
        logging = false,
      },
      active_sprint_query = "project = '%s' AND sprint in openSprints() ORDER BY Rank ASC",
      queries = {
        ["Next sprint"] = "project = '%s' AND sprint in futureSprints() ORDER BY Rank ASC",
        ["Backlog"] = "project = '%s' AND (issuetype IN standardIssueTypes() OR issuetype = Sub-task) AND (sprint IS EMPTY OR sprint NOT IN openSprints()) AND statusCategory != Done ORDER BY Rank ASC",
        ["My Tasks"] = "assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
      },
    },
    keys = {
      { "<leader>jj", "<cmd>Jira<cr>", desc = "Jira: Open project board" },
      { "<leader>jc", "<cmd>Jira create<cr>", desc = "Jira: Create issue" },
      { "<leader>ja", reload_jira_auth, desc = "Jira: Reload auth from ~/.env" },
    },
  },
}
