return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        -- LSP Support
        "neovim/nvim-lspconfig",
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
        },
        "williamboman/mason-lspconfig.nvim",

        "folke/neodev.nvim",
        "mfussenegger/nvim-lint",

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",

        -- Snippets
        "L3MON4D3/LuaSnip",
    },

    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.preset('recommended')

        require("mason").setup({})

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
            handlers = {
                lsp_zero.default_setup,
            },
        })

        local cmp = require('cmp')
        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'nvim_lua' },
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        lsp_zero.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<C-space>'] = cmp.mapping.complete(),
        })

        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["bashls"] = { "sh", "bash", "zsh" },
                ["clangd"] = { "c", "cpp", "objc", "objcpp" },
                ["cmake"] = { "cmake" },
                ["dockerls"] = { "dockerfile" },
                ["docker_compose_language_service"] = { "docker-compose" },
                ["emmet_ls"] = { "html", "css", "scss", "sass", "less" },
                ["gopls"] = { "go", "gomod", "gowork", "gotmpl" },
                ["jsonls"] = { "json" },
                ["jdtls"] = { "java" },
                ["lua_ls"] = { "lua" },
                ["ocamllsp"] = { "ocaml" },
                ["pylsp"] = { "python" },
                ["rust_analyzer"] = { "rust" },
                ["yamlls"] = { "yaml" },
            }
        })

        require("neodev").setup({
            library = { plugins = { "nvim-dap-ui" }, types = true }
        })

        lsp_zero.setup()

        local lspconfig = require("lspconfig")
        local util = require("lspconfig/util")

        -- Defining default capabilities and keymaps
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
}
