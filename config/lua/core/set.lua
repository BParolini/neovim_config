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

-- region Filetype specific configuration
api.nvim_create_autocmd("FileType", {
    pattern = { "go", "make" },
    callback = function()
        opt.expandtab = false
        opt.tabstop = 4
        opt.shiftwidth = 4
        opt.softtabstop = 4
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = "jproperties",
    callback = function()
        opt.fileencoding = "ISO-8859-1"
    end,
})
-- endregion

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
