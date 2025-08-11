return {
    "stevearc/conform.nvim",
    lazy = false,
    --- @type conform.setupOpts
    opts = {
        formatters_by_ft = {
            bash = { "beautysh" },
            c = { "clang-format" },
            closjure = { "cljfmt" },
            cmake = { "cmake_format" },
            cpp = { "clang-format" },
            css = { "prettierd", "prettier", stop_after_first = true },
            go = { "goimports", "golines", "gofmt" },
            html = { "prettierd", "prettier", stop_after_first = true },
            java = { "google-java-format" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            json = { "jq" },
            less = { "prettierd", "prettier", stop_after_first = true },
            lua = { "stylua" },
            markdown = { "markdownlint" },
            ocaml = { "ocamlformat" },
            proto = { "buf" },
            python = { "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            scss = { "prettierd", "prettier", stop_after_first = true },
            templ = { "templ" },
            terraform = { "terraform_fmt" },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            xml = { "xmlformatter" },
            yaml = { "yamlfmt" },
        },
        formatters = {
            black = {
                prepend_args = { "--fast" },
            },
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 2000,
        lsp_format = "fallback",
    },
    ---@type LazyKeysSpec[]
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ lsp_format = "fallback" })
            end,
            desc = "Format current buffer",
        },
    },
}
