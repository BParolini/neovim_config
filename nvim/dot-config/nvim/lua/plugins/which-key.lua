--- @type LazyPluginSpec
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        local o = vim.o
        o.timeout = true
        o.timeoutlen = 300
    end,
    opts = {
        preset = "modern",
    },
}
