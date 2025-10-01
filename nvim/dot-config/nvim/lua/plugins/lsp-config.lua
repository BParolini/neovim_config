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
            "b0o/schemastore.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig/util")

            require("lspconfig.ui.windows").default_options.border = "rounded"

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

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            --- Prepares `on_attach` for LSP clientside
            --- @param _ vim.lsp.Client
            --- @param bufnr number
            local on_attach = function(_, bufnr)
                local keymap, lsp, fn, diagnostic = vim.keymap, vim.lsp, vim.fn, vim.diagnostic

                keymap.set("n", "gd", lsp.buf.definition, { buffer = bufnr, noremap = true, desc = "Go to definition", silent = true })
                keymap.set("n", "gi", lsp.buf.implementation, { buffer = bufnr, noremap = true, desc = "Go to implementation", silent = true })
                keymap.set("n", "gD", lsp.buf.declaration, { buffer = bufnr, noremap = true, desc = "Go to declaration", silent = true })
                keymap.set("n", "gt", lsp.buf.type_definition, { buffer = bufnr, noremap = true, desc = "Go to type declaration", silent = true })
                keymap.set("n", "K", lsp.buf.hover, { buffer = bufnr, noremap = true, desc = "Show documentation", silent = true })
                keymap.set("n", "<leader>vd", diagnostic.open_float, { buffer = bufnr, noremap = true, desc = "Show diagnostics window", silent = true })
                keymap.set("n", "[d", function()
                    diagnostic.jump({ count = -1, float = true })
                end, { buffer = bufnr, noremap = true, desc = "Go to previous diagnostic", silent = true })
                keymap.set("n", "]d", function()
                    diagnostic.jump({ count = 1, float = true })
                end, { buffer = bufnr, noremap = true, desc = "Go to next diagnostic", silent = true })
                keymap.set("n", "<leader>de", diagnostic.open_float, { buffer = bufnr, noremap = true, desc = "Show diagnostic error message" })
                keymap.set("n", "<leader>ca", lsp.buf.code_action, { buffer = bufnr, noremap = true, desc = "Show code actions", silent = true })
                keymap.set("n", "<leader>cr", lsp.buf.rename, { buffer = bufnr, noremap = true, desc = "Rename element", silent = true })
                keymap.set("n", "<leader>he", lsp.buf.signature_help, { buffer = bufnr, noremap = true, desc = "Show signature help", silent = true })

                --- FZF LSP keybindings
                local fzf = require("fzf-lua")
                keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "FZF LSP document symbols", silent = true })
                keymap.set("n", "<leader>fS", fzf.lsp_workspace_symbols, { desc = "FZF LSP workspace symbols", silent = true })
                keymap.set("n", "<leader>fl", fzf.lsp_references, { desc = "FZF LSP references", silent = true })
                keymap.set("n", "<leader>ft", fzf.lsp_live_workspace_symbols, { desc = "FZF LSP workspace diagnostics", silent = true })
                keymap.set("n", "<leader>fo", fzf.lsp_definitions, { desc = "FZF LSP definition", silent = true })
                keymap.set("n", "<leader>fm", fzf.lsp_implementations, { desc = "FZF LSP implementations", silent = true })
                keymap.set("n", "<leader>fc", fzf.lsp_code_actions, { desc = "FZF LSP code actions", silent = true })
            end

            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            lspconfig.pylsp.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "python" },
                settings = {
                    pylsp = {
                        configurationSources = { "flake8" },
                        plugins = {
                            autopepe8 = {
                                enabled = false,
                            },
                            flake8 = {
                                enabled = true,
                                config = ".flake8",
                            },
                        },
                    },
                },
            })

            local schemastore = require("schemastore")
            lspconfig.jsonls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = schemastore.json.schemas(),
                        validate = {
                            enable = true,
                        },
                    },
                },
            })

            lspconfig.yamlls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemastore = {
                            enable = false,
                            url = "",
                        },
                        schemas = schemastore.yaml.schemas(),
                    },
                },
            })

            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "c", "h", "cpp", "hpp", "objc", "objcpp", "cuda" },
            })

            lspconfig.bashls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "bash", "zsh", "sh" },
            })

            for _, lsp in ipairs({ "html", "htmx" }) do
                lspconfig[lsp].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    filetypes = { "html", "templ" },
                })
            end

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

            for _, lsp_item in ipairs(lsps) do
                lspconfig[lsp_item].setup({
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
