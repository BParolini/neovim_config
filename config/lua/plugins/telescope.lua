return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("harpoon")
            telescope.load_extension("dap")

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find files", silent = true })
            vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Telescope find git files", silent = true })
            vim.keymap.set('n', '<leader>fj', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end, { desc = "Telescope grep string", silent = true })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help tags", silent = true })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                }
            })
            telescope.load_extension("ui-select")
        end,
    },
}
