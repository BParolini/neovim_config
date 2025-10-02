--- @type LazyPluginSpec
return {
    "szw/vim-maximizer",
    url = "git@github.com:szw/vim-maximizer.git",
    ---@type LazyKeysSpec[]
    keys = {
        { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
}
