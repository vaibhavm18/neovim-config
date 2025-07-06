return {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = "rust",
    config = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = function(_, bufnr)
                    local keymap = vim.keymap
                    
                    local opts = { silent = false, buffer = bufnr }
                    -- rust keymaps
                    vim.keymap.set("n", "K", function()
                        vim.cmd.RustLsp({ "hover", "actions" })
                    end, opts)
                    vim.keymap.set("n", "<leader>ca", function()
                        vim.cmd.RustLsp("codeAction")
                    end, opts)
                    vim.keymap.set("n", "<leader>vT", function()
                        vim.cmd.RustLsp("testables")
                    end, opts)
                    vim.keymap.set("n", "<leader>vE", function()
                        vim.cmd.RustLsp("explainError")
                    end, opts)
                    vim.keymap.set("n", "<leader>vC", function()
                        vim.cmd.RustLsp("openCargo")
                    end, opts)
                end,
                settings = {
                    ["rust-analyzer"] = {
                        files = {
                            excludeDirs = {
                                "target",
                                "node_modules",
                                ".git",
                                "src-tauri/target",
                                "src-tauri/node_modules",
                            },
                        },
                        cargo = {
                            targetDir = "target/rust-analyzer",
                            allFeature = true
                        },
                        -- diagnostics = {
                        --     disabled = { "unresolved-proc-macro", "macro-error" },
                        --     enableExperimental = false,
                        -- },
                        checkOnSave = {
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                        procMacro = {
                            enable = false,
                        },
                    },
                },
            },
        }
    end,
}
-- return 
-- {
--   'mrcjkb/rustaceanvim',
--   version = '^6',   -- pin to semver-compatible releases
--   lazy    = false, -- it’s already lazy-loaded by filetype
-- }
