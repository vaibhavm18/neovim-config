
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
                    vim.keymap.set("n", "<leader>vt", function()
                        vim.cmd.RustLsp("testables")
                    end, opts)
                    vim.keymap.set("n", "<leader>ve", function()
                        vim.cmd.RustLsp("explainError")
                    end, opts)
                    vim.keymap.set("n", "<leader>vc", function()
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
                        procMacro = {
                            enable = false,
                        },
                    },
                },
            },
        }
    end,
}
