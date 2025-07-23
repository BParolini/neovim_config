return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "double",
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
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
                    "hls",
                    "html",
                    "htmx",
                    "jdtls",
                    "jsonls",
                    "kotlin_language_server",
                    "lua_ls",
                    "marksman",
                    "ocamllsp",
                    "postgres_lsp",
                    "pylsp",
                    "rust_analyzer",
                    "tailwindcss",
                    "templ",
                    "terraformls",
                    "ts_ls",
                    "yamlls",
                    "zls",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "autopep8",
                "beautysh",
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
                "haskell-debug-adapter",
                "isort",
                "jq",
                "kotlin-debug-adapter",
                "luacheck",
                "markdownlint",
                "ocamlearlybird",
                "ocamlformat",
                "prettier",
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
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            "b0o/schemastore.nvim",
        },
        config = function()
            require("neodev").setup({
                library = {
                    plugins = {
                        "nvim-lspconfig",
                        "nvim-dap-ui",
                        "neotest",
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
            --- @param client vim.lsp.Client
            --- @param bufnr number
            local on_attach = function(client, bufnr)
                local keymap, lsp, fn, diagnostic = vim.keymap, vim.lsp, vim.fn, vim.diagnostic

                keymap.set("n", "gd", lsp.buf.definition,
                    { buffer = bufnr, noremap = true, desc = "Go to definition", silent = true })
                keymap.set("n", "gi", lsp.buf.implementation,
                    { buffer = bufnr, noremap = true, desc = "Go to implementation", silent = true })
                keymap.set("n", "gD", lsp.buf.declaration,
                    { buffer = bufnr, noremap = true, desc = "Go to declaration", silent = true })
                keymap.set("n", "gt", lsp.buf.type_definition,
                    { buffer = bufnr, noremap = true, desc = "Go to type declaration", silent = true })
                keymap.set("n", "<leader>gg", lsp.buf.format, { buffer = bufnr, desc = "Format current buffer" })
                keymap.set("n", "gr", require("telescope.builtin").lsp_references,
                    { buffer = bufnr, noremap = true, desc = "Show references", silent = true })
                keymap.set("n", "K", lsp.buf.hover,
                    { buffer = bufnr, noremap = true, desc = "Show documentation", silent = true })
                keymap.set("n", "<leader>lws", function()
                    lsp.buf.workspace_symbol(fn.input("Grep > "))
                end, { buffer = bufnr, noremap = true, desc = "Find workspace symbol", silent = true })
                keymap.set("n", "<leader>vd", diagnostic.open_float,
                    { buffer = bufnr, noremap = true, desc = "Show diagnostics window", silent = true })
                keymap.set("n", "[d", diagnostic.goto_prev,
                    { buffer = bufnr, noremap = true, desc = "Go to previous diagnostic", silent = true })
                keymap.set("n", "]d", diagnostic.goto_next,
                    { buffer = bufnr, noremap = true, desc = "Go to next diagnostic", silent = true })
                keymap.set("n", "<leader>ca", lsp.buf.code_action,
                    { buffer = bufnr, noremap = true, desc = "Show code actions", silent = true })
                keymap.set("n", "<leader>vrr", lsp.buf.references,
                    { buffer = bufnr, noremap = true, desc = "Show references", silent = true })
                keymap.set("n", "<leader>rn", lsp.buf.rename,
                    { buffer = bufnr, noremap = true, desc = "Rename element", silent = true })
                keymap.set("n", "<leader>he", lsp.buf.signature_help,
                    { buffer = bufnr, noremap = true, desc = "Show signature help", silent = true })

                --- Telescope LSP keybindings
                local builtin = require("telescope.builtin")
                keymap.set("n", "<leader>fs", builtin.lsp_document_symbols,
                    { desc = "Telescope lsp document symbols", silent = true })
                keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols,
                    { desc = "Telescope lsp workspace symbols", silent = true })
                keymap.set("n", "<leader>fl", builtin.lsp_references,
                    { desc = "Telescope lsp references", silent = true })
                keymap.set("n", "<leader>ft", builtin.lsp_dynamic_workspace_symbols,
                    { desc = "Telescope lsp workspace diagnostics", silent = true })
                keymap.set("n", "<leader>fo", builtin.lsp_definitions,
                    { desc = "Telescope lsp definition", silent = true })
                keymap.set("n", "<leader>fm", builtin.lsp_implementations,
                    { desc = "Telescope lsp implementations", silent = true })

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
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
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
                "hls",
                "jdtls",
                "kotlin_language_server",
                "lua_ls",
                "marksman",
                "ocamllsp",
                "postgres_lsp",
                "tailwindcss",
                "templ",
                "terraformls",
                "ts_ls",
                "zls",
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
        ---@param opts table
        config = function(_, opts)
            require("gopher").setup(opts)

            local keymap, fn, cmd = vim.keymap, vim.fn, vim.cmd
            keymap.set("n", "<leader>gmt", "<cmd>GoMod tidy<CR>", { desc = "Runs go mod tidy" })
            keymap.set("n", "<leader>gmi", "<cmd>GoMod init<CR>", { desc = "Runs go mod init" })

            keymap.set("n", "<leader>gtaj", "<cmd>GoTagAdd json<CR>", { desc = "Add json tag to struct" })
            keymap.set("n", "<leader>gtay", "<cmd>GoTagAdd yaml<CR>", { desc = "Add yaml tag to struct" })
            keymap.set("n", "<leader>gtrj", "<cmd>GoTagRm json<CR>", { desc = "Removes json tag to struct" })
            keymap.set("n", "<leader>gtry", "<cmd>GoTagRm yaml<CR>", { desc = "Removes yaml tag to struct" })

            keymap.set("n", "<leader>gmd", function()
                cmd(string.format("GoGet %s", fn.input("Go mod to download (go get): ")))
            end, { desc = "Runs go get package" })

            keymap.set("n", "<leader>gii", function()
                cmd(string.format("GoImpl %s", fn.input("package.Interface to implement: ")))
            end, { desc = "Implement interface for current struct" })

            keymap.set("n", "<leader>gie", "<cmd>GoIfErr<CR>", { desc = "Adds if err != nil" })
        end,
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
        config = function()
            require("cargo").setup({
                float_window = true,
                window_width = 0.8,
                window_height = 0.8,
                border = "rounded",
                auto_close = true,
                close_timeout = 5000,
            })
        end,
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
        "saecki/crates.nvim",
        ft = { "toml" },
        config = function()
            require("crates").setup({
                completion = {
                    cmp = {
                        enabled = true,
                    },
                },
            })
            require("cmp").setup.buffer({
                sources = {
                    {
                        name = "creates",
                    },
                },
            })
        end,
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
        version = "^5", -- Recommended
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },
}
