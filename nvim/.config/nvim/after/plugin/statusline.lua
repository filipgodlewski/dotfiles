local M = {}

M.padding = "  "

M.colors = {
   active = "%#Normal#",
   directory = "%#Directory#",
   gray = "%#NonText#",
   diagnostic_error = "%#DiagnosticError#",
   diagnostic_warn = "%#DiagnosticWarn#",
   diagnostic_info = "%#DiagnosticInfo#",
   diagnostic_hint = "%#DiagnosticHint#",
}

function M.diagnostic_levels(self)
   return {
      { severity = vim.diagnostic.severity.ERROR, color = self.colors.diagnostic_error },
      { severity = vim.diagnostic.severity.WARN, color = self.colors.diagnostic_warn },
      { severity = vim.diagnostic.severity.INFO, color = self.colors.diagnostic_info },
      { severity = vim.diagnostic.severity.HINT, color = self.colors.diagnostic_hint },
   }
end

function M.get_file_info(self)
   local modified = vim.bo.modified and (self.colors.diagnostic_error .. "󰆓 SAVE  ") or ""
   local readonly = (not vim.bo.modifiable or vim.bo.readonly) and (self.colors.diagnostic_warn .. "  ") or ""
   local additional_info = modified .. readonly
   local has_additional_info = modified:len() ~= 0 or readonly:len() ~= 0
   return has_additional_info and additional_info:sub(1, #additional_info - 2) or ""
end

function M.get_lsp_diagnostic(self)
   local result = ""

   for _, diagnostic in ipairs(self:diagnostic_levels()) do
      local diagnostics = vim.diagnostic.get(0, { severity = diagnostic.severity })
      local exists = #diagnostics ~= 0
      local text = exists and string.format("%s %s  ", diagnostic.color, #diagnostics) or ""
      result = result .. text
   end
   if result:len() ~= 0 then result:sub(1, #result - 2) end

   return result
end

function M.pad(self, text, color)
   if text == "" then return "" end
   local text_color = color or self.colors.active
   return text_color .. self.padding .. text .. self.padding
end

function M.set_active_statusline(self)
   if vim.bo.filetype == "TelescopePrompt" then
      return ""
   else
      return table.concat {
         self.colors.active,
         self:pad(self:get_file_info()),
         self:pad("%f", self.colors.directory),
         self:pad(self:get_lsp_diagnostic()),
         self:pad("󰦺 %-03.v", self.colors.gray),
      }
   end
end

Statusline = setmetatable(M, { __call = function(statusline) return statusline:set_active_statusline() end })
vim.opt.statusline = "%!v:lua.Statusline()"
