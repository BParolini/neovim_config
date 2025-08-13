--- @type LazyPluginSpec
return {
        "nvim-neotest/neotest",
        event = "VeryLazy",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-neotest/neotest-plenary",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-go",
            "rcasia/neotest-java",
            "nvim-neotest/neotest-python",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-plenary"),
                    require("rustaceanvim.neotest"),
                    require("neotest-go"),
                    require("neotest-java")({
                        ignore_wrapper = false,
                    }),
                    require("neotest-python"),
                },
            })
        end,
}
