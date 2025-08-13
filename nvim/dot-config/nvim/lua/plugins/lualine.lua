--- @type string[]
local themes = {
    "auto",
    "dracula",
    "gruvbox",
    "nord",
    "tokyonight",
    "catppuccin",
}

--- @type LazyPluginSpec
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            icons_enabled = true,
            theme = themes[6],
        },
    },
}
