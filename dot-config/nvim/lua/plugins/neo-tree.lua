return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                use_libuv_file_watcher = true,
            },
        })
        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { silent = true, noremap = true, desc = "Toggle file explorer" })
        keymap.set("n", "<leader>ef", "<cmd>Neotree reveal<CR>", { silent = true, noremap = true, desc = "Toggle file explorer on current file" })
        keymap.set("n", "<leader>ec", "<cmd>Neotree close<CR>", { silent = true, noremap = true, desc = "Collapse file explorer" })
    end,
}
