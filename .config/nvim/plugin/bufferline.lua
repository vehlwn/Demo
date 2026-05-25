vim.pack.add({"https://github.com/akinsho/bufferline.nvim"})
require("bufferline").setup({
    options = {
        numbers = "buffer_id",
        show_buffer_close_icons = false,
        -- hide when only 1 buffer
        always_show_bufferline = false
    }
})
