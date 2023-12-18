return {
    -- Mark files to jump around more easily
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon", silent = true })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon menu", silent = true })

        vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end,
            { desc = "Go to first harpoon buffer", silent = true })
        vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end,
            { desc = "Go to second harpoon buffer", silent = true })
        vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end,
            { desc = "Go to third harpoon buffer", silent = true })
        vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end,
            { desc = "Go to fourth harpoon buffer", silent = true })
    end,
}
