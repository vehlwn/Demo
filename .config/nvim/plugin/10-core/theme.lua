local base16 = require("base16")
base16(base16.themes["tomorrow-night"], true)

vim.cmd.highlight({ "MatchParen", "guibg = NONE", "guifg = Magenta" })

for _, v in pairs({
    "IlluminatedWordText", "IlluminatedWordRead", "IlluminatedWordWrite"
}) do
    vim.cmd.highlight({ v, "guibg = #054016", "gui = NONE" })
end
