return {
    {
        "nvim-neotest/neotest",
        event = "VeryLazy",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "nvim-neotest/neotest-go",
        ft = "go",
        config = function()
            require("neotest").setup({
                require("neotest-go"),
            })
        end,
    },
    {
        "rcasia/neotest-java",
        ft = "java",
        config = function()
            require("neotest").setup({
                require("neotest-java")({
                    ignore_wrapper = false,
                }),
            })
        end,
    },
    {
        "nvim-neotest/neotest-python",
        ft = "python",
        config = function()
            require("neotest").setup({
                require("neotest-python"),
            })
        end,
    },
    {
        "rouge8/neotest-rust",
        ft = "rust",
        config = function()
            require("neotest").setup({
                require("neotest-rust"),
            })
        end,
    },
}
