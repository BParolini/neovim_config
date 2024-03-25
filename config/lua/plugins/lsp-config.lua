return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "double",
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "clangd",
                    "cmake",
                    "docker_compose_language_service",
                    "dockerls",
                    "emmet_ls",
                    "gopls",
                    "hls",
                    "html",
                    "htmx",
                    "jdtls",
                    "jsonls",
                    "kotlin_language_server",
                    "lua_ls",
                    "marksman",
                    "ocamllsp",
                    "pylsp",
                    "rust_analyzer",
                    "templ",
                    "yamlls",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "autopep8",
                "beautysh",
                "clang-format",
                "cmakelang",
                "cmakelang",
                "cmakelint",
                "codelldb",
                "delve",
                "flake8",
                "go-debug-adapter",
                "goimports",
                "golines",
                "google-java-format",
                "isort",
                "jq",
                "kotlin-debug-adapter",
                "luacheck",
                "markdownlint",
                "markdownlint",
                "ocamlformat",
                "shellcheck",
                "stylua",
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
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            require("neodev").setup({
                library = {
                    plugins = {
                        "nvim-lspconfig",
                        "nvim-dap-ui",
                    },
                    types = true,
                },
            })

            local lspconfig = require("lspconfig")
            local util = require("lspconfig/util")

            require("lspconfig.ui.windows").default_options.border = "double"

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            --- Prepares `on_attach` for LSP clientside
            --- @param client lsp.Client
            --- @param bufnr number
            local on_attach = function(client, bufnr)
                local keymap, lsp, fn, diagnostic = vim.keymap, vim.lsp, vim.fn, vim.diagnostic

                keymap.set("n", "gd", lsp.buf.definition, { buffer = bufnr, noremap = true, desc = "Go to definition", silent = true })
                keymap.set("n", "gi", lsp.buf.implementation, { buffer = bufnr, noremap = true, desc = "Go to implementation", silent = true })
                keymap.set("n", "gD", lsp.buf.declaration, { buffer = bufnr, noremap = true, desc = "Go to declaration", silent = true })
                keymap.set("n", "gt", lsp.buf.type_definition, { buffer = bufnr, noremap = true, desc = "Go to type declaration", silent = true })
                keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = bufnr, noremap = true, desc = "Show references", silent = true })
                keymap.set("n", "K", lsp.buf.hover, { buffer = bufnr, noremap = true, desc = "Show documentation", silent = true })
                keymap.set("n", "<leader>ws", function()
                    lsp.buf.workspace_symbol(fn.input("Grep > "))
                end, { buffer = bufnr, noremap = true, desc = "Find symbol", silent = true })
                keymap.set("n", "<leader>vd", diagnostic.open_float, { buffer = bufnr, noremap = true, desc = "Show diagnostics window", silent = true })
                keymap.set("n", "[d", diagnostic.goto_prev, { buffer = bufnr, noremap = true, desc = "Go to previous diagnostic", silent = true })
                keymap.set("n", "]d", diagnostic.goto_next, { buffer = bufnr, noremap = true, desc = "Go to next diagnostic", silent = true })
                keymap.set("n", "<leader>ca", lsp.buf.code_action, { buffer = bufnr, noremap = true, desc = "Show code actions", silent = true })
                keymap.set("n", "<leader>vrr", lsp.buf.references, { buffer = bufnr, noremap = true, desc = "Show references", silent = true })
                keymap.set("n", "<leader>rn", lsp.buf.rename, { buffer = bufnr, noremap = true, desc = "Rename element", silent = true })
                keymap.set("n", "<leader>he", lsp.buf.signature_help, { buffer = bufnr, noremap = true, desc = "Show signature help", silent = true })

                --- Telescope LSP keybindings
                local builtin = require("telescope.builtin")
                keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope lsp document symbols", silent = true })
                keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Telescope lsp workspace symbols", silent = true })
                keymap.set("n", "<leader>fl", builtin.lsp_references, { desc = "Telescope lsp references", silent = true })
                keymap.set("n", "<leader>ft", builtin.lsp_dynamic_workspace_symbols, { desc = "Telescope lsp workspace diagnostics", silent = true })
                keymap.set("n", "<leader>fo", builtin.lsp_definitions, { desc = "Telescope lsp definition", silent = true })
                keymap.set("n", "<leader>fm", builtin.lsp_implementations, { desc = "Telescope lsp implementations", silent = true })

                require("autocmd.formatting").create_formatting_augroup(client, bufnr)
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

            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "rust" },
                root_dir = util.root_pattern("Cargo.toml"),
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                    },
                },
            })

            local html_lsps = { "html", "htmx" }
            for _, lsp in ipairs(html_lsps) do
                lspconfig[lsp].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    filetypes = { lsp, "templ" },
                })
            end

            local lsps = {
                "bashls",
                "clangd",
                "cmake",
                "docker_compose_language_service",
                "dockerls",
                "emmet_ls",
                "hls",
                "jdtls",
                "jsonls",
                "kotlin_language_server",
                "lua_ls",
                "marksman",
                "ocamllsp",
                "templ",
                "yamlls",
            }

            for _, lsp_item in ipairs(lsps) do
                lspconfig[lsp_item].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end

            vim.filetype.add({ extension = { templ = "templ" } })
        end,
    },
    {
        "rust-lang/rust.vim",
        ft = { "rust" },
        init = function()
            vim.g.rustfmt_autosave = 1
            -- vim.g.rustfmt_fail_silently = 1
        end,
    },
    {
        "mrcjkb/haskell-tools.nvim",
        version = "^3", -- Recommended
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    },
}
