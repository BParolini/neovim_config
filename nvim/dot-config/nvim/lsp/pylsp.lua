return {
    on_attach = require("config.lsp_onattach").on_attach,
    capabilities = require("blink.cmp").get_lsp_capabilities(),
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
}
