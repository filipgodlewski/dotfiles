local function toggle_coverage()
  ---@module 'coverage.signs'
  local coverage = require("coverage")
  if require("coverage.signs").is_enabled() then
    coverage.hide()
  else
    require("coverage").load(true)
  end
end

---@return integer
local function get_height()
  return math.min(math.floor(vim.o.lines / 2) - 3, 30)
end

---@param main snacks.win
---@param create boolean
---@return snacks.win?
local function get_uv_term(main, create)
  local icon, icon_hl = Snacks.util.icon("python", "filetype")
  local term, _ = Snacks.terminal.get({ "uv", "run", "python" }, {
    create = create,
    win = {
      title = {
        { " " },
        { icon .. string.rep(" ", 2 - vim.api.nvim_strwidth(icon)), icon_hl },
        { " " },
        { "REPL" },
        { " " },
      },
      title_pos = "center",
      width = 100,
      height = get_height,
      backdrop = false,
      row = function()
        return get_height() + 3
      end,
      minimal = true,
      border = "rounded",
      zindex = 100,
      keys = {
        q = false,
      },
    },
  })
  main:focus()
  vim.cmd("stopinsert")
  return term
end

return {
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    config = function()
      require("dap-python").setup("uv")
      table.insert(require("dap").configurations.python, 1, {
        type = "python",
        request = "launch",
        name = "file:root",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      })
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    optional = true,
    enabled = true,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {
          python = ".venv/bin/python",
        },
      },
    },
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("coverage").setup({
        auto_reload = true,
        lang = {
          python = {
            coverage_command = "uv run coverage json -q -o -",
          },
        },
      })
    end,
    keys = {
      { "<leader>cc", desc = "Coverage" },
      { "<leader>cct", toggle_coverage, desc = "Toggle coverage" },
      { "<leader>ccs", "<cmd>CoverageSummary<cr>", desc = "Show coverage summary" },
    },
  },
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      scratch = {
        ft = "python",
        win = {
          row = 1,
          height = get_height,
          ---@param self snacks.win
          on_close = function(self)
            local term = get_uv_term(self, false)
            if term then
              vim.schedule(function()
                vim.api.nvim_chan_send(vim.b[term.buf].terminal_job_id, "\x03") -- <C-c>
                vim.api.nvim_chan_send(vim.b[term.buf].terminal_job_id, "exit()\n")
              end)
            end
          end,
        },
        win_by_ft = {
          python = {
            keys = {
              ["start"] = {
                "R",
                function(self)
                  get_uv_term(self, true)
                end,
                desc = "Re/Start REPL",
                mode = { "n" },
              },
              ["send"] = {
                "<CR>",
                ---@param self snacks.win
                function(self)
                  local term
                  vim.schedule(function()
                    term = get_uv_term(self, false)
                  end)

                  if not vim.wait(500, function()
                    return term ~= nil
                  end) then
                    vim.notify("First, start the REPL")
                    return
                  end

                  local text
                  local lines = {}
                  local mode = vim.fn.mode()
                  if mode == "n" then
                    text = vim.api.nvim_get_current_line()
                    table.insert(lines, text)
                  else
                    if mode == "v" then
                      vim.cmd("normal! v")
                    elseif mode == "V" then
                      vim.cmd("normal! V")
                    end
                    local from = vim.api.nvim_buf_get_mark(self.buf, "<")
                    local to = vim.api.nvim_buf_get_mark(self.buf, ">")
                    lines = vim.api.nvim_buf_get_text(self.buf, from[1] - 1, from[2], to[1] - 1, to[2] + 1, {})
                    if #lines > 1 then
                      table.insert(lines, "")
                    end
                  end

                  for _, line in ipairs(lines) do
                    vim.api.nvim_chan_send(vim.b[term.buf].terminal_job_id, "\x15") -- <c-u>
                    vim.api.nvim_chan_send(vim.b[term.buf].terminal_job_id, line .. "\n")
                  end
                end,
                desc = "Send",
                mode = { "n", "x" },
              },
            },
          },
        },
      },
    },
  },
}
