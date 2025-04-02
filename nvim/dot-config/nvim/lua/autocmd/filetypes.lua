local opt, api = vim.opt, vim.api

-- region Filetype specific configuration
api.nvim_create_augroup("FileTypeSpecific", {
    clear = false,
})

api.nvim_create_autocmd("FileType", {
    pattern = { "go", "make" },
    group = "FileTypeSpecific",
    callback = function()
        opt.expandtab = false
        opt.tabstop = 4
        opt.shiftwidth = 4
        opt.softtabstop = 4
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = { "ml" },
    group = "FileTypeSpecific",
    callback = function()
        opt.rtp:append(os.getenv("HOME") .. "/.opam/default/share/ocp-indent/vim")
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = "jproperties",
    group = "FileTypeSpecific",
    callback = function()
        opt.fileencoding = "ISO-8859-1"
    end,
})
-- endregion
