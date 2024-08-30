return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function(_, opts)
        require("noice").setup(opts)

        vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>",
            { noremap = true, silent = true, desc = "Dismiss Noice Messages" })
    end,
}
