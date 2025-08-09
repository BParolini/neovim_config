return {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
        formatters_by_ft = {
            bash = { "beautysh" },
            c = { "clang-format" },
            closjure = { "cljfmt" },
            cmake = { "cmake_format" },
            cpp = { "clang-format" },
            go = { "goimports", "golines", "gofmt" },
            java = { "google-java-format" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            json = { "jq" },
            lua = { "stylua" },
            markdown = { "markdownlint" },
            ocaml = { "ocamlformat" },
            proto = { "buf" },
            python = { "isort", "autopep8" },
            rust = { "rustfmt", lsp_format = "fallback" },
            terraform = { "terraform_fmt" },
            xml = { "xmlformatter" },
            yaml = { "yamlfmt" },
            css = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            scss = { "prettierd", "prettier", stop_after_first = true },
            less = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
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
