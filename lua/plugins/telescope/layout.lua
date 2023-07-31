local resolve = require("telescope.config.resolve")
local p_window = require("telescope.pickers.window")


local get_border_size = function(opts)
    if opts.window.border == false then
        return 0
    end

    return 1
end

local calc_tabline = function(max_lines)
    local tbln = (vim.o.showtabline == 2) or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
    if tbln then
        max_lines = max_lines - 1
    end
    return max_lines, tbln
end

-- Helper function for capping over/undersized width/height, and calculating spacing
--@param cur_size number: size to be capped
--@param max_size any: the maximum size, e.g. max_lines or max_columns
--@param bs number: the size of the border
--@param w_num number: the maximum number of windows of the picker in the given direction
--@param b_num number: the number of border rows/column in the given direction (when border enabled)
--@param s_num number: the number of gaps in the given direction (when border disabled)
local calc_size_and_spacing = function(cur_size, max_size, bs, w_num, b_num, s_num)
    local spacing = s_num * (1 - bs) + b_num * bs
    cur_size = math.min(cur_size, max_size)
    cur_size = math.max(cur_size, w_num + spacing)
    return cur_size, spacing
end

local layout_strategies = {}
layout_strategies._configurations = {}

--@param strategy_config table: table with keys for each option for a strategy
--@return table: table with keys for each option (for this strategy) and with keys for each layout_strategy
local get_valid_configuration_keys = function(strategy_config)
    local valid_configuration_keys = {
        -- TEMP: There are a few keys we should say are valid to start with.
        preview_cutoff = true,
        prompt_position = true,
    }

    for key in pairs(strategy_config) do
        valid_configuration_keys[key] = true
    end

    for name in pairs(layout_strategies) do
        valid_configuration_keys[name] = true
    end

    return valid_configuration_keys
end

local adjust_pos = function(pos, ...)
    for _, opts in ipairs { ... } do
        opts.col = opts.col and opts.col + pos[1]
        opts.line = opts.line and opts.line + pos[2]
    end
end

--@param strategy_name string: the name of the layout_strategy we are validating for
--@param configuration table: table with keys for each option available
--@param values table: table containing all of the non-default options we want to set
--@param default_layout_config table: table with the default values to configure layouts
--@return table: table containing the combined options (defaults and non-defaults)
local function validate_layout_config(strategy_name, configuration, values, default_layout_config)
    assert(strategy_name, "It is required to have a strategy name for validation.")
    local valid_configuration_keys = get_valid_configuration_keys(configuration)

    -- If no default_layout_config provided, check Telescope's config values
    default_layout_config = vim.F.if_nil(default_layout_config, require("telescope.config").values.layout_config)

    local result = {}
    local get_value = function(k)
        -- skip "private" items
        if string.sub(k, 1, 1) == "_" then
            return
        end

        local val
        -- Prioritise options that are specific to this strategy
        if values[strategy_name] ~= nil and values[strategy_name][k] ~= nil then
            val = values[strategy_name][k]
        end

        -- Handle nested layout config values
        if layout_strategies[k] and strategy_name ~= k and type(val) == "table" then
            val = vim.tbl_deep_extend("force", default_layout_config[k], val)
        end

        if val == nil and values[k] ~= nil then
            val = values[k]
        end

        if val == nil then
            if default_layout_config[strategy_name] ~= nil and default_layout_config[strategy_name][k] ~= nil then
                val = default_layout_config[strategy_name][k]
            else
                val = default_layout_config[k]
            end
        end

        return val
    end

    -- Always set the values passed first.
    for k in pairs(values) do
        if not valid_configuration_keys[k] then
            -- TODO: At some point we'll move to error here,
            --    but it's a bit annoying to just straight up crash everyone's stuff.
            vim.api.nvim_err_writeln(
                string.format(
                    "Unsupported layout_config key for the %s strategy: %s\n%s",
                    strategy_name,
                    k,
                    vim.inspect(values)
                )
            )
        end

        result[k] = get_value(k)
    end

    -- And then set other valid keys via "inheritance" style extension
    for k in pairs(valid_configuration_keys) do
        if result[k] == nil then
            result[k] = get_value(k)
        end
    end

    return result
end

-- List of options that are shared by more than one layout.
local shared_options = {
    width = { "How wide to make Telescope's entire layout", "See |resolver.resolve_width()|" },
    height = { "How tall to make Telescope's entire layout", "See |resolver.resolve_height()|" },
    mirror = "Flip the location of the results/prompt and preview windows",
    scroll_speed = "The number of lines to scroll through the previewer",
    prompt_position = { "Where to place prompt window.", "Available Values: 'bottom', 'top'" },
    anchor = { "Which edge/corner to pin the picker to", "See |resolver.resolve_anchor_pos()|" },
}

--@param name string: the name to be assigned to the layout
--@param layout_config table: table where keys are the available options for the layout
--@param layout function: function with signature
--          function(self, max_columns, max_lines, layout_config): table
--        the returned table is the sizing and location information for the parts of the picker
--@retun function: wrapped function that inputs a validated layout_config into the `layout` function
local function make_documented_layout(name, layout_config, layout)
    -- Save configuration data to be used by documentation
    layout_strategies._configurations[name] = layout_config

    -- Return new function that always validates configuration
    return function(self, max_columns, max_lines, override_layout)
        return layout(
            self,
            max_columns,
            max_lines,
            validate_layout_config(
                name,
                layout_config,
                vim.tbl_deep_extend("keep", vim.F.if_nil(override_layout, {}), vim.F.if_nil(self.layout_config, {}))
            )
        )
    end
end


--- Centered layout with a combined block of the prompt
--- and results aligned to the middle of the screen.
--- The preview window is then placed in the remaining
--- space above or below, according to `anchor` or `mirror`.
--- Particularly useful for creating dropdown menus
--- (see |telescope.themes| and |themes.get_dropdown()|).
---
--- Note that vertical anchoring, i.e. `anchor` containing
--- `"N"` or `"S"`, will override `mirror` config. For `"N"`
--- anchoring preview will be placed below prompt/result
--- block. For `"S"` anchoring preview will be placed above
--- prompt/result block. For horizontal only anchoring preview
--- will be placed according to `mirror` config, default is
--- above the prompt/result block.
---
--- <pre>
--- ┌──────────────────────────────────────────────────┐
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Preview                │    │
--- │    │                 Preview                │    │
--- │    └────────────────────────────────────────┘    │
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Prompt                 │    │
--- │    ├────────────────────────────────────────┤    │
--- │    │                 Result                 │    │
--- │    │                 Result                 │    │
--- │    └────────────────────────────────────────┘    │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- └──────────────────────────────────────────────────┘
--- </pre>
---
layout_strategies.custom_center = make_documented_layout(
    "custom_center",
    vim.tbl_extend("error", shared_options, {
        preview_cutoff = "When lines are less than this value, the preview will be disabled",
    }),
    function(self, max_columns, max_lines, layout_config)
        local initial_options = p_window.get_initial_window_options(self)
        local preview = initial_options.preview
        local results = initial_options.results
        local prompt = initial_options.prompt
        vim.print("Preview: ", preview)
        vim.print("Results: ", results)
        vim.print("Prompt: ", prompt)

        local tbln
        max_lines, tbln = calc_tabline(max_lines)

        -- This sets the width for the whole layout
        local width_opt = layout_config.width
        local width = resolve.resolve_width(width_opt)(self, max_columns, max_lines)

        -- This sets the height for the whole layout
        local height_opt = layout_config.height
        local height = resolve.resolve_height(height_opt)(self, max_columns, max_lines)

        local bs = get_border_size(self)

        local w_space
        -- Cap over/undersized width
        width, w_space = calc_size_and_spacing(width, max_columns, bs, 1, 2, 0)

        prompt.width = width - w_space
        results.width = width - w_space
        preview.width = width - w_space

        local h_space
        -- Cap over/undersized height
        height, h_space = calc_size_and_spacing(height, max_lines, bs, 2, 3, 0)

        prompt.height = 1
        results.height = height - prompt.height - h_space

        local topline = math.floor((max_lines / 2) - ((results.height + (2 * bs)) / 2) + 1)
        -- Align the prompt and results so halfway up the screen is
        -- in the middle of this combined block
        prompt.line = topline
        results.line = prompt.line + 1 + bs

        local width_padding = math.floor((max_columns - width) / 2) + bs + 1
        results.col, preview.col, prompt.col = width_padding, width_padding, width_padding

        local anchor = layout_config.anchor or ""
        local anchor_pos = resolve.resolve_anchor_pos(anchor, width, height, max_columns, max_lines)
        adjust_pos(anchor_pos, prompt, results, preview)

        -- Set preview position
        local block_line = math.min(results.line, prompt.line)
        preview.line = 1 + bs
        preview.height = block_line - (2 + 2 * bs)

        if not (self.previewer and max_lines >= layout_config.preview_cutoff) then
            preview.height = 0
        end

        if tbln then
            prompt.line = prompt.line + 1
            results.line = results.line + 1
            preview.line = preview.line + 1
        end

        return {
            preview = self.previewer and preview.height > 0 and preview,
            results = results,
            prompt = prompt,
        }
    end
)


--- Vertical layout stacks the items on top of each other.
--- Particularly useful with thinner windows.
---
--- <pre>
--- ┌──────────────────────────────────────────────────┐
--- │                                                  │
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Preview                │    │
--- │    │                 Preview                │    │
--- │    │                 Preview                │    │
--- │    └────────────────────────────────────────┘    │
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Result                 │    │
--- │    │                 Result                 │    │
--- │    └────────────────────────────────────────┘    │
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Prompt                 │    │
--- │    └────────────────────────────────────────┘    │
--- │                                                  │
--- └──────────────────────────────────────────────────┘
--- </pre>
---@eval { ["description"] = require("telescope.pickers.layout_strategies")._format("vertical") }
---
layout_strategies.vertical = make_documented_layout(
    "vertical",
    vim.tbl_extend("error", shared_options, {
        preview_cutoff = "When lines are less than this value, the preview will be disabled",
        preview_height = { "Change the height of Telescope's preview window", "See |resolver.resolve_height()|" },
    }),
    function(self, max_columns, max_lines, layout_config)
        local initial_options = p_window.get_initial_window_options(self)
        local preview = initial_options.preview
        local results = initial_options.results
        local prompt = initial_options.prompt

        local tbln
        max_lines, tbln = calc_tabline(max_lines)

        local width_opt = layout_config.width
        local width = resolve.resolve_width(width_opt)(self, max_columns, max_lines)

        local height_opt = layout_config.height
        local height = resolve.resolve_height(height_opt)(self, max_columns, max_lines)

        local bs = get_border_size(self)

        local w_space
        -- Cap over/undersized width
        width, w_space = calc_size_and_spacing(width, max_columns, bs, 1, 2, 0)

        prompt.width = width - w_space
        results.width = prompt.width
        preview.width = prompt.width

        local h_space
        if self.previewer and max_lines >= layout_config.preview_cutoff then
            -- Cap over/undersized height (with previewer)
            height, h_space = calc_size_and_spacing(height, max_lines, bs, 3, 6, 2)

            preview.height =
                resolve.resolve_height(vim.F.if_nil(layout_config.preview_height, 0.5))(self, max_columns, height)
        else
            -- Cap over/undersized height (without previewer)
            height, h_space = calc_size_and_spacing(height, max_lines, bs, 2, 4, 1)

            preview.height = 0
        end
        prompt.height = 1
        results.height = height - preview.height - prompt.height - h_space

        local width_padding = math.floor((max_columns - width) / 2) + bs + 1
        results.col, preview.col, prompt.col = width_padding, width_padding, width_padding

        local height_padding = math.floor((max_lines - height) / 2)
        if not layout_config.mirror then
            preview.line = height_padding + (1 + bs)
            if layout_config.prompt_position == "top" then
                prompt.line = (preview.height == 0) and preview.line or preview.line + preview.height + (1 + bs)
                results.line = prompt.line + prompt.height + (1 + bs)
            elseif layout_config.prompt_position == "bottom" then
                results.line = (preview.height == 0) and preview.line or preview.line + preview.height + (1 + bs)
                prompt.line = results.line + results.height + (1 + bs)
            else
                error(string.format("Unknown prompt_position: %s\n%s", self.window.prompt_position,
                    vim.inspect(layout_config)))
            end
        else
            if layout_config.prompt_position == "top" then
                prompt.line = height_padding + (1 + bs)
                results.line = prompt.line + prompt.height + (1 + bs)
                preview.line = results.line + results.height + (1 + bs)
            elseif layout_config.prompt_position == "bottom" then
                results.line = height_padding + (1 + bs)
                prompt.line = results.line + results.height + (1 + bs)
                preview.line = prompt.line + prompt.height + (1 + bs)
            else
                error(string.format("Unknown prompt_position: %s\n%s", self.window.prompt_position,
                    vim.inspect(layout_config)))
            end
        end

        local anchor_pos = resolve.resolve_anchor_pos(layout_config.anchor or "", width, height, max_columns, max_lines)
        adjust_pos(anchor_pos, prompt, results, preview)

        if tbln then
            prompt.line = prompt.line + 1
            results.line = results.line + 1
            preview.line = preview.line + 1
        end

        return {
            preview = self.previewer and preview.height > 0 and preview,
            results = results,
            prompt = prompt,
        }
    end
)

layout_strategies._validate_layout_config = validate_layout_config

return layout_strategies
