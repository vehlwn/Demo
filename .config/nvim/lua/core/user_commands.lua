vim.api.nvim_create_user_command("Tralling", [[
    :%s/\s\+$//e
    :nohlsearch
]], {})

vim.api.nvim_create_user_command("Format", function()
    require("conform").format({ async = false, lsp_format = "fallback" })
end, {})

vim.keymap.set("n", "<Leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
vim.keymap.set("n", "<Leader>td", vim.lsp.buf.type_definition)

vim.keymap.set("n", "<F2>", vim.lsp.buf.definition)
vim.keymap.set("n", "<F4>", "<CMD>ClangdSwitchSourceHeader<CR>")

vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set({ "n", "v" }, "<S-k>", vim.lsp.buf.hover)

-- move inside wrapped lines
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "gk", "k")
vim.keymap.set("n", "gj", "j")
