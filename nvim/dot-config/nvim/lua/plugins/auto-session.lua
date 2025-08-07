return {
    "rmagatti/auto-session",
    opts = {
        auto_restore_enabled = false,
        auto_session_supress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
    },
    ---@type LazyKeysSpec[]
    keys = {
        { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
        { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
    },
}
