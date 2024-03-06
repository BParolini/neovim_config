local keymap, lsp, cmd = vim.keymap, vim.lsp, vim.cmd

-- disabling arrow keys within all modes to enforce vim motion learning
local options = { noremap = true }

keymap.set("", "<Up>", "<nop>", options)
keymap.set("", "<Down>", "<nop>", options)
keymap.set("", "<Left>", "<nop>", options)
keymap.set("", "<Right>", "<nop>", options)

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving the cursor" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scrolls half a page down keeping the cursor in the middle" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scrolls half a page up keeping the cursor in the middle" })
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<leader>gg", lsp.buf.format, { desc = "Format current buffer" })

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

keymap.set("n", "<leader><leader>", function()
    cmd("so")
end, { desc = "Sources the current file" })

keymap.set("n", "<leader>y", '"*y', { silent = true, desc = "Yank to system clipboard" })
keymap.set("n", "<leader>p", '"*p', { silent = true, desc = "Paste from system clipboard" })
keymap.set("n", "<leader>P", '"*P', { silent = true, desc = "Paste from system clipboard before cursor" })
