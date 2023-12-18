return {
    "mhartington/formatter.nvim",
    config = function()
        require("formatter").setup({
            logging = false,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = {
                    require("formatter.filetypes.lua").stylua,
                },
                go = {
                    require("formatter.filetypes.go"),
                },
            },
        })
    end,
}
