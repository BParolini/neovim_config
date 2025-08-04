return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp,
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
        require("noice").setup(opts)

        vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { noremap = true, silent = true, desc = "Dismiss Noice Messages" })
    end,
}
