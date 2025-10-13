return {
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
