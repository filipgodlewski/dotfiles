return {
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    config = function()
      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
      else
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
      end
      table.insert(require("dap").configurations.python, 1, {
        type = "python",
        request = "launch",
        name = "file:root",
        program = "${file}",
        cwd = "${workspaceFolder}",
      })
    end,
  },
}
