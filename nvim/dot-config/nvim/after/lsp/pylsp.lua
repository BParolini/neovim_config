---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.pylsp
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
}
