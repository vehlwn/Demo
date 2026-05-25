vim.pack.add({"https://github.com/nvim-lualine/lualine.nvim"})
require('lualine').setup {
    options = {
        theme = "powerline_dark",
    },
    sections = {
        lualine_c = { {
            "filename",
            -- Relative path
            path = 1
        } }
    },
}
