-- Customize Mason plugins

---@type LazySpec
return {
    -- use mason-lspconfig to configure LSP installations
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls", -- Lua Language Server
                "clangd", -- C++ Language Server
            },
        },
    },

    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    {
        "jay-babu/mason-null-ls.nvim",
        -- overrides `require("mason-null-ls").setup(...)`
        opts = {
            -- Add more formatters/linters as needed
            ensure_installed = {
                "stylua", -- Lua formatter
                "black", -- Python formatter
                "autoflake", -- Python formatter/utility
                "flake8", -- Python linter
                "cpplint", -- C++ linter
            },
        },
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        -- overrides `require("mason-nvim-dap").setup(...)`
        opts = {
            -- Add more debuggers as needed
            ensure_installed = {
                "codelldb", -- Debugging support for C++
                "cpptools",
                "debugpy",
            },
        },
    },
}
