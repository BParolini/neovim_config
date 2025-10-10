--- @type LazyPluginSpec[]
return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "bashls",
                "buf_ls",
                "clangd",
                "cmake",
                "cssls",
                "cucumber_language_server",
                "docker_compose_language_service",
                "dockerls",
                "emmet_ls",
                "gopls",
                "gradle_ls",
                "helm_ls",
                "html",
                "htmx",
                "jdtls",
                "jsonls",
                "kotlin_language_server",
                "lua_ls",
                "marksman",
                "postgres_lsp",
                "pylsp",
                "rust_analyzer",
                "tailwindcss",
                "templ",
                "terraformls",
                "ts_ls",
                "yamlls",
            },
            automatic_installation = true,
            automatic_enable = false,
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "beautysh",
                "black",
                "buf",
                "clang-format",
                "cmakelang",
                "cmakelang",
                "cmakelint",
                "codelldb",
                "debugpy",
                "delve",
                "eslint_d",
                "flake8",
                "go-debug-adapter",
                "goimports",
                "golines",
                "google-java-format",
                "jq",
                "kotlin-debug-adapter",
                "luacheck",
                "markdownlint",
                "prettier",
                "prettierd",
                "shellcheck",
                "stylua",
                "terraform",
                "tflint",
                "xmlformatter",
                "yamlfmt",
                "yamllint",
            },
            automatic_installation = true,
            debounce_hours = 12,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            {
                "b0o/schemastore.nvim",
                url = "git@github.com:b0o/SchemaStore.nvim.git",
            },
        },
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"

            --- Config diagnostic messages
            --- @type vim.diagnostic.Opts
            vim.diagnostic.config({
                severity_sort = true,
                --- @type vim.diagnostic.Opts.Float
                float = { border = "rounded", source = "if_many" },
                --- @type vim.diagnostic.Opts.Underline
                underline = { severity = vim.diagnostic.severity.ERROR },
                --- @type vim.diagnostic.Opts.Signs
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                },
                --- @type vim.diagnostic.Opts.VirtualText
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    --- @param diagnostic vim.Diagnostic
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }

                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            })

            vim.lsp.enable({
                "gopls",
                "pylsp",
                "jsonls",
                "yamlls",
                "clangd",
                "bashls",
                "html",
                "htmx",

                "buf_ls",
                "cmake",
                "cssls",
                "cucumber_language_server",
                "docker_compose_language_service",
                "dockerls",
                "emmet_ls",
                "jdtls",
                "kotlin_language_server",
                "lua_ls",
                "marksman",
                "postgres_lsp",
                "tailwindcss",
                "templ",
                "terraformls",
                "ts_ls",
            })

            local lsps = {
                "buf_ls",
                "cmake",
                "cssls",
                "cucumber_language_server",
                "docker_compose_language_service",
                "dockerls",
                "emmet_ls",
                "jdtls",
                "kotlin_language_server",
                "lua_ls",
                "marksman",
                "postgres_lsp",
                "tailwindcss",
                "templ",
                "terraformls",
                "ts_ls",
            }

            local on_attach = require("config.lsp_onattach")
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            for _, lsp_item in ipairs(lsps) do
                vim.lsp.config(lsp_item, {
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end
        end,
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        opts = {},
        ---@type LazyKeysSpec[]
        keys = {
            { "<leader>gmt", "<cmd>GoMod tidy<CR>", desc = "Runs go mod tidy" },
            { "<leader>gmi", "<cmd>GoMod init<CR>", desc = "Runs go mod init" },
            { "<leader>gtaj", "<cmd>GoTagAdd json<CR>", desc = "Add json tag to struct" },
            { "<leader>gtay", "<cmd>GoTagAdd yaml<CR>", desc = "Add yaml tag to struct" },
            { "<leader>gtrj", "<cmd>GoTagRm json<CR>", desc = "Removes json tag to struct" },
            { "<leader>gtry", "<cmd>GoTagRm yaml<CR>", desc = "Removes yaml tag to struct" },
            {
                "<leader>gmd",
                function()
                    vim.cmd(string.format("GoGet %s", vim.fn.input("Go mod to download (go get): ")))
                end,
                desc = "Runs go get package",
            },
            {
                "<leader>gii",
                function()
                    vim.cmd(string.format("GoImpl %s", vim.fn.input("package.Interface to implement: ")))
                end,
                desc = "Implement interface for current struct",
            },
            { "<leader>gie", "<cmd>GoIfErr<CR>", desc = "Adds if err != nil" },
        },
        build = function()
            vim.cmd([[silent! GoInstallDeps]])
        end,
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        "nwiizo/cargo.nvim",
        build = "cargo build --release",
        opts = {
            float_window = true,
            window_width = 0.8,
            window_height = 0.8,
            border = "rounded",
            auto_close = true,
            close_timeout = 5000,
        },
        ft = { "rust" },
        cmd = {
            "CargoBench",
            "CargoBuild",
            "CargoClean",
            "CargoDoc",
            "CargoNew",
            "CargoRun",
            "CargoTest",
            "CargoUpdate",
        },
    },
    {
        "mrcjkb/rustaceanvim",
        url = "git@github.com:mrcjkb/rustaceanvim.git",
        version = "^6",
        lazy = false,
        dependencies = {
            "nvim-neotest/neotest",
        },
    },
    {
        "mrcjkb/haskell-tools.nvim",
        version = "^6", -- Recommended
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },
}
