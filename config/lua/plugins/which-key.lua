return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        local o = vim.o
        o.timeout = true
        o.timeoutlen = 300
    end,
    opts = {},
}
