vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/zapling/mason-conform.nvim",
})

local mason_servers = {
    "bashls",
    "lua_ls",
    "taplo",
    "ts_ls",
}
local manual_servers = {
    "clangd",
    "gopls",
    "pyright",
    "rust_analyzer",
}
local conform_formatters = {
    html = { "prettier" },
    json = { "prettier" },
    python = { "isort", "black" },
    typescript = { "prettier" },
    yaml = { "prettier" },
    cmake = { "cmake_format" }
}

require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = mason_servers,
})

for _, server in pairs(manual_servers) do
    vim.lsp.enable(server)
end

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = {
                    "vim",
                    "require",
                },
            },
        },
    },
})

require("conform").setup({
    formatters_by_ft = conform_formatters,
})

require("mason-conform").setup()
