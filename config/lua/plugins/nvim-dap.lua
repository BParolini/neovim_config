return {
    "mfussenegger/nvim-dap",
    name = "dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",

        -- Language specific configurations
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",

        -- telescope-dap
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        dapui.setup()

        -- Language specific configurations
        require("dap-go").setup()
        require("dap-python").setup(vim.fn.getcwd() .. "/.venv/bin/python")

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { silent = true, desc = "Toggle breakpoint" })
        vim.keymap.set("n", "<leader>dT", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { silent = true, desc = "Set conditional breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { silent = true, desc = "Debug continue" })
        vim.keymap.set("n", "<leader>do", dap.step_over, { silent = true, desc = "Debug step over" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { silent = true, desc = "Debug step into" })
        vim.keymap.set("n", "<leader>dI", dap.step_out, { silent = true, desc = "Debug step out" })

        -- telescope-dap
        require("telescope").load_extension("dap")
    end,
}
