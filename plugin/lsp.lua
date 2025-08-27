local protocol = vim.lsp.protocol
local ms = protocol.Methods

vim.lsp.buf.code_action = require("override.code_action")

local caps = protocol.make_client_capabilities()

local border_icons = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}
-- override privew func to add borders
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, preview_opts, ...)
    preview_opts = preview_opts or {}
    preview_opts.border = preview_opts.border or border_icons
    return orig_util_open_floating_preview(contents, syntax, preview_opts, ...)
end

vim.lsp.config("*", { capabilities = caps })

vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "dockerls",
    "eslint",
    "gopls",
    "html",
    -- "htmx",
    "jsonls",
    "lua_ls",
    "ols",
    "neocmake",
    "pyright",
    -- "ruby_lsp",
    "rust_analyzer",
    "tailwindcss",
    "ts_ls",
    "zls",
})

-- vim.lsp.log.set_level("trace")
vim.lsp.inlay_hint.enable(true)

local pre_write_group = vim.api.nvim_create_augroup("sagg0t BufWritePre", { clear = true })
local lsp_attach_group = vim.api.nvim_create_augroup("sagg0t LspAttach", { clear = true })
local completion_group = vim.api.nvim_create_augroup("sagg0t.completion", { clear = true })

local kind_icons = {
    -- if you change or add symbol here
    -- replace corresponding line in readme
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("<leader>lf", vim.lsp.buf.format, "Format document")

        -- if client:supports_method(ms.textDocument_formatting, 0) then
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --         group = pre_write_group,
        --         buffer = event.buf,
        --         callback = function()
        --             vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
        --         end
        --     })
        -- end

        if client:supports_method(ms.textDocument_foldingRange, 0) then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldmethod = "expr"
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client:supports_method(ms.textDocument_documentColor) then
            vim.lsp.document_color.enable(true, event.buf, { style = "virtual" })
        end

        if client:supports_method(ms.textDocument_completion) then
            vim.lsp.completion.enable(true, event.data.client_id, event.buf, {
                autotrigger = true,
                convert = function(item)
                    local kind = protocol.CompletionItemKind[item.kind] or "unknown"
                    local kind_hl = "@lsp.kind." .. kind:sub(1, 1):lower() .. kind:sub(2)

                    return {
                        kind = " " .. kind_icons[kind] .. "  ",
                        kind_hlgroup = kind_hl,
                        menu = ""
                    }
                end
            })

            local existing_handlers = vim.api.nvim_get_autocmds({
                buffer = event.buf,
                event = { "CompleteChanged" },
                group = completion_group,
            })
            if #existing_handlers == 0 then
                vim.api.nvim_create_autocmd("CompleteChanged", {
                    buffer = event.buf,
                    group = completion_group,
                    callback = function()
                        local info = vim.fn.complete_info({ "selected" })
                        if info.preview_bufnr and vim.bo[info.preview_bufnr].filetype == "" then
                            vim.bo[info.preview_bufnr].filetype = "markdown"
                            vim.wo[info.preview_winid].conceallevel = 2
                            vim.wo[info.preview_winid].concealcursor = "niv"
                        end
                    end,
                })

                vim.api.nvim_create_autocmd("CompleteDone", {
                    buffer = event.buf,
                    group = completion_group,
                    desc = "Auto show signature help when compeltion done",
                    callback = function()
                        local item = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item")
                        if not item then return end

                        if item.kind == 3
                            and item.insertTextFormat == vim.lsp.protocol.InsertTextFormat.Snippet
                            and (item.textEdit ~= nil or item.insertText ~= nil)
                        then
                            vim.schedule(function()
                                if vim.api.nvim_get_mode().mode == "s" then
                                    vim.lsp.buf.signature_help()
                                end
                            end)
                        end
                    end,
                })
            end
        end
    end
})
