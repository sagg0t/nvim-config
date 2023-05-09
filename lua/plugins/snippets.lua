return {
    {
        "L3MON4D3/LuaSnip",
        name = "luasnip",
        -- dependencies = {
        --     "rafamadriz/friendly-snippets"
        -- },
        build = "make install_jsregexp",
        config = function()
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

            ls.add_snippets("ruby", {
                s("bb", t("binding.pry"))
            })

            ls.add_snippets("go", {
                s("pkg", { t("package "), i(0, "name") }),

                s("imp", {
                    t({ "import (", "\t\"" }),
                    i(0),
                    t({ "\"", ")" })
                }),

                s("ir", {
                    t({ "if err != nil {", "\treturn " }),
                    i(0),
                    t({ "", "}" }),
                }),

                s("if", {
                    t("if "), i(1, "cond"), t({ " {", "\t" }),
                    i(0),
                    t({ "", "}" }),
                }),

                s("ife", {
                    t("if "), i(1, "cond"), t({ " {", "\t" }),
                    i(2),
                    t({ "", "} else {", "\t"}),
                    i(0),
                    t({ "", "}" })
                }),

                s("func", {
                    t("func "), i(1, "name"), t("("), i(2, "args"), t(") "), i(3, "ret type"), t({ " {", "\t" }),
                    i(0, "body"),
                    t({ "", "}" })
                }),

                s("meth", {
                    t("func ("), i(1, "receiver"), t(") "), i(2, "name"), t("("), i(3, "args"), t(") "), i(4, "ret type"), t({ " {", "\t" }),
                    i(0, "body"),
                    t({ "", "}" })
                }),

                s("tyf", { t("type "), i(1, "name"), t("func("), i(2, "args"), t(") "), i(3) }),

                s("tyi", {
                    t("type "), i(1, "name"), t({ " interface {", "\t" }),
                    i(0, "body"),
                    t({ "", "}" })
                }),

                s("tys", {
                    t("type "), i(1, "name"), t({ " struct {", "\t" }),
                    i(0, "body"),
                    t({ "", "}" })
                }),

                s("switch", {
                    t("switch "), i(1, "expr"), t(" {"),
                    t({ "\t", "case " }), i(2, "cond"), t(":"),
                    t({ "", "\t" }), i(0),
                    t({ "", "}" })
                }),

                s("select", {
                    t("select {"),
                    t({ "\t", "case " }), i(1, "cond"), t(":"),
                    t({ "", "\t" }), i(0),
                    t({ "", "}" })
                }),

                s("for", {
                    t("for "), i(1, "cond"), t({ " {", "\t" }),
                    i(0),
                    t({ "", "}" })
                }),

                s("fori", {
                    t("for "), i(1, "i"), t(" := "), i(2, "0"), t("; "),
                    f(function(args) return args[1][1] .. " < " end, {1}), i(3, "0"), t("; "),
                    f(function(args) return args[1][1] .. "++" end, {1}), t({ " {", "\t" }),
                    i(0),
                    t({ "", "}" })
                }),

                s("forr", {
                    t("for "), i(1, "_"), t(", "), i(2, "x"), t(" := range "), i(3, "list"), t({ " {", "\t" }),
                    i(0),
                    t({ "", "}" })
                }),

                s("map", { t("map["), i(1, "type"), t("]"), i(2, "type") }),
                s("in", { t("interface{}") }),
            })

            require("luasnip/loaders/from_vscode").lazy_load()
        end
    },
}
