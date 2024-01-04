return {
    "laytan/cloak.nvim",
    config = function()
        local cloak = require("cloak")
        cloak.setup({
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
        })

        vim.keymap.set("n", "<leader>cc", cloak.toggle, { noremap = true, silent = true, desc = "Toggle cloak" })
        vim.keymap.set("n", "<leader>ca", cloak.enable, { noremap = true, silent = true, desc = "Enable cloak" })
        vim.keymap.set("n", "<leader>cd", cloak.disable, { noremap = true, silent = true, desc = "Disable cloak" })
    end,
}
