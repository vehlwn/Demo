vim.pack.add({"https://github.com/goldos24/rainbow-variables-nvim"})
require("rainbow-variables-nvim").start_with_config(
    {
        reduce_color_collisions = true,
        semantic_background_colors = false
    }
)
