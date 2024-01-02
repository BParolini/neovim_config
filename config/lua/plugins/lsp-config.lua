return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "clangd",
                    "cmake",
                    "dockerls",
                    "docker_compose_language_service",
                    "emmet_ls",
                    "jdtls",
                    "jsonls",
                    "gopls",
                    "lua_ls",
                    "marksman",
                    "ocamllsp",
                    "pylsp",
                    "rust_analyzer",
                    "yamlls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig/util")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = function(_, bufnr)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                    { buffer = bufnr, noremap = true, desc = "Go to definition", silent = true })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                    { buffer = bufnr, noremap = true, desc = "Go to implementation", silent = true })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                    { buffer = bufnr, noremap = true, desc = "Go to declaration", silent = true })
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
                    { buffer = bufnr, noremap = true, desc = "Go to type declaration", silent = true })
                vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references,
                    { buffer = bufnr, noremap = true, desc = "Show references", silent = true })
                vim.keymap.set("n", "K", vim.lsp.buf.hover,
                    { buffer = bufnr, noremap = true, desc = "Show documentation", silent = true })
                vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol(vim.fn.input("Grep > ")) end,
                    { buffer = bufnr, noremap = true, desc = "Find symbol", silent = true })
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float,
                    { buffer = bufnr, noremap = true, desc = "Show diagnostics window", silent = true })
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next,
                    { buffer = bufnr, noremap = true, desc = "Go to next diagnostic", silent = true })
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev,
                    { buffer = bufnr, noremap = true, desc = "Go to previous diagnostic", silent = true })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
                    { buffer = bufnr, noremap = true, desc = "Show code actions", silent = true })
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references,
                    { buffer = bufnr, noremap = true, desc = "Show references", silent = true })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                    { buffer = bufnr, noremap = true, desc = "Rename element", silent = true })
                vim.keymap.set("i", "<leader>he", vim.lsp.buf.signature_help,
                    { buffer = bufnr, noremap = true, desc = "Show signature help", silent = true })
            end

            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })

            lspconfig.gopls.setup {
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
                    }
                },
            }

            lspconfig.pylsp.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            flake8 = {
                                enabled = true
                            }
                        }
                    }
                }
            }

            local lsps = {
                "bashls", "clangd", "cmake", "dockerls", "docker_compose_language_service",
                "emmet_ls", "jdtls", "jsonls", "marksman", "ocamllsp", "rust_analyzer", "yamlls",
            }

            for _, lsp_item in ipairs(lsps) do
                lspconfig[lsp_item].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end
        end,
    },
}
