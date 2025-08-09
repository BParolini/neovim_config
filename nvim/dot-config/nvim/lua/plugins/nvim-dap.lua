return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local keymap, fn = vim.keymap, vim.fn

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
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",

            -- telescope-dap
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup()
            require("nvim-dap-virtual-text").setup(opts)

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
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
        },
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path, opts)
        end,
    },
}
