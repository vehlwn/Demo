-- :h restore-cursor
vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("RestoreCursor", {}),
    buffer = 0,
    once = true,
    callback = function()
        local line = vim.fn.line("'\"")
        local filetype = vim.bo.filetype
        if 1 <= line and line <= vim.fn.line("$") and not filetype:match('commit')
            and not vim.tbl_contains({'xxd', 'gitrebase'}, filetype) then
            vim.cmd("normal! g`\"")
        end
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("NoUndoForTmp", {}),
    pattern = "/tmp/*",
    callback = function()
        vim.opt_local.undofile = false
    end
})

vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("OpenDiagnostics", {}),
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end
})
