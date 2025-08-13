-- Multiple themes are configured here, but only one is returned at the end of the file.
-- By configuring things this way, I can have multiple configurations, but Lazy will download
-- only the used one.

--- @type LazyPluginSpec[]
local themes = {
    --- @type LazyPluginSpec
    catppuccin = {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        build = ":CatppuccinCompile",
        opts = {
            flavour = "mocha",
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true,
            term_colors = true,
            compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        },
        config = function(_, opts)
            vim.o.termguicolors = true
            require("catppuccin").setup(opts)

            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },

    --- @type LazyPluginSpec
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

    --- @type LazyPluginSpec
    rose_pine = {
        "rose-pine/neovim",
        lazy = false,
        name = "rose-pine",
        priority = 1000,
        opts = {
            variant = "main", -- auto, main, moon, or dawn
            dark_variant = "main",
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            styles = {
                transparency = false,
            },
        },
        config = function(_, opts)
            vim.o.termguicolors = true
            require("rose-pine").setup(opts)

            vim.cmd.colorscheme("rose-pine")
        end,
    },

    --- @type LazyPluginSpec
    kanagawa = {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        build = ":KanagawaCompile",
        opts = {
            compile = true,
            theme = "wave", -- wave, dragon, lotus
            background = {
                dark = "wave",
                light = "lotus",
            },
        },
        config = function(_, opts)
            vim.o.termguicolors = true
            require("kanagawa").setup(opts)

            vim.cmd.colorscheme("kanagawa")
        end,
    },

    --- @type LazyPluginSpec
    eldritch = {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            vim.cmd.colorscheme("eldritch")
        end,
    },

    --- @type LazyPluginSpec
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

return themes.catppuccin
