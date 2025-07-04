-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

    -- == Neovim Themes
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "folke/tokyonight.nvim" },
    {
        "sainnhe/gruvbox-material",
    },
    {
        "Mofiqul/vscode.nvim",
        config = function()
            require("vscode").setup {
                style = "dark", -- or "light"
            }
        end,
    },
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("onedark").setup {
                style = "deep",
            }
        end,
    },

    -- == Examples of Adding Plugins ==

    "andweeb/presence.nvim",
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
        config = function()
            require("CopilotChat").setup {
                -- model = "claude-3.7-sonnet",
                model = "gpt-4o",
                prompts = {
                    Resuable = {
                        prompt = "Extract reusable functions or methods from this code to improve modularity and testability.",
                        system_prompt = "COPILOT_REVIEW", -- System prompt to use (can be specified manually in prompt via /).
                        description = "Reusable prompt description",
                    },
                    Refactor = {
                        prompt = "Refactor this code to improve readability and maintainability.",
                        system_prompt = "COPILOT_REVIEW", -- System prompt to use (can be specified manually in prompt via /).
                        description = "Refactor prompt description",
                    },
                    DailySummary = {
                        prompt = "Summarize the key changes and contributions made today across all code files. Highlight major features, bug fixes, refactoring, and configuration updates. Keep the summary concise and suitable for inclusion in a daily work log or team stand-up note.",
                        system_prompt = "COPILOT_INSTRUCTIONS", -- System prompt to use (can be specified manually in prompt via /).
                        description = "Daily summary prompt description",
                    },
                    ROSRefactor = {
                        prompt = "Refactor the selected code with ROS 2 best practices in mind. Preserve functionality but improve readability, modularity, and performance.",
                        system_prompt = "COPILOT_REVIEW", -- System prompt to use (can be specified manually in prompt via /).
                    },

                    ROSReview = {
                        prompt = "Review this ROS 2 C++ code for memory management, topic/service usage, and adherence to ROS 2 conventions.",
                        system_prompt = "COPILOT_REVIEW",
                        description = "ROS 2 code review prompt description",
                    },
                },
            }
        end,
    },
    {
        "tpope/vim-fugitive",
    },

    {
        -- Pretty popups for incoming calls, outgoing calls, references
        -- "nvimdev/lspsaga.nvim",
    },

    {
        -- Pretty popups for incoming calls, outgoing calls, references
        "folke/trouble.nvim",
    },
    {
        "luckasRanarison/nvim-devdocs",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            ensure_installed = { "c", "cpp", "go", "python~3.10", "lua~5.1", "bash" },
            -- previewer_cmd = "glow", -- for example: "glow"
            -- cmd_args = { "-s", "dracula", "-w", "80" }, -- example using glow: { "-s", "dark", "-w", "80" }
            cmd_ignore = {}, -- ignore cmd rendering for the listed docs
            -- picker_cmd = "glow", -- use cmd previewer in picker preview
            -- picker_cmd_args = { "-s", "dark", "-w", "80" }, -- example using glow: { "-s", "dark", "-w", "50" }
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "github/copilot.vim",
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
    },

    -- == Examples of Overriding Plugins ==

    -- customize alpha options
    {
        "goolord/alpha-nvim",
        opts = function(_, opts)
            -- customize the dashboard header
            opts.section.header.val = {
                " █████  ███████ ████████ ██████   ██████",
                "██   ██ ██         ██    ██   ██ ██    ██",
                "███████ ███████    ██    ██████  ██    ██",
                "██   ██      ██    ██    ██   ██ ██    ██",
                "██   ██ ███████    ██    ██   ██  ██████",
                " ",
                "    ███    ██ ██    ██ ██ ███    ███",
                "    ████   ██ ██    ██ ██ ████  ████",
                "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
                "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
                "    ██   ████   ████   ██ ██      ██",
            }
            return opts
        end,
    },

    -- You can disable default plugins as follows:
    { "max397574/better-escape.nvim", enabled = false },

    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            local luasnip = require "luasnip"
            luasnip.filetype_extend("javascript", { "javascriptreact" })
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom autopairs configuration such as custom rules
            local npairs = require "nvim-autopairs"
            local Rule = require "nvim-autopairs.rule"
            local cond = require "nvim-autopairs.conds"
            npairs.add_rules(
                {
                    Rule("$", "$", { "tex", "latex" })
                        -- don't add a pair if the next character is %
                        :with_pair(
                            cond.not_after_regex "%%"
                        )
                        -- don't add a pair if  the previous character is xxx
                        :with_pair(
                            cond.not_before_regex("xxx", 3)
                        )
                        -- don't move right when repeat character
                        :with_move(cond.none())
                        -- don't delete if the next character is xx
                        :with_del(
                            cond.not_after_regex "xx"
                        )
                        -- disable adding a newline when you press <cr>
                        :with_cr(cond.none()),
                },
                -- disable for .vim files, but it work for another filetypes
                Rule("a", "a", "-vim")
            )
        end,
    },
}
