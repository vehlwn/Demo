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
}

return {
    {
        "williamboman/mason.nvim",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
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
        end
    },
    "neovim/nvim-lspconfig",
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = conform_formatters,
        },
    },
    {
        "zapling/mason-conform.nvim",
        opts = {}
    }
}
