return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore_enabled = false,
            auto_session_supress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { silent = true, desc = "Restore session for cwd" })
        keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { silent = true, desc = "Save session for auto session root dir" })
    end,
}
