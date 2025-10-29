local keymap = vim.keymap

-- disabling arrow keys within all modes to enforce vim motion learning
---@type table
local options = { noremap = true }

keymap.set("", "<Up>", "<nop>", options)
keymap.set("", "<Down>", "<nop>", options)
keymap.set("", "<Left>", "<nop>", options)
keymap.set("", "<Right>", "<nop>", options)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving the cursor" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scrolls half a page down keeping the cursor in the middle" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scrolls half a page up keeping the cursor in the middle" })
keymap.set("n", "<C-f>", "<C-f>zz", { desc = "Scrolls a page down keeping the cursor in the middle" })
keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Scrolls a page up keeping the cursor in the middle" })
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "Q", "<nop>")

-- Quickfix keymaps
keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Opens the quickfix window" })
keymap.set("n", "<leader>qx", "<cmd>cclose<CR>", { desc = "Closeds the quickfix window" })
keymap.set("n", "<leader>qj", "<cmd>cnext<CR>zz", { desc = "Moves to the next element in quickfix window" })
keymap.set("n", "<leader>qk", "<cmd>cprev<CR>zz", { desc = "Moves to the previous element in quickfix window" })

-- Location list keymaps
keymap.set("n", "<leader>lj", "<cmd>lnext<CR>zz", { desc = "Moves to the next element in location list " })
keymap.set("n", "<leader>lk", "<cmd>lprev<CR>zz", { desc = "Moves to the previous element in location list " })

keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

keymap.set("n", "<leader><leader>", "<cmd>source %<CR>", { desc = "Sources the current file" })

keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { silent = true, desc = "Clear search highlights" })

-- setting keymaps for the system clipboard
keymap.set({ "n", "v" }, "<leader>y", '"*y', { silent = true, desc = "Yank selected text to system clipboard" })
keymap.set({ "n", "v" }, "<leader>Y", '"*Y', { silent = true, desc = "Yank line to system clipboard" })
keymap.set({ "n", "v" }, "<leader>p", '"*p', { silent = true, desc = "Paste from system clipboard" })
keymap.set({ "n", "v" }, "<leader>P", '"*P', { silent = true, desc = "Paste from system clipboard before cursor" })

-- windows management
keymap.set("n", "<leader>sv", "<C-w>v", { silent = true, desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { silent = true, desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { silent = true, desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { silent = true, desc = "Close current split" })

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { silent = true, desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { silent = true, desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { silent = true, desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { silent = true, desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { silent = true, desc = "Open current buffer in new tab" })
