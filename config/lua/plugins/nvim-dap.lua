return {
    "mfussenegger/nvim-dap",
    name = "dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",

        "nvim-neotest/nvim-nio",

        -- Language specific configurations
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",

        -- telescope-dap
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        local keymap, fn = vim.keymap, vim.fn

        dapui.setup()
        require("nvim-dap-virtual-text").setup()

        -- Language specific configurations
        require("dap-go").setup()
        require("dap-python").setup(fn.getcwd() .. "/.venv/bin/python")

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

        keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { silent = true, desc = "Toggle breakpoint" })
        keymap.set("n", "<leader>dT", function()
            dap.set_breakpoint(fn.input("Breakpoint condition: "))
        end, { silent = true, desc = "Set conditional breakpoint" })
        keymap.set("n", "<leader>dc", dap.continue, { silent = true, desc = "Debug continue" })
        keymap.set("n", "<leader>do", dap.step_over, { silent = true, desc = "Debug step over" })
        keymap.set("n", "<leader>di", dap.step_into, { silent = true, desc = "Debug step into" })
        keymap.set("n", "<leader>dI", dap.step_out, { silent = true, desc = "Debug step out" })
        keymap.set("n", "<leader>ds", dap.terminate, { silent = true, desc = "Debug stop" })

        -- telescope-dap
        require("telescope").load_extension("dap")
    end,
}
