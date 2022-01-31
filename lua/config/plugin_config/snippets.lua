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
local types = require("luasnip.util.types")

ls.filetype_extend('ruby', { 'rails' })

ls.config.set_config({
  history = true,
  ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
  -- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
})

ls.snippets = {
  all = {
    s("trigger", t("Wow! Text!"))
  },
  ruby = {
    s("bb", t("binding.pry"))
  }
}

require("luasnip/loaders/from_vscode").lazy_load()
