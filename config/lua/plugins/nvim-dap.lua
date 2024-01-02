return {
    {
        "mfussenegger/nvim-dap",
        name = "dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui", name = "dapui" },
            "theHamsta/nvim-dap-virtual-text",
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

            vim.keymap.set("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>", { silent = true, desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true, desc = "Set conditional breakpoint" })
            vim.keymap.set("n", "<F9>", ":lua require('dap').continue()<CR>", { silent = true, desc = "Debug continue" })
            vim.keymap.set("n", "<F8>", ":lua require('dap').step_over()<CR>", { silent = true, desc = "Debug step over" })
            vim.keymap.set("n", "<F7>", ":lua require('dap').step_into()<CR>", { silent = true, desc = "Debug step into" })
            vim.keymap.set("n", "<F6>", ":lua require('dap').step_out()<CR>", { silent = true, desc = "Debug step out" })
            vim.keymap.set("n", "<F5>", ":lua require('dap').repl_open()<CR>", { silent = true, desc = "Debug open REPL" })
        end,
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        config = function()
            require("dap-go").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
            require("dap-python").setup(vim.fn.getcwd() .. "/.venv/bin/python")
        end,
    },
}
