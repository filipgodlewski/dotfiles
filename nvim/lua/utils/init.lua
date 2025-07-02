local M = {}

function M.print_outdated_mason_packages()
  for _, pkg in ipairs(require("mason-registry").get_installed_packages()) do
    pkg:check_new_version(function(is_new)
      if is_new then
        io.write(pkg.name .. "\n")
      end
    end)
  end
end

return M
