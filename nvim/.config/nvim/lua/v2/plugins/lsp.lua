return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities =
            vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
            callback = function(event)
                local bufnr = event.buf
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then return end

                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                end

                -- ─── Navigation ───────────────────────────────────────────────
                map("gd", require("telescope.builtin").lsp_definitions, "Go to Definition")
                map("gr", require("telescope.builtin").lsp_references, "Go to References")
                map("gI", require("telescope.builtin").lsp_implementations, "Go to Implementation")
                map("gy", require("telescope.builtin").lsp_type_definitions, "Go to Type Definition")

                -- ─── Infos ────────────────────────────────────────────────────
                map("K", vim.lsp.buf.hover, "Hover Documentation")
                map("gK", vim.lsp.buf.signature_help, "Signature Help")

                -- ─── Actions génériques ───────────────────────────────────────
                map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
                map("<leader>cf", vim.lsp.buf.format, "Format Buffer")

                -- ─── Diagnostics ──────────────────────────────────────────────
                map("<leader>cd", vim.diagnostic.open_float, "Show Diagnostic")
                map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
                map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
                map("]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next Error")
                map("[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Previous Error")
                map("]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, "Next Warning")
                map("[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, "Previous Warning")
                map("]h", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT }) end, "Next Hint")
                map("[h", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.HINT }) end, "Previous Hint")
                map("<leader>sd", require("telescope.builtin").diagnostics, "Search Diagnostics")

                -- ─── TypeScript (ts_ls uniquement) ────────────────────────────
                if client.name == "ts_ls" then
                    local function ts_action(action)
                        return function()
                            vim.lsp.buf.code_action({
                                apply = true,
                                context = {
                                    only = { action },
                                    diagnostics = {},
                                },
                            })
                        end
                    end

                    map("<leader>cM", ts_action("source.addMissingImports.ts"), "Add Missing Imports")
                    map("<leader>cc", ts_action("source.removeUnused.ts"), "Remove Unused Imports")
                    map("<leader>cO", ts_action("source.organizeImports.ts"), "Organize Imports")
                    map("<leader>cF", ts_action("source.fixAll.ts"), "Fix All")
                end
            end,
        })

        require("fidget").setup({})
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "eslint", "cssls" },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ select = false })
                    else
                        fallback()
                    end
                end),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
