return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
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
                    "dockerls",
                    "docker_compose_language_service",
                    "emmet_ls",
                    "gopls",
                    "hls",
                    "jdtls",
                    "jsonls",
                    "lua_ls",
                    "marksman",
                    "ocamllsp",
                    "pylsp",
                    "rust_analyzer",
                    "yamlls",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
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

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = function(_, bufnr)
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
                keymap.set("i", "<leader>he", lsp.buf.signature_help, { buffer = bufnr, noremap = true, desc = "Show signature help", silent = true })
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
                        plugins = {
                            flake8 = {
                                enabled = true,
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

            local lsps = {
                "bashls",
                "clangd",
                "cmake",
                "dockerls",
                "docker_compose_language_service",
                "emmet_ls",
                "hls",
                "jdtls",
                "jsonls",
                "lua_ls",
                "marksman",
                "ocamllsp",
                "yamlls",
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
