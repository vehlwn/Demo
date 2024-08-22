return {
    "nvim-lualine/lualine.nvim",
    opts = {
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
}
