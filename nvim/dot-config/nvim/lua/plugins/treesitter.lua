--- @type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        init = function()
            local ensureInstalled = {
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",
                "diff",
                "dockerfile",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "groovy",
                "html",
                "hurl",
                "java",
                "javascript",
                "json",
                "kotlin",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "ocaml",
                "properties",
                "proto",
                "python",
                "regex",
                "rust",
                "sql",
                "templ",
                "tmux",
                "toml",
                "typescript",
                "vim",
                "yaml",
            }
            local alreadyInstalled = require("nvim-treesitter.config").get_installed()
            local parseToInstall = vim.iter(ensureInstalled)
                :filter(function(parser)
                    return not vim.tbl_contains(alreadyInstalled, parser)
                end)
                :totable()
            require("nvim-treesitter").install(parseToInstall)

            -- highlight and indentation
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    -- Enable treesitter highlighting and disable regex syntax
                    pcall(vim.treesitter.start)
                    -- Enable treesitter-based indetation
                    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                end,
            })

            require("nvim-treesitter").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                branch = "main",
            },
        },
        opts = {
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true or false
                    include_surrounding_whitespace = true,
                },
            },
        },
    },
}
