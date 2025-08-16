--- @type LazyPluginSpec
return {
    "laytan/cloak.nvim",
    opts = {
        enable = true,
        cloak_character = "*",
        highlight_group = "Comment",
        patterns = {
            {
                file_pattern = {
                    ".env*",
                    "wrangler.toml",
                    ".dev.vars",
                },
                cloak_pattern = "=.+",
            },
        },
    },
    ---@type LazyKeysSpec[]
    keys = {
        {
            "<leader>cc",
            function()
                require("cloak").toggle()
            end,
            noremap = true,
            desc = "Toggle cloak",
        },
        {
            "<leader>ca",
            function()
                require("cloak").enable()
            end,
            noremap = true,
            desc = "Enable cloak",
        },
        {
            "<leader>cd",
            function()
                require("cloak").disable()
            end,
            noremap = true,
            desc = "Disable cloak",
        },
    },
}
