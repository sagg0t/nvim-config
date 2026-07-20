local api = vim.api

local sec_per_min = 60
local sec_per_h = sec_per_min * 60
local sec_per_d = sec_per_h * 24
local sec_per_month = sec_per_d * 30
local sec_per_year = sec_per_d * 365

local function parse_blame(output)
    local timestamp ---@type string?
    local author ---@type string?
    local commit ---@type string?
    local message ---@type string?

    local i = 0
    local start = 1
    while i < 10 do
        local nl = string.find(output, "\n", start, true)
        assert(nl, "couldn't fine a line break")
        local line = string.sub(output, start, nl - 1)

        start = nl + 1

        local sep = string.find(line, " ", 1, true)
        if sep then
            local key = string.sub(line, 1, sep - 1)
            local value = string.sub(line, sep + 1)

            if i == 0 then
                commit = key
                if commit == "0000000000000000000000000000000000000000" then
                    return "    Not Committed Yet"
                end
            elseif value ~= "" then
                if key == "author" then
                    author = value
                elseif (key == "author-mail" and not author) then
                    author = value
                elseif key == "author-time" then
                    timestamp = value
                elseif key == "summary" then
                    message = value
                end
            end
        end

        i = i + 1
    end

    local short_commit = string.sub(assert(commit, "no commit"), 1, 7)
    local time_ago ---@type string?
    if timestamp then
        local diff = os.time() - tonumber(timestamp)
        if diff < sec_per_h then
            time_ago = math.floor(diff / sec_per_min) .. "m ago"
        elseif diff < sec_per_d then
            time_ago = math.floor(diff / sec_per_h) .. "h ago"
        elseif diff < sec_per_month then
            time_ago = math.floor(diff / sec_per_d) .. "d ago"
        elseif diff < sec_per_year then
            time_ago = math.floor(diff / sec_per_month) .. "M ago"
        else
            time_ago = math.floor(diff / sec_per_year) .. "y ago"
        end
    end

    return string.format("    %s %s, %s - %s", short_commit, author, time_ago, message)
end

local is_git_repo = vim.uv.fs_stat(assert(vim.uv.cwd()) .. "/.git") ~= nil

if is_git_repo then
    local line_blame_group = api.nvim_create_augroup("sagg0t.current_line_blame", { clear = true })
    local line_blame_ns = api.nvim_create_namespace("sagg0t.current_line_blame")
    local blamed_line = -1

    api.nvim_create_autocmd("CursorHold", {
        group = line_blame_group,
        callback = function()
            local buf = api.nvim_get_current_buf()
            local file = vim.api.nvim_buf_get_name(buf)
            if file == "" then return end

            local line = api.nvim_win_get_cursor(0)[1]
            blamed_line = line
            api.nvim_buf_clear_namespace(buf, line_blame_ns, 0, -1)

            local cmd = { "git", "blame", "--porcelain", "-w", "-L", line .. "," .. line, file }
            vim.system(cmd, { text = true }, function(result)
                if result.code ~= 0 or not result.stdout then return end

                local text = parse_blame(result.stdout)

                vim.schedule(function()
                    api.nvim_buf_set_extmark(buf, line_blame_ns, line - 1, 0, {
                        hl_mode = "combine",
                        virt_text = { { text, "Comment" } },
                        virt_text_pos = "eol",
                    })
                    api.nvim_create_autocmd("CursorMoved", {
                        group = line_blame_group,
                        callback = function()
                            local move_line = api.nvim_win_get_cursor(0)[1]
                            if move_line == blamed_line then return end

                            blamed_line = -1
                            api.nvim_buf_clear_namespace(buf, line_blame_ns, 0, -1)
                        end,
                    })
                end)

            end)
        end,
    })
end
