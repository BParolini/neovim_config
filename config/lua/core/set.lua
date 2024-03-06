local opt, api = vim.opt, vim.api

-- Appearance
opt.nu = true
opt.relativenumber = true
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"

-- Tab / indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

require("core.file_autocmd")

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
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "utf-8"

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.isfname:append("@-@")

opt.updatetime = 50
