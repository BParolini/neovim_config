-- region Formatting
local M = {}

--- Create an autocommand group for formatting
--- @param client vim.lsp.Client
--- @param bufnr number
function M.create_formatting_augroup(client, bufnr)
    local api, lsp = vim.api, vim.lsp
    local formattingGroup = api.nvim_create_augroup("LspFormatting", {
        clear = false,
    })

    if client.supports_method("textDocument/formatting") then
        api.nvim_clear_autocmds({
            group = formattingGroup,
            buffer = bufnr,
        })
        api.nvim_create_autocmd("BufWritePre", {
            group = formattingGroup,
            buffer = bufnr,
            callback = function()
                lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

return M
-- endregion
