return {
    {
        "folke/which-key.nvim",
        opts = function(_, opts)
            opts.spec = opts.spec or {}
            vim.list_extend(opts.spec, {
                { "<leader>c", group = "Code" },
                { "<leader>g", group = "Git" },
                { "<leader>s", group = "Search" },
            })
        end,
    },
}
