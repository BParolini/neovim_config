return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("harpoon")

            local builtin = require("telescope.builtin")
            local keymap, fn = vim.keymap, vim.fn
            keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files", silent = true })
            keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope find git files", silent = true })
            keymap.set("n", "<leader>fj", function()
                builtin.grep_string({ search = fn.input("Grep > ") })
            end, { desc = "Telescope grep string", silent = true })
            keymap.set("n", "<leader>fw", function()
                local word = fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end, { desc = "Telescope grep word under cursor (strictly delimited)", silent = true })
            keymap.set("n", "<leader>fW", function()
                local word = fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end, { desc = "Telescope grep word under cursor (blank space delimited)", silent = true })
            keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags", silent = true })
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
                },
            })
            telescope.load_extension("ui-select")
        end,
    },
}
