return {
    on_attach = require("config.lsp_onattach").on_attach,
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = {
                enable = true,
            },
        },
    },
}
