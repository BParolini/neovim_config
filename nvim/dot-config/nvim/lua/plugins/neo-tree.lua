--- @type LazyPluginSpec
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        filesystem = {
            use_libuv_file_watcher = true,
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                never_show = {
                    ".DS_Store",
                    "thumbs.db",
                    "node_modules",
                    ".venv",
                    "venv",
                },
            },
        },
    },
    ---@type LazyKeysSpec[]
    keys = {
        { "<leader>ee", "<cmd>Neotree toggle<CR>", noremap = true, desc = "Toggle file explorer" },
        { "<leader>ef", "<cmd>Neotree reveal<CR>", noremap = true, desc = "Toggle file explorer on current file" },
        { "<leader>ec", "<cmd>Neotree close<CR>", noremap = true, desc = "Collapse file explorer" },
    },
}
