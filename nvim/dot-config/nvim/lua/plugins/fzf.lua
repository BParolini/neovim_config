--- @type LazyPluginSpec
return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    --- @type fzf-lua.Config
    opts = {},
    --- @type LazyKeysSpec[]
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "FZF find files",
        },
        {
            "<leader>fg",
            function()
                require("fzf-lua").git_files()
            end,
            desc = "FZF find Git files",
        },
        {
            "<leader>fj",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "FZF live grep",
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "FZF grep word under cursor (strictly delimited)",
        },
        {
            "<leader>fW",
            function()
                require("fzf-lua").grep_cWORD()
            end,
            desc = "FZF grep word under cursor (blank space delimited)",
        },
        {
            "<leader>fh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "FZF help tags",
        },
        {
            "<leader>fk",
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "FZF keymaps",
        },
        {
            "<leader>fd",
            function()
                require("fzf-lua").diagnostics_workspace()
            end,
            desc = "FZF diagnostics",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").resume()
            end,
            desc = "FZF resume",
        },
        {
            "<leader>f.",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "FZF old files",
        },
        {
            "<leader>fb",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "FZF buffers",
        },
        {
            "<leader>fi",
            function()
                require("fzf-lua").files({
                    cwd = vim.fn.stdpath("config")
                })
            end,
            desc = "FZF Neovim config files",
        },
        {
            "<leader>fp",
            function()
                require("fzf-lua").files({
                    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
                })
            end,
            desc = "FZF Neovim data files",
        },
    },
}
