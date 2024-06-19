return {
    -- Mark files to jump around more easily
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        local keymap = vim.keymap
        keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon", silent = true })
        keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon menu", silent = true })

        keymap.set("n", "<leader>hh", function()
            ui.nav_file(1)
        end, { desc = "Go to first harpoon buffer", silent = true })
        keymap.set("n", "<leader>hj", function()
            ui.nav_file(2)
        end, { desc = "Go to second harpoon buffer", silent = true })
        keymap.set("n", "<leader>hk", function()
            ui.nav_file(3)
        end, { desc = "Go to third harpoon buffer", silent = true })
        keymap.set("n", "<leader>hl", function()
            ui.nav_file(4)
        end, { desc = "Go to fourth harpoon buffer", silent = true })
    end,
}
