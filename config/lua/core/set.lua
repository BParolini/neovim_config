local opt = vim.opt

-- Appearance
opt.background = "dark"
opt.nu = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"

-- Tab / indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false

require("autocmd.text")
require("autocmd.filetypes")

-- Behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = { os.getenv("HOME") .. "/.vim/undodir" }
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autoread = true
vim.bo.autoread = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.clipboard:append("unnamed")
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "utf-8"

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.isfname:append("@-@")

opt.updatetime = 50

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
