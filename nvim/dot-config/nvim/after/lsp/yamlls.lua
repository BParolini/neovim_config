---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.yamlls
    settings = {
        yaml = {
            schemastore = {
                enable = false,
                url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    },
}
