return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        vim.o.termguicolors = true
        require("rose-pine").setup({
            variant = "auto",
            dark_variant = "main",
            dim_inactive_windows = false,
            extend_background_behind_borders = true,
        })

        -- vim.cmd.colorscheme("rose-pine")
    end,
}
