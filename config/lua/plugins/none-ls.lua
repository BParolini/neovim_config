return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.google_java_format,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.xmlformat,
                null_ls.builtins.formatting.yamlfmt,
                null_ls.builtins.formatting.jq,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.autopep8,
                null_ls.builtins.formatting.ocamlformat,
                null_ls.builtins.formatting.rustfmt,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.golines,
                null_ls.builtins.formatting.markdownlint,

                null_ls.builtins.diagnostics.luacheck,
                null_ls.builtins.diagnostics.flake8,
                null_ls.builtins.diagnostics.shellcheck,
                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.diagnostics.cmake_lint,
                null_ls.builtins.diagnostics.markdownlint,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
    end,
}
