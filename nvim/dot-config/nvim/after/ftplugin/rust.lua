vim.keymap.set("n", "<leader>dq", function()
    vim.cmd("RustLsp testables")
end, { silent = true, desc = "Debugger testtables" })
