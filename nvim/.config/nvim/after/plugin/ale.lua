vim.g.ale_enabled = false
vim.g.ale_fixers = {
    ["*"] = {"trim_whitespace", "remove_trailing_lines"},
    ["json"] = {"jq"},
    ["python"] = {"yapf", "isort"},
}
vim.g.ale_json_jq_options = "-S"
vim.g.ale_fix_on_save = true
