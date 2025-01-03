-- Multiple themes are configured here, but only one is returned at the end of the file.
-- By configuring things this way, I can have multiple configurations, but Lazy will download
-- only the used one.

local themes = {
    catppuccin = {
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
    },

    nord = {
        "shaunsingh/nord.nvim",
        lazy = false,
        name = "nord",
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            vim.g.nord_contrast = true
            vim.g.nord_borders = true
            vim.g.nord_bold = false

            vim.cmd.colorscheme("nord")
        end,
    },

    rose_pine = {
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
    },

    eldritch = {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            vim.cmd.colorscheme("eldritch")
        end,
    },
    tokyonight = {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            vim.cmd.colorscheme("tokyonight-moon")
        end,
    },
}

return themes.tokyonight
