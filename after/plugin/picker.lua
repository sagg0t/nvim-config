vim.pack.add({ "https://github.com/nvim-mini/mini.pick" }, { load = true })

local api = vim.api
local util = require("util.load")
local ns = {
    files       = api.nvim_create_namespace("sagg0t.files-picker"),
    keymap      = api.nvim_create_namespace("sagg0t.keymap-picker"),
    hl_group    = api.nvim_create_namespace("sagg0t.hl-group-picker"),
    diagnostics = api.nvim_create_namespace("sagg0t.diagnostics-picker"),
}

util.on_ui_enter(function()
    require("mini.pick").setup({
        window = {
            config = function()
                local height = math.max(1, math.floor(vim.o.lines * 0.4))
                height = math.min(30, height)

                return {
                    anchor = "SE",
                    width = vim.o.columns,
                    height = height,
                    border = { "━", "━", "━", " ", " ", " ", " ", " " },
                }
            end,
            prompt_prefix = "  ",
            prompt_caret = "_ ",
        }
    })
    -- from telescope config selection_caret = " ",
end)

vim.keymap.set("n", "<Leader>ff", function()
    local MiniPick = require("mini.pick")

    MiniPick.builtin.files(nil, {
        source = {
            show = function(buf, items, query)
                local marks = {}

                for i, item in ipairs(items) do
                    local dir = vim.fn.fnamemodify(item, ":h")
                    if dir ~= "." then
                        table.insert(marks, { "PickerDir", i - 1, 4, 5 + #dir })
                    end
                end

                MiniPick.default_show(buf, items, query, { show_icons = true })

                api.nvim_buf_clear_namespace(buf, ns.files, 0, -1)

                for _, mark in ipairs(marks) do
                    api.nvim_buf_set_extmark(buf, ns.files, mark[2], mark[3], {
                        hl_group = mark[1],
                        end_col = mark[4],
                        priority = 100,
                    })
                end
            end
        }
    })
end, { desc = "Find files", })

vim.keymap.set("n", "<Leader>ft", function()
    local MiniPick = require("mini.pick")

    MiniPick.builtin.grep_live(nil, {
        source = {
            show = function(buf, raw_items, picker_query)
                local items = {}
                local marks = {}
                local max_path = 0

                for i, raw_item in ipairs(raw_items) do
                    local row = i - 1
                    local path, slnum, scol, match_text = unpack(vim.split(raw_item, "\0"))
                    local lnum, col = tonumber(slnum), tonumber(scol)
                    local ft = vim.filetype.match({ filename = path })
                    local text = ("%s:%d:%d"):format(path, lnum, col)

                    match_text = match_text:gsub("\t", "    ")

                    local new_item = {
                        path = path,
                        lnum = lnum,
                        col = col,
                        text = text,
                        __match_text = match_text,
                        __ft = ft,
                    }

                    max_path = math.max(max_path, #new_item.text)

                    table.insert(items, new_item)

                    local dir = vim.fn.fnamemodify(path, ":h")
                    if dir ~= "." then
                        table.insert(marks, { "PickerDir", row, 4, 5 + #dir })
                    end

                    table.insert(marks, { "Operator", row, 4 + #path, 5 + #path })
                    table.insert(marks, { "Number", row, 5 + #path, 5 + #path + #slnum })
                    local col_start = 6 + #path + #slnum
                    table.insert(marks, { "Operator", row, col_start - 1, col_start })
                    table.insert(marks, { "String", row, col_start, col_start + #scol })
                end

                local format_str = string.format("%%-%ds  %%s", max_path)

                for i, item in ipairs(items) do
                    item.text = format_str:format(item.text, item.__match_text)

                    local lang = vim.treesitter.language.get_lang(item.__ft)
                    local parser = vim.treesitter.get_string_parser(item.__match_text, lang)
                    if parser then
                        local col_offset = max_path + 6

                        parser:parse(true)
                        parser:for_each_tree(function(tstree, tree)
                            if not tstree then return end

                            local query = vim.treesitter.query.get(tree:lang(), "highlights")
                            if not query then return end

                            for id, node in query:iter_captures(tstree:root(), item.__match_text) do
                                local hl = string.format("@%s.%s", query.captures[id], lang)
                                local _, start_col, _, end_col = node:range()
                                table.insert(marks, { hl, i - 1, start_col + col_offset, end_col + col_offset })
                            end
                        end)
                    end
                end

                MiniPick.default_show(buf, items, picker_query, { show_icons = true })

                -- api.nvim_buf_set_lines(buf, 0, -1, false, vim.tbl_map(function(v) return "    ".. v.text end, items))
                api.nvim_buf_clear_namespace(buf, ns.files, 0, -1)

                for _, mark in ipairs(marks) do
                    api.nvim_buf_set_extmark(buf, ns.files, mark[2], mark[3], {
                        hl_group = mark[1],
                        end_col = mark[4],
                        priority = 100,
                    })
                end
            end
        }
    })
end, { desc = "Grep" })

vim.keymap.set("n", "<Leader>fh", function()
    require("mini.pick").builtin.help()
end, { desc = "help tags" })

vim.keymap.set("n", "<Leader>fH", function()
    local highlights = vim.api.nvim_get_hl(0, {})

    local hl_items = {}

    local max_group_len = 0
    for hl_group, hl_opts in pairs(highlights) do
        max_group_len = math.max(max_group_len, #hl_group)

        table.insert(hl_items, {
            __group = hl_group,
            __opts = hl_opts
        })
    end

    local format_str = (" %%-%ds %%s"):format(max_group_len)

    for _, item in ipairs(hl_items) do
        local link = item.__opts.link
        if link then
            item.text = string.format(format_str, item.__group, "-> " .. link)
        else
            item.text = " " .. item.__group .. " "
        end
    end

    local preview_type_map = {
        string = "String",
        number = "Number",
        boolean = "Boolean",
        table = "Normal",
    }

    local MiniPick = require("mini.pick")
    MiniPick.start({
        source = {
            name = "Highlight Groups",
            items = hl_items,
            show = function(buf, items, query)
                MiniPick.default_show(buf, items, query)

                api.nvim_buf_clear_namespace(buf, ns.hl_group, 0, -1)

                for i, item in ipairs(items) do
                    api.nvim_buf_set_extmark(buf, ns.hl_group, i - 1, 1, {
                        hl_group = item.__group,
                        end_col = 1 + #item.__group,
                        priority = 100,
                    })

                    local link = item.__opts.link
                    if link then
                        api.nvim_buf_set_extmark(buf, ns.hl_group, i - 1, 2 + max_group_len, {
                            hl_group = "Operator",
                            end_col = 4 + max_group_len,
                            priority = 100,
                        })
                        api.nvim_buf_set_extmark(buf, ns.hl_group, i - 1, 5 + max_group_len, {
                            hl_group = link,
                            end_col = 5 + max_group_len + #link,
                            priority = 100,
                        })
                    end
                end
            end,
            preview = function(buf, item)
                local lines = {}
                local marks = {}

                local group = item.__group
                local opts = item.__opts

                while opts do
                    table.insert(lines, group)

                    local keys = vim.tbl_keys(opts)
                    table.sort(keys)

                    for _, key in ipairs(keys) do
                        local value = opts[key]
                        local str_val
                        if type(value) == "number" then
                            str_val = "#" .. bit.tohex(value, -6)
                        else
                            str_val = vim.inspect(value, { newline = " ", indent = "" })
                        end

                        local line = ("%s = %s"):format(key, str_val)
                        table.insert(lines, line)

                        local lnum = #lines - 1
                        table.insert(marks, { "@property", lnum, 0, #key })
                        table.insert(marks, { "Operator", lnum, #key + 1, #key + 2 })
                        table.insert(marks, { preview_type_map[type(value)] or "UNSET", lnum, #key + 3, #key + 3 + #str_val })
                    end
                    table.insert(lines, "")

                    if opts.link then
                        group = opts.link
                        opts = api.nvim_get_hl(0, { name = group })
                    else
                        group = nil
                        opts = nil
                    end
                end

                lines[1] = ("%s (%s)"):format(item.__group, item.__group)

                api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                api.nvim_buf_clear_namespace(buf, ns.hl_group, 0, -1)
                api.nvim_buf_set_extmark(buf, ns.hl_group, 0, 0, {
                    hl_group = item.__group,
                    end_col = #item.__group,
                })

                for _, mark in ipairs(marks) do
                    api.nvim_buf_set_extmark(buf, ns.hl_group, mark[2], mark[3], {
                        hl_group = mark[1],
                        end_col = mark[4],
                    })
                end
            end
        }
    })
end, { desc = "highlight groups" })

vim.keymap.set("n", "<Leader>fk", function()
    local keymaps = vim.api.nvim_get_keymap("")
    local sizes = { mode = 0, lhs = 0 }

    local transformed_maps = {}
    for _, k in ipairs(keymaps) do
        sizes.mode = math.max(sizes.mode, vim.fn.strchars(k.mode))

        local lhs = vim.fn.keytrans(k.lhsraw or k.lhs)
        sizes.lhs = math.max(sizes.lhs, vim.fn.strchars(lhs))

        local rhs = k.desc or k.rhs or ""

        table.insert(transformed_maps, { mode = k.mode, lhs = lhs, rhs = rhs, val = k })
    end

    local fmt_str = (" %%-%ds │ %%-%ds │ %%s "):format(sizes.mode, sizes.lhs)

    local items = {}
    for _, k in ipairs(transformed_maps) do
        local item = fmt_str:format(k.mode, k.lhs, k.rhs)
        table.insert(items, { text = item, val = k.val })
    end

    local sep_char_len = string.len("│")

    local hls = {
        { "SpecialChar", 1, 1 + sizes.mode },
        { "Comment", 2 + sizes.mode, 2 + sizes.mode + sep_char_len },
        { "Comment", 4 + sizes.mode + sep_char_len + sizes.lhs, 4 + sizes.mode + 2 * sep_char_len + sizes.lhs},
    }

    local MiniPick = require("mini.pick")
    MiniPick.start({
        source = {
            name = "Keymaps",
            items = items,
            show = function(buf, arr, query)
                MiniPick.default_show(buf, arr, query)

                api.nvim_buf_clear_namespace(buf, ns.keymap, 0, -1)

                for i, item in ipairs(arr) do
                    for _, hl in ipairs(hls) do
                        api.nvim_buf_set_extmark(buf, ns.keymap, i - 1, hl[2], {
                            hl_group = hl[1],
                            end_col = hl[3],
                            priority = 100,
                        })
                    end

                    if not item.val.desc and item.val.rhs and #item.val.rhs > 0 then
                        local range_start = hls[#hls][3] + 1
                        local range_end = range_start + vim.fn.strchars(item.val.rhs)

                        api.nvim_buf_set_extmark(buf, ns.keymap, i - 1, range_start, {
                            hl_group = "Function",
                            end_col = range_end,
                            priority = 100,
                        })
                    end
                end
            end,
            preview = function(buf, item)
                local str = vim.inspect(item.val)
                api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(str, "\n", { plain = true }))
            end
        }
    })
end, { desc = "keymaps" })

local diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = "󰅚",
    [vim.diagnostic.severity.WARN]  = "󰀪",
    [vim.diagnostic.severity.INFO]  = "󰋽",
    [vim.diagnostic.severity.HINT]  = "󰌶"
}

local diagnostic_hls = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
    [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
    [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
    [vim.diagnostic.severity.HINT]  = "DiagnosticHint"
}

vim.keymap.set("n", "<Leader>fd", function()
    local diagnostics = vim.diagnostic.get()
    local diagnostic_items = {}
    local max_path = 0

    for _, d in ipairs(diagnostics) do
        local path = api.nvim_buf_get_name(d.bufnr)
        local dir = vim.fn.fnamemodify(path, ":h")
        if dir == "." then
            dir = ""
        end
        local file = vim.fn.fnamemodify(path, ":t")
        local location = ("%s:%d:%d"):format(path, d.lnum, d.col)

        max_path = math.max(max_path, #location)

        table.insert(diagnostic_items, {
            path = path,
            lnum = d.lnum + 1,
            col = d.col + 1,
            __dir = dir,
            __file = file,
            __location = location,
            __d = d,
        })
    end

    local format_str = string.format(" %%s  %%-%ds  [%%s] %%s", max_path)

    for _, item in ipairs(diagnostic_items) do
        local d = item.__d

        item.__severity = d.severity and diagnostic_signs[d.severity] or " "
        item.__code = tostring(d.code) or ""
        item.text = format_str:format(item.__severity, item.__location, item.__code, d.message)
    end

    local MiniPick = require("mini.pick")
    MiniPick.start({
        source = {
            items = diagnostic_items,
            show = function(buf, items, query)
                local marks = {}

                for i, item in ipairs(items) do
                    local d = item.__d
                    local row = i - 1

                    if d.severity then
                        table.insert(marks, { diagnostic_hls[d.severity], row, 1, 2 })
                    end

                    if #item.__dir > 0 then
                        table.insert(marks, { "PickerDir", row, 7, 8 + #item.__dir })
                    end

                    local l_sep_s = 8 + #item.__dir + #item.__file
                    table.insert(marks, { "Operator", row, l_sep_s, l_sep_s + 1  })
                    table.insert(marks, { "Number", row, l_sep_s + 1, l_sep_s + 1 + #tostring(item.lnum) })

                    local c_sep_s = l_sep_s + 1 + #tostring(item.lnum)
                    table.insert(marks, { "Operator", row, c_sep_s, c_sep_s + 1  })
                    table.insert(marks, { "String", row, c_sep_s + 1, c_sep_s + 1 + #tostring(item.col)  })

                    table.insert(marks, { "Folded", row, 9 + max_path, 11 + max_path + #item.__code })
                end

                MiniPick.default_show(buf, items, query)

                api.nvim_buf_clear_namespace(buf, ns.diagnostics, 0, -1)

                for _, mark in ipairs(marks) do
                    api.nvim_buf_set_extmark(buf, ns.diagnostics, mark[2], mark[3], {
                        hl_group = mark[1],
                        end_col = mark[4],
                        priority = 100,
                    })
                end
            end
        }
    })
end, { desc = "workspace diagnostics" })
