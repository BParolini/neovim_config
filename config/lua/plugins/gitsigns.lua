return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup()

        local keymap = vim.keymap
        keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { noremap = true, desc = "Preview git changes" })
        keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, { noremap = true, desc = "Show git blame for the current line" })
    end,
}
