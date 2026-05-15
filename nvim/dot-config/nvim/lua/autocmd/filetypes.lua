local opt, api = vim.opt, vim.api

-- region Filetype specific configuration
api.nvim_create_augroup("FileTypeSpecific", {
    clear = false,
})

api.nvim_create_autocmd("FileType", {
    pattern = { "*.go", "[Mm]akefile" },
    group = "FileTypeSpecific",
    callback = function()
        opt.expandtab = false
        opt.tabstop = 4
        opt.shiftwidth = 4
        opt.softtabstop = 4
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = "jproperties",
    group = "FileTypeSpecific",
    callback = function()
        opt.fileencoding = "ISO-8859-1"
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = {
            "*.css",
            "*.html",
            "*.htmx",
            "*.js",
            "*.json",
            "*.jsx",
            "*.less",
            "*.scss",
            "*.ts",
            "*.tsx",
            "*.vue",
            "*.xml",
            "*.xsd",
            "*.yaml",
    },
    group = "FileTypeSpecific",
    callback = function()
        opt.tabstop = 2
        opt.shiftwidth = 2
        opt.softtabstop = 2
    end,
})
-- endregion
