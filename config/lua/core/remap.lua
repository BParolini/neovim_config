-- disabling arrow keys within all modes to enforce vim motion learning
local options = { noremap = true }
vim.keymap.set("", "<Up>", "<nop>", options)
vim.keymap.set("", "<Down>", "<nop>", options)
vim.keymap.set("", "<Left>", "<nop>", options)
vim.keymap.set("", "<Right>", "<nop>", options)

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving the cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scrolls half a page down keeping the cursor in the middle" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scrolls half a page up keeping the cursor in the middle" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>gg", vim.lsp.buf.format, { desc = "Format current buffer" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Sources the current file" })
