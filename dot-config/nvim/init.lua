local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local lazy_opts = {
    ui = {
        border = "double",
    },
    change_detection = {
        notify = false,
    },
    checker = {
        enabled = true,
        notify = false,
    },
}
require("core.remap")
require("core.set")
require("lazy").setup("plugins", lazy_opts)
require("core.ft")
