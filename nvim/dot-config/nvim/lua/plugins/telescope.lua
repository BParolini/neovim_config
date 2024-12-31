return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
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
            end,
        },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to previous result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
            extensions = {
                fzf = {},
            },
        })
        telescope.load_extension("harpoon")
        telescope.load_extension("ui-select")
        telescope.load_extension("noice")
        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        local keymap, fn, fs = vim.keymap, vim.fn, vim.fs
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
        keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps", silent = true })
        keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics", silent = true })
        keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope resume", silent = true })
        keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Telescope old files", silent = true })
        keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers", silent = true })
        keymap.set("n", "<leader>fn", "<cmd>Telescope noice<cr>", { desc = "Telescope noice", silent = true })

        keymap.set("n", "<leader>en", function()
            builtin.find_files({
                cwd = fn.stdpath("config"),
            })
        end, { desc = "", silent = true })
        keymap.set("n", "<leader>ep", function()
            builtin.find_files({
                cwd = fs.joinpath(fn.stdpath("data"), "lazy"),
            })
        end, { desc = "", silent = true })
    end,
}
