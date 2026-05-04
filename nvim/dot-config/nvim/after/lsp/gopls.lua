---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.gopls
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
}
