local mason_servers = {
    "bashls",
    "lua_ls",
    "taplo",
}
local manual_servers = {
    "clangd",
    "gopls",
    "pyright",
    "rust_analyzer",
}
local conform_formatters = {
    python = { "isort", "black" }
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
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            for _, server in pairs(manual_servers) do
                lspconfig[server].setup({ capabilities = capabilities })
            end

            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({ capabilities = capabilities })
                end,
                ["lua_ls"] = function()
                    lspconfig["lua_ls"].setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    })
                end
            })
        end
    },
    "neovim/nvim-lspconfig",
    "zapling/mason-conform.nvim",
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = conform_formatters,
        },
    },
}
