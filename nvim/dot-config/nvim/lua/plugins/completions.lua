return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = { "rafamadriz/friendly-snippets" },
        -- use a release tag to download pre-built binaries
        version = "1.*",
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = { preset = "default" },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                menu = { border = "single" },
                documentation = {
                    auto_show = true,
                    window = {
                        border = "single",
                    },
                },
            },
            signature = {
                window = {
                    border = "single",
                },
                enabled = true,
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
