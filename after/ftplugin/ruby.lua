local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

vim.api.nvim_buf_create_user_command(
    0,
    "ShowRubyDeps",
    function(opts)
        local client = vim.lsp.get_clients({ name = "ruby_lsp" })[1]
        if client == nil then
            print("No RubyLSP running...")
            return
        end

        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local conf = require("telescope.config").values

        local params = vim.lsp.util.make_text_document_params()
        local showAll = opts.args == "all"

        client.request("rubyLsp/workspace/dependencies", params, function(error, resultDeps)
            if error then
                print("Error showing deps: " .. error)
                return
            end

            local results = {}
            for _, item in ipairs(resultDeps) do
                if showAll or item.dependency then
                    table.insert(results, item)
                end
            end

            pickers.new({}, {
                prompt_title = "Dependencies",
                finder = finders.new_table({
                    results = results,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = function(item)
                                local indirect
                                if item.value.dependency then
                                    indirect = ""
                                else
                                    indirect = " (indirect)"
                                end

                                return string.format("%s %s%s", item.value.name, item.value.version, indirect)
                            end,
                            ordinal = entry.name,
                            path = entry.path
                        }
                    end
                }),
                sorter = conf.generic_sorter({})
            }):find()
        end, 0)
    end,
    {
        nargs = "?",
        complete = function()
            return { "all" }
        end,
    }
)
