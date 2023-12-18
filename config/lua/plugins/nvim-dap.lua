return {
    "mfussenegger/nvim-dap",
    name = "dap",
    dependencies = {
        { "rcarriga/nvim-dap-ui", name = "dapui" },
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>")
        vim.keymap.set("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
        vim.keymap.set("n", "<F9>", ":lua require('dap').continue()<CR>")
        vim.keymap.set("n", "<F8>", ":lua require('dap').step_over()<CR>")
        vim.keymap.set("n", "<F7>", ":lua require('dap').step_into()<CR>")
        vim.keymap.set("n", "<F6>", ":lua require('dap').step_out()<CR>")
        vim.keymap.set("n", "<F5>", ":lua require('dap').repl_open()<CR>")
    end,
}
