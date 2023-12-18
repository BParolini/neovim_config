return {
    "simrat39/rust-tools.nvim",
    config = function()
        local rt = require("rust-tools")
        local mason_registry = require("mason-registry")

        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

        rt.setup {
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            server = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            },
            tools = {
                autoSetHints = true,
                runnables = {
                    use_telescope = true,
                },
                hover_actions = {
                    auto_focus = true,
                },
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = "<-",
                    other_hints_prefix = "=>",
                    max_len_align = false,
                    max_len_align_padding = 1,
                    right_align = false,
                    right_align_padding = 7,
                },
            },
        }
    end,
}
