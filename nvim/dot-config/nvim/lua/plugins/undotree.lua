return {
    "mbbill/undotree",
    ---@type LazyKeysSpec[]
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree", silent = true },
    },
}
