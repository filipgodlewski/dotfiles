local null_ls = require "null-ls"

local in_place_formatter = function(fts, command, args)
   return {
      method = null_ls.methods.FORMATTING,
      filetypes = fts,
      generator = null_ls.formatter {
         command = command,
         args = args,
         to_stdin = false,
         format = nil,
         to_temp_file = true,
         from_temp_file = true,
      },
   }
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_save = function(bufnr)
   vim.lsp.buf.format {
      bufnr = bufnr,
      timeout_ms = 2000,
      filter = function(client) return client.name == "null-ls" end,
   }
end

local on_attach = function(client, bufnr)
   if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
         group = augroup,
         buffer = bufnr,
         callback = function() on_save(bufnr) end,
      })
   end
end

null_ls.setup { on_attach = on_attach }

null_ls.register {
   name = "python_helpers",
   filetypes = { "python" },
   sources = {
      in_place_formatter({ "python" }, "tidy-imports", { "--unaligned", "--replace", "$FILENAME" }),
      in_place_formatter({ "python" }, "auto-optional", { "$FILENAME" }),
   },
}

null_ls.register {
   name = "python_default",
   filetypes = { "python" },
   sources = {
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
   },
}

null_ls.register {
   name = "markdown_default",
   filetype = { "markdown" },
   sources = { null_ls.builtins.diagnostics.markdownlint },
}

null_ls.register {
   name = "json_default",
   filetypes = { "json" },
   sources = { null_ls.builtins.formatting.fixjson },
}

null_ls.register {
   name = "lua_default",
   filetypes = { "lua" },
   sources = { null_ls.builtins.formatting.stylua },
}

null_ls.register {
   name = "toml_default",
   filetypes = { "toml" },
   sources = { null_ls.builtins.formatting.taplo },
}
