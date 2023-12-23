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

        "simrat39/rust-tools.nvim",

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
                "dockerls",
                "docker_compose_language_service",
                "emmet_ls",
                "jsonls",
                "gopls",
                "lua_ls",
                "marksman",
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
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        lsp.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["lua_ls"] = { "lua" },
                ["gopls"] = { "go", "gomod", "gowork", "gotmpl" },
                ["rust_analyzer"] = { "rust" },
                ["bashls"] = { "sh", "bash", "zsh" },
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
        lspconfig.bashls.setup {}
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
        lspconfig.rust_analyzer.setup {
            settings = {
                ['rust-analyzer'] = {}
            },
        }

        lsp.setup_servers({
            "yamlls", "dockerls", "docker_compose_language_service", "emmet_ls", "marksman",
        })

        require("rust-tools").setup({
            server = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            },
            tools = {
                autoSetHints = true,
                runnables = {
                    use_telescope = true,
                },
                hover_actions = {
                    auto_focus = true,
                },
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = "<-",
                    other_hints_prefix = "=>",
                    max_len_align = false,
                    max_len_align_padding = 1,
                    right_align = false,
                    right_align_padding = 7,
                },
            },
        })
    end,
}
