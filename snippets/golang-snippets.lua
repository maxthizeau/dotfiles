local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local function fn(
  args,     -- text from i(2) in this example i.e. { { "456" } }
  parent,   -- parent snippet or parent node
  user_args -- user_args from opts.user_args 
)
   return '[' .. args[1][1] .. user_args .. ']'
end

ls.add_snippets("all", {
	s("ternary", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	})
})

ls.add_snippets("typescriptreact", {
	s("mtrfc", 
		{
			t({ "import React from 'react'",
			"",
			"type Props = "}),
			i(2, "unknown"),
			t({"" ,
			"const "}),
			i(1, "ComponentName"),
			t({
			": React.FC<Props> = () => {",
			"  return (",
			"   <>",
			"        "}),
			i(3, "content"),
			t({"    </>",
			"  )",
			"}",
			"",
			"export default "}),
			rep(1)

			-- t ' i(2)->', i(2), t '<-i(2) i(0)->', i(0),
		})
})

-- ls.add_snippets("all", {
-- 	s("trig", {
-- 		i(1), t '<-i(1) ',
-- 		f(fn,  -- callback (args, parent, user_args) -> string
-- 			{2}, -- node indice(s) whose text is passed to fn, i.e. i(2)
-- 			{ user_args = { "user_args_value" }} -- opts
-- 		),
-- 		t ' i(2)->', i(2), t '<-i(2) i(0)->', i(0)
-- 	}),
-- 	s("beg", fmt([[
-- 		    \begin{<>}
-- 		    <>
-- 		    \end{<>}]], 
-- 		{i(1), i(0), rep(1)}, -- repeat node 1
-- 		{delimeters='<>'}
-- 	))
-- })

