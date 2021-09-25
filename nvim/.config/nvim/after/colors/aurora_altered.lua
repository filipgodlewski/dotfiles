vim.cmd("runtime lua/aurora.lua")

local C = {
   blue1 = "#4CC7E4",
   br_blue = "#7AA6DA",
   gray4 = "#4F425E",
   green1 = "#9DD067",
   neardark2 = "#211C2F",
   neardark3 = "#282437",
   orange2 = "#FFCE51",
   purple3 = "#7D2C9D",
   red1 = "#F05874",
   red6 = "#D93234",
   textdark = "#b4b0e0",
   yellow = "#ECC48D",
   yellow5 = "#E7DC8C",
}

local color_groups = {
   EndOfBuffer =                   {guifg=C.gray4,    guibg=C.neardark2, gui="none"},
   FloatBorder =                   {guifg=C.orange2,  guibg=C.neardark2, gui="none"},
   NormalFloat =                   {guifg=C.textdark, guibg=C.neardark2, gui="italic"},
   GitGutterAdd =                  {guifg=C.green1,   guibg=C.neardark2, gui="none"},
   GitGutterChange =               {guifg=C.blue1,    guibg=C.neardark2, gui="none"},
   GitGutterChangeDelete =         {guifg=C.purple3,  guibg=C.neardark2, gui="none"},
   GitGutterDelete =               {guifg=C.red1,     guibg=C.neardark2, gui="none"},
   LspDiagnosticsSignError =       {guifg=C.red6,     guibg=C.neardark2, gui="none"},
   LspDiagnosticsSignHint =        {guifg=C.orange2,  guibg=C.neardark2, gui="none"},
   LspDiagnosticsSignInformation = {guifg=C.br_blue,  guibg=C.neardark2, gui="none"},
   LspDiagnosticsSignWarning =     {guifg=C.yellow5,  guibg=C.neardark2, gui="none"},
   SignColumn =                    {guifg="none",     guibg=C.neardark2, gui="none"},
   StatusLine =                    {guifg=C.yellow,   guibg=C.neardark3, gui="none"},
   StatusLineNC =                  {guifg=C.gray4,    guibg=C.neardark2, gui="italic"},
   VertSplit =                     {guifg=C.gray4,    guibg=C.neardark2, gui="none"},
}

for name, settings in pairs(color_groups) do
   vim.cmd("hi clear " .. name)

   local options = " "
   for k, v in pairs(settings) do
      options = options .. k .. "=" .. v .. " "
   end

   vim.cmd("hi " .. name .. options)
end
