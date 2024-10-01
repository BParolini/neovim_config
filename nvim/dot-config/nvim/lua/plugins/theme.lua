local catppuccin = {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.o.termguicolors = true
        require("catppuccin").setup({
            flavour = "mocha",
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true,
            term_colors = true,
        })

        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}

local rose_pine = {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    priority = 1000,
    config = function()
        vim.o.termguicolors = true
        require("rose-pine").setup({
            variant = "auto",
            dark_variant = "main",
            dim_inactive_windows = false,
            extend_background_behind_borders = true,
        })

        vim.cmd.colorscheme("rose-pine")
    end,
}

local eldritch = {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("eldritch")
    end,
}

return catppuccin
