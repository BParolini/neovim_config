return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        local o = vim.o
        o.timeout = true
        o.timeoutlen = 300
    end,
    config = function()
        require("which-key").setup()

        require("which-key").register({
            ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
            ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
            ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
            ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
            ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
        })
    end,
}
