return {
    {
        "folke/lazydev.nvim",
        dependencies = {
            "justinsgithub/wezterm-types",
        },
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                "lazy.nvim",
                "LazyVim",
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "wezterm-types",      mods = { "wezterm" } },
            },
        },
    },
}
