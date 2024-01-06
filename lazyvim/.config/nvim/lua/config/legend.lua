---@type table<string, table<string, string>>
local H = {}

H["neotest-summary"] = {
  name = "Neotest summary mappings",
  a = "Attach",
  M = "Clear marked",
  T = "Clear target",
  d = "Debug",
  D = "Debug marked",
  ["<CR>"] = "Expand",
  e = "Expand all",
  i = "Jump to",
  m = "Mark",
  J = "Next failed",
  o = "Output",
  K = "Previous failed",
  r = "Run",
  R = "Run marked",
  O = "Short output",
  u = "Stop",
  t = "Target",
  w = "Watch",
}

H["Outline"] = {
  name = "Symbols outline mappings",
  ["<ESC>"] = "close",
  ["<CR>"] = "goto location",
  ["<C-Space>"] = "hover symbol",
  q = "close",
  a = "code actions",
  o = "focus location",
  h = "fold",
  W = "fold all",
  R = "fold reset",
  r = "rename symbol",
  K = "toggle preview",
  l = "unfold",
  E = "unfold all",
}

return H
