return
{
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    config = function()
        require("dap-python").setup(vim.fn.getcwd() .. "/.venv/bin/python")
    end,
}
