local M = {}

--- Prepares `on_attach` for LSP clientside
--- @param _ vim.lsp.Client
--- @param bufnr number
function M.on_attach(_, bufnr)
    local keymap, lsp, diagnostic = vim.keymap, vim.lsp, vim.diagnostic

    keymap.set("n", "gd", lsp.buf.definition,
        { buffer = bufnr, noremap = true, desc = "Go to definition", silent = true })
    keymap.set("n", "gi", lsp.buf.implementation,
        { buffer = bufnr, noremap = true, desc = "Go to implementation", silent = true })
    keymap.set("n", "gD", lsp.buf.declaration,
        { buffer = bufnr, noremap = true, desc = "Go to declaration", silent = true })
    keymap.set("n", "gt", lsp.buf.type_definition,
        { buffer = bufnr, noremap = true, desc = "Go to type declaration", silent = true })
    keymap.set("n", "K", lsp.buf.hover, { buffer = bufnr, noremap = true, desc = "Show documentation", silent = true })
    keymap.set("n", "<leader>vd", diagnostic.open_float,
        { buffer = bufnr, noremap = true, desc = "Show diagnostics window", silent = true })
    keymap.set("n", "[d", function()
        diagnostic.jump({ count = -1, float = true })
    end, { buffer = bufnr, noremap = true, desc = "Go to previous diagnostic", silent = true })
    keymap.set("n", "]d", function()
        diagnostic.jump({ count = 1, float = true })
    end, { buffer = bufnr, noremap = true, desc = "Go to next diagnostic", silent = true })
    keymap.set("n", "<leader>de", diagnostic.open_float,
        { buffer = bufnr, noremap = true, desc = "Show diagnostic error message" })
    keymap.set("n", "<leader>ca", lsp.buf.code_action,
        { buffer = bufnr, noremap = true, desc = "Show code actions", silent = true })
    keymap.set("n", "<leader>cr", lsp.buf.rename,
        { buffer = bufnr, noremap = true, desc = "Rename element", silent = true })
    keymap.set("n", "<leader>he", lsp.buf.signature_help,
        { buffer = bufnr, noremap = true, desc = "Show signature help", silent = true })

    --- FZF LSP keybindings
    local fzf = require("fzf-lua")
    keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "FZF LSP document symbols", silent = true })
    keymap.set("n", "<leader>fS", fzf.lsp_workspace_symbols, { desc = "FZF LSP workspace symbols", silent = true })
    keymap.set("n", "<leader>fl", fzf.lsp_references, { desc = "FZF LSP references", silent = true })
    keymap.set("n", "<leader>ft", fzf.lsp_live_workspace_symbols,
        { desc = "FZF LSP workspace diagnostics", silent = true })
    keymap.set("n", "<leader>fo", fzf.lsp_definitions, { desc = "FZF LSP definition", silent = true })
    keymap.set("n", "<leader>fm", fzf.lsp_implementations, { desc = "FZF LSP implementations", silent = true })
    keymap.set("n", "<leader>fc", fzf.lsp_code_actions, { desc = "FZF LSP code actions", silent = true })
end

return M
