return {
    -- Mark files to jump around more easily
    "ThePrimeagen/harpoon",
    ---@type LazyKeysSpec[]
    keys = {
        {"<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to harpoon" },
        {"<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle harpoon menu" },

        { "<leader>hh", function() require("harpoon.ui").nav_file(1) end, desc = "Go to first harpoon buffer" },
        { "<leader>hj", function() require("harpoon.ui").nav_file(2) end, desc = "Go to second harpoon buffer" },
        { "<leader>hk", function() require("harpoon.ui").nav_file(3) end, desc = "Go to third harpoon buffer" },
        { "<leader>hl", function() require("harpoon.ui").nav_file(4) end, desc = "Go to fourth harpoon buffer" },
    },
}
