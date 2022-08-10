local M = {}

M.padding = "  "

M.colors = {
   active = "%#MsgArea#",
   directory = "%#Directory#",
   gray = "%#NonText#",
   diagnostic_error = "%#DiagnosticError#",
   diagnostic_warn = "%#DiagnosticWarn#",
   diagnostic_info = "%#DiagnosticInfo#",
   diagnostic_hint = "%#DiagnosticHint#",
}

function M.levels(self)
   return {
      git_status = {
         { type = "added", color = self.colors.diagnostic_info },
         { type = "changed", color = self.colors.diagnostic_hint },
         { type = "removed", color = self.colors.diagnostic_error },
      },
      lsp_diagnostic = {
         { severity = vim.diagnostic.severity.ERROR, color = self.colors.diagnostic_error },
         { severity = vim.diagnostic.severity.WARN, color = self.colors.diagnostic_warn },
         { severity = vim.diagnostic.severity.INFO, color = self.colors.diagnostic_info },
         { severity = vim.diagnostic.severity.HINT, color = self.colors.diagnostic_hint },
      }
   }
end

function M.get_git_branch()
   local git_signs = vim.b.gitsigns_status_dict
   local head = git_signs ~= nil and git_signs.head or "--"
   return " " .. head
end

function M.get_git_status(self)
   local git_signs = vim.b.gitsigns_status_dict
   local levels = self:levels()

   if git_signs == nil then return "" end

   local git_status_numbers = ""
   for _, sign in ipairs(levels.git_status) do
      local number = git_signs[sign.type]
      local is_positive = number ~= nil and number > 0
      git_status_numbers = git_status_numbers .. (is_positive and string.format("%s %s  ", sign.color, number) or "")
   end

   local is_git_status_empty = git_status_numbers:len() == 0
   return not is_git_status_empty and git_status_numbers:sub(1, #git_status_numbers - 2) or ""
end

function M.get_file_info(self)
   local modified = vim.bo.modified and (self.colors.diagnostic_error .. " SAVE  ") or ""
   local readonly = (not vim.bo.modifiable or vim.bo.readonly) and (self.colors.diagnostic_warn .. " RO  ") or ""
   local additional_info = modified .. readonly
   local has_additional_info = modified:len() ~= 0 or readonly:len() ~= 0
   return has_additional_info and additional_info:sub(1, #additional_info - 2) or ""
end

function M.get_filetype()
   return require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype, { default = true })
end

function M.get_lsp_diagnostic(self)
   local result = ""
   local levels = self:levels()

   for _, diagnostic in ipairs(levels.lsp_diagnostic) do
      local diagnostics = vim.diagnostic.get(0, { severity = diagnostic.severity })
      result = result .. (#diagnostics ~= 0 and (diagnostic.color .. " " .. tostring(#diagnostics) .. "  ") or "")
   end
   if result:len() ~= 0 then result:sub(1, #result - 2) end

   return result
end

function M.get_lightbulb()
   local lightbulb = require('nvim-lightbulb').get_status_text()
   return lightbulb ~= "" and lightbulb .. " Aha!" or ""
end

function M.get_directory(self)
   local gps = require("nvim-gps")
   local breadcrumbs = ""
   if gps.is_available() then
      local location = gps.get_location()
      breadcrumbs = location ~= "" and " > " .. location or ""
   end
   local filetype = self:get_filetype()
   return filetype .. (filetype ~= "" and " " or "") .. "%f" .. breadcrumbs
end

function M.pad(self, text, color)
   if text == "" then return "" end
   local text_color = color or ""
   return self.padding .. text_color .. text .. self.padding
end

function M.set_active_statusline(self)
   return table.concat({
      self.colors.active,
      self:pad(self:get_file_info()),
      self:pad("line: %l/%L, column: %c", self.colors.gray),
      self:pad(self:get_git_branch(), self.colors.diagnostic_warn),
      self:pad(self:get_git_status()),
      self:pad(self:get_directory(), self.colors.directory),
      self:pad(self:get_lsp_diagnostic()),
      self:pad(self:get_lightbulb(), self.colors.diagnostic_hint),
   })
end

--[[ function M.set_active_winbar(self)
   return table.concat({
      self.colors.active,
      "%=", -- move everything to right side
      self:pad(self:get_file_info()),
      self:pad(self:get_lsp_diagnostic()),
      self:pad("%f", self.colors.directory),
   })
end ]]

Statusline = setmetatable(M, { __call = function(statusline) return statusline:set_active_statusline() end })
-- Winbar = setmetatable(M, { __call = function(winbar) return winbar:set_active_winbar() end })

vim.opt.statusline = "%!v:lua.Statusline()"
-- vim.opt.winbar = "%!v:lua.Winbar()" -- TODO: Wait for neovim 0.8
