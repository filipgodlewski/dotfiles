local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

function table.contains(table, element)
   for _, value in ipairs(table) do
      if value == element then
         return true
      end
   end
   return false
end

local function nl(text)
   return t({ text or "", "" })
end

--- Indented newline text node
---@param text string? Text to be put before newline
local function inl(text)
   return t({ text or "", "\t" })
end

local def = {
   dscr = {
      "Prepare python function.",
      "",
      "Available options as autosnippets:",
      "   @ --> prepare bare def with decorator awaiter",
      "   a --> abstractmethod",
      "   c --> classmethod",
      "   f --> pytest fixture function",
      "   m --> regular method (self)",
      "   s --> staticmethod",
      "   t --> pytest test function",
      "   v --> pydantic validator",
   },
   decorator = {
      ["_"] = {},
      ["@"] = { t("@"), i(1), nl() },
      a = nl("@abstractmethod"),
      c = nl("@classmethod"),
      f = { t("@fixture("), i(1), nl(")") },
      s = nl("@staticmethod"),
      v = { t("@"), i(1), t("validator("), i(2), nl(")"), },
   },
   name = {
      ["_"] = t(""),
      t = t("test_"),
   },
   param = {
      ["_"] = t(""),
      a = t("self"),
      c = t("cls"),
      m = t("self"),
      v = t("cls"),
   },
}

local for_in = {
   dscr = {
      "Prepare python for/in loop",
      "",
      "Available options as autosnippets:",
      "   d --> dict items",
      "   e --> enumerate",
      "   r --> range",
      "   z --> zip",
   },
   params = {
      ["_"] = i(1, "foo"),
      d = { i(1, "k"), t(", "), i(2, "v") },
   },
   iterator = {
      ["_"] = i(1, "foos"),
      d = { i(1, "foos"), t(".items()") },
      e = { t("enumerate("), i(1, "foos"), t(")") },
      r = { t("range("), i(1, "foos"), t(")") },
      z = { t("zip("), i(1, "foos"), t(")") },
   }
}

local comprehensions = {
   dscr = {
      "Prepare python comprehension",
      "",
      "Defaults to simple generator comprehension -- 'comp<c-y>':",
      "   (b for b in bar)",
      "",
      "Available options as autosnippets:",
      "   d -> Dictionary comprehension",
      "   g -> Generator comprehension",
      "   l -> List comprehension",
      "   s -> Set comprehension",
      "",
      "Additionally, by writing those options in uppercase, it will create a local variable assignment expression (e.g. 'compD<space>').",
      "   foo = {k: v for k, v in bar.items()}",
      "Otherwise just the expression:",
      "   {k: v for k, v in bar.items()}",
      "",
      "Also, as a second argument, we can put 'i' to add an if statement at the end (e.g. 'compLi').",
      "   foo = [b for b in bar if is_baz]",
   },
   parens = {
      ["_"] = { "(", ")" },
      d = { "{", "}" },
      g = { "(", ")" },
      l = { "[", "]" },
      s = { "{", "}" },
   },
   args = {
      ["_"] = { { i(1, "b") }, { i(1, "b") } },
      d = { { i(1, "k"), t(": "), i(2, "v") }, { i(1, "k"), t(", "), i(2, "v") } },
   },
   source = {
      ["_"] = i(1, "bar"),
      d = i(1, "bar.items()"),
   },
   if_statement = {
      ["_"] = {},
      i = { t(" if "), i(1, "is_baz") },
   },
}

local first_param_regex = "[(][*]*([%w_]+)"
local next_params_regex = ", [*]*([%w_]+)"
local general_params_regex = "([%w_]+)[,%s)]"
local rtype_regex = " -> (.*):$"

local function isempty(value)
   return value == nil or value == ""
end

local function insert_def_params(match, tab, cnt)
   if isempty(match) then return tab, cnt end
   if #match > 0 then
      table.insert(tab, inl())
      table.insert(tab, t(":param " .. match .. ": "))
      table.insert(tab, i(cnt, match .. " description"))
      cnt = cnt + 1
   end
   return tab, cnt
end

local function insert_init_params(match, tab, cnt)
   if isempty(match) then return tab, cnt end
   if #match > 0 then
      table.insert(tab, inl())
      table.insert(tab, t("self."))
      table.insert(tab, i(1, match))
      table.insert(tab, t(" = "))
      table.insert(tab, t(match))
      cnt = cnt + 1
   end
   return tab, cnt
end

local function to_init_assign(args)
   local tab = {}
   local cnt = 1

   local params_source = args[1][1]
   if #params_source ~= 0 then
      for next_params in string.gmatch(params_source, next_params_regex) do
         tab, cnt = insert_init_params(next_params, tab, cnt)
      end
   end

   return sn(nil, tab)
end

local function to_for_in_assign(args)
   local tab = {}
   local cnt = 1
   local params_source = isempty(args[1]) and {} or args[1][1]

   if #params_source ~= 0 then
      for _ in string.gmatch(params_source, general_params_regex) do
         table.insert(tab, i(cnt, "arg" .. cnt))
         table.insert(tab, t(", "))
         cnt = cnt + 1
      end
      if #tab ~= 0 then table.remove(tab, #tab) end
   end
   return sn(nil, tab)
end

local function to_fn_docstring_assign(args, insert_first_param)
   local tab = { t([["""]]), i(1, "TODO: Short summary"), nl("."), inl(), i(2, "TODO: Long description..."), nl(), }
   local cnt = 3

   local params_source = args[1][1]
   if #params_source ~= 0 then
      if insert_first_param then
         tab, cnt = insert_def_params(string.match(params_source, first_param_regex), tab, cnt)
      end
      for next_params in string.gmatch(params_source, next_params_regex) do
         tab, cnt = insert_def_params(next_params, tab, cnt)
      end
   end

   local rtype_source = isempty(args[2]) and " -> None:" or args[2][1]
   table.insert(tab, inl())
   table.insert(tab, t(":return: "))
   table.insert(tab, i(cnt, string.match(rtype_source, rtype_regex)))
   table.insert(tab, inl())
   table.insert(tab, t([["""]]))
   return sn(nil, tab)
end

local function to_def_docstring_assign(args)
   return to_fn_docstring_assign(args, true)
end

local function to_init_docstring_assign(args)
   return to_fn_docstring_assign(args, false)
end

local function comprehension_variable_to_assign(snip)
   if isempty(snip) then return sn(nil, {}) end
   local prefix = table.contains({ "D", "G", "L", "S" }, snip.captures[1]) and { i(1, "foo"), t(" = ") } or {}
   return sn(nil, prefix)
end

local function comprehension_body_to_assign(snip)
   local first_regex_trigger = not isempty(snip) and snip.captures[1]:lower()
   local second_regex_trigger = (not isempty(snip) and snip.captures[2] == "i") and snip.captures[2]

   local function _get(key, value, default_key)
      return comprehensions[key][value] or comprehensions[key][default_key or "_"]
   end

   local parens = _get("parens", first_regex_trigger)
   local args = _get("args", first_regex_trigger)
   local source = _get("source", first_regex_trigger)
   local if_statement = _get("if_statement", second_regex_trigger)

   return sn(nil, {
      t(parens[1]),
      d(1, function() return sn(nil, args[1]) end),
      t(" for "),
      d(2, function() return sn(nil, args[2]) end),
      t(" in "),
      d(3, function() return sn(nil, source) end),
      d(4, function() return sn(nil, if_statement) end),
      t(parens[2]),
   })
end

local function comprehension_to_assign_wrapper(snip)
   return sn(nil, {
      d(1, function() return comprehension_variable_to_assign(snip) end),
      d(2, function() return comprehension_body_to_assign(snip) end),
   })
end

local function def_to_assign_wrapper(snip)
   local first_regex_trigger = not isempty(snip) and snip.captures[1]:lower()

   local function _get(key, value, default_key)
      return def[key][value] or def[key][default_key or "_"]
   end

   return sn(nil, {
      d(1, function() return sn(nil, _get("decorator", first_regex_trigger)) end),
      d(2, function() return sn(nil, { t("def "), _get("name", first_regex_trigger), i(1, "foo") }) end),
      d(3, function() return sn(nil, { t("("), _get("param", first_regex_trigger), i(1), t(")") }) end),
      d(4, function() return sn(nil, { t(" -> "), i(1, "None"), inl(":") }) end),
      d(5, to_def_docstring_assign, { 3, 4 }),
      d(6, function() return sn(nil, { inl(), i(1, "pass"), nl() }) end),
   })
end

local function for_in_to_assign_wrapper(snip)
   local first_regex_trigger = not isempty(snip) and snip.captures[1]:lower()

   local function _get(key, value, default_key)
      return for_in[key][value] or for_in[key][default_key or "_"]
   end

   return sn(nil, {
      t("for "),
      first_regex_trigger == "z" and d(2, to_for_in_assign, { 1 }) or d(2, function () return sn(nil, _get("params", first_regex_trigger)) end),
      t(" in "),
      d(1, function() return sn(nil, _get("iterator", first_regex_trigger)) end),
      d(3, function() return sn(nil, { inl(":"), i(1, "pass") }) end),
   })
end

local snippets = {
   s({ trig = "breakpoint", dscr = "Setup breakpoint." }, { t("breakpoint(cond="), i(1, "True"), t(")") }),
   s({ trig = "comp", dscr = comprehensions["dscr"] }, { d(1, function() return comprehension_to_assign_wrapper() end) }),

   s({ trig = "class", dscr = "Prepare python class." }, {
      t("class "),
      i(1, "Foo"),
      inl(":"),
      -- TODO: Simple class docstring (Short, long)
      i(2, "pass")
   }),

   s({ trig = "def", dscr = def["dscr"] }, { d(1, function() return def_to_assign_wrapper() end) }),
   s({ trig = "for", dscr = for_in["dscr"] }, { d(1, function() return for_in_to_assign_wrapper() end) }),
   s({ trig = "from" }, { t("from "), i(1), t(" import "), i(2) }),
   s({ trig = "import" }, { t("import "), i(1) }),

   s({ trig = "init", dscr = "Prepare __init__ method." }, {
      d(1, function() return sn(nil, { t("def __init__(self"), i(1), inl(") -> None:") }) end),
      d(2, to_init_docstring_assign, { 1 }),
      d(3, to_init_assign, { 1 })
   }),

   s({ trig = "lambda" }, { t("lambda"), i(i, "x"), t(": "), i(2) }),
   s({ trig = "main", dscr = "Prepare main function call." }, { t([[if __name__ == "__main__":]]), inl(), i(1, "main()") }),

   -- TODO: property getter

   s({ trig = "s", dscr = "Shorthand for self method." }, { t("self."), i(1) }),
   s({ trig = "super" }, { t("super()."), i(1), t("("), i(2), t(")"), nl(), }),

   -- TODO: if/else/elif/ifelse/ifelifelse
   -- TODO: try/except, try/finally, try/except/finally

   s({ trig = "while" }, { t("while "), i(1, "True"), inl(":"), i(2) }),
   s({ trig = "with" }, { t("with "), i(1, "foo"), inl(":"), i(2) }),
}

local autosnippets = {
   s({ trig = "comp([DGLSdgls])(.)", regTrig = true }, { d(1, function(_, snip) return comprehension_to_assign_wrapper(snip) end) }),
   s({ trig = "class([^%s])" }, {}), -- TODO: s - super, i - init, a - abc, d - dataclass, D - dataclass (slots)

   s({ trig = "def([^%s])", regTrig = true }, { d(1, function(_, snip) return def_to_assign_wrapper(snip) end) }),
   s({ trig = "from([^%s])" }, { t("from __future__ import"), i(1) }),
   s({ trig = "for([^%s])", regTrig = true }, { d(1, function(_, snip) return for_in_to_assign_wrapper(snip) end) }),

   -- TODO: property getter + setter
   -- TODO: property getter + setter + deleter

   s({ trig = "with([^%s])" }, { t("with "), i(1, "foo"), t(" as "), i(2, "e"), inl(":"), i(3) }), -- TODO: a - as, r - pytest.raises
}

return snippets, autosnippets
