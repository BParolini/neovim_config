return {
    {
        "mfussenegger/nvim-dap",
        ---@type LazyKeysSpec[]
        keys = {
            { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<leader>dT", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Set conditional breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Debug continue" },
            { "<leader>do", function() require("dap").step_over() end, desc = "Debug step over" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Debug step into" },
            { "<leader>dI", function() require("dap").step_out() end, desc = "Debug step out" },
            { "<leader>ds", function() require("dap").terminate() end, desc = "Debug stop" },
        },
        config = function(_, opts)
            local dap = require("dap")
            dap.setup(opts)
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
