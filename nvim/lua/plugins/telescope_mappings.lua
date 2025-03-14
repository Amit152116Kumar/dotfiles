require "plugins.mappings"

return {
    {
        "AstroNvim/astrolsp",
        ---@param opts AstroLSPOpts
        opts = function(_, opts)
            if opts.mappings.n.gd then
                opts.mappings.n.gd[1] = function() require("telescope.builtin").lsp_definitions { reuse_win = true } end
            end
            if opts.mappings.n.gI then
                opts.mappings.n.gI[1] = function() require("telescope.builtin").lsp_implementations { reuse_win = true } end
            end
            if opts.mappings.n.gy then
                opts.mappings.n.gy[1] = function()
                    require("telescope.builtin").lsp_type_definitions { reuse_win = true }
                end
            end
            if opts.mappings.n.grr then
                opts.mappings.n.grr[1] = function() require("telescope.builtin").lsp_references { reuse_win = true } end
            end
            -- if opts.mappings.n.grw then
            --   opts.mappings.n.grw[1] = function() require("telescope.builtin").lsp_workspace_symbols { reuse_win = true } end
            -- end
            -- if opts.mappings.n.gs then
            --   opts.mappings.n.gs[1] = function() require("telescope.builtin").lsp_document_symbols { reuse_win = true } end
            -- end
            if opts.mappings.n["<Leader>lR"] then
                opts.mappings.n["<Leader>lR"][1] = function() require("telescope.builtin").lsp_references() end
            end
            if opts.mappings.n["<Leader>lG"] then
                opts.mappings.n["<Leader>lG"][1] = function()
                    vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
                        if query then
                            -- word under cursor if given query is empty
                            if query == "" then query = vim.fn.expand "<cword>" end
                            require("telescope.builtin").lsp_workspace_symbols {
                                query = query,
                                prompt_title = ("Find word (%s)"):format(query),
                            }
                        end
                    end)
                end
            end
        end,
    },
    {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
            if opts.mappings.n["<leader>xq"] then
                opts.mappings.n["<leader>xq"][1] = function() require("telescope.builtin").quickfix() end
            end
        end,
    },
}
