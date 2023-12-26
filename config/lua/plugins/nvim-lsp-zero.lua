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
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local lsp = require('lsp-zero')

        lsp.preset('recommended')

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
                lsp.default_setup,
            },
        })

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<C-space>'] = cmp.mapping.complete(),
        })

        lsp.on_attach(function(_, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        lsp.format_on_save({
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

        lsp.setup()

        local lspconfig = require("lspconfig")
        local util = require("lspconfig/util")
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        })

        lsp.setup_servers({
            "bashls", "clangd", "cmake", "dockerls", "docker_compose_language_service",
            "emmet_ls", "jsonls", "lua_ls", "marksman", "ocamllsp", "rust_analyzer", "yamlls",
        })

        lspconfig.gopls.setup {
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
    end,
}
