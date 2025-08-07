return {
    "lewis6991/gitsigns.nvim",
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, { silent = true, desc = "Git - Go to next diff" })

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, { silent = true, desc = "Git - Go to previous diff" })

            -- Actions
            map("n", "<leader>hs", gitsigns.stage_hunk, { silent = true, desc = "Git stage hunk changes" })
            map("n", "<leader>hr", gitsigns.reset_hunk, { silent = true, desc = "Git reset hunk changes" })
            map("v", "<leader>hs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { silent = true, desc = "Git stage selected block" })
            map("v", "<leader>hr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { silent = true, desc = "Git reset selected block" })
            map("n", "<leader>hS", gitsigns.stage_buffer, { silent = true, desc = "Git stage file changes" })
            map("n", "<leader>hu", gitsigns.undo_stage_hunk, { silent = true, desc = "Git unstage hunk changes" })
            map("n", "<leader>hR", gitsigns.reset_buffer, { silent = true, desc = "Git reset buffer" })
            map("n", "<leader>hp", gitsigns.preview_hunk, { silent = true, desc = "Git preview hunk" })
            map("n", "<leader>hb", function()
                gitsigns.blame_line({ full = true })
            end, { silent = true, desc = "Git blame" })
            map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { silent = true, desc = "Git toggle line blame" })
            map("n", "<leader>hd", gitsigns.diffthis, { silent = true, desc = "Git show diff" })

            map("n", "<leader>hD", function()
                gitsigns.diffthis("~")
            end, { silent = true, desc = "Git show diff" })
            map("n", "<leader>td", gitsigns.toggle_deleted, { silent = true, desc = "Git toggle deleted" })

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
    },
}
