local api = vim.api

api.nvim_create_augroup("TextGroup", {
    clear = false,
})

api.nvim_create_autocmd("TextYankPost", {
    group = "TextGroup",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 300,
        })
    end,
})
