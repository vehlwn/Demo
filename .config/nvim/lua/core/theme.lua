vim.cmd.highlight({ "MatchParen", "guibg = NONE", "guifg = Magenta" })

for _, v in pairs({
    "IlluminatedWordText", "IlluminatedWordRead", "IlluminatedWordWrite"
}) do
    vim.cmd.highlight({ v, "guibg = #054016", "gui = NONE" })
end
