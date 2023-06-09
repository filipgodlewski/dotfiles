local pip_cmd = function(params, subcmd)
   assert(vim.env.VIRTUAL_ENV ~= nil, "Must be used with a Python virtual env activated!")
   assert(#params.fargs > 0, "Must specify at least 1 package!")
   vim.cmd(string.format("!python -m pip %s %s", subcmd, params.args))
   vim.schedule(function() vim.cmd "LspRestart" end)
end

vim.api.nvim_create_user_command("PipInstall", function(params) pip_cmd(params, "install") end, { nargs = "*" })
vim.api.nvim_create_user_command("PipUninstall", function(params) pip_cmd(params, "uninstall -y") end, { nargs = "*" })
