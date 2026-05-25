vim.pack.add({"https://github.com/ibhagwan/fzf-lua"})
vim.keymap.set("n", "<C-p>", function()
    require("fzf-lua").files()
end)
