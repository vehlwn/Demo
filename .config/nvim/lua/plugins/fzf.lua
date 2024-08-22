return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<C-p>", function() require("fzf-lua").files() end },
    }
}
