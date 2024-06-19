return {
    "lewis6991/gitsigns.nvim",
    config = function(_, opts)
        local gitsigns = require("gitsigns")
        gitsigns.setup(opts)

        local keymap = vim.keymap
        keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { noremap = true, desc = "Preview git changes" })
        keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, { noremap = true, desc = "Show git blame for the current line" })
    end,
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "≃" },
        },
    },
}
