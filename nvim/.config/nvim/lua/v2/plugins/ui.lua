return {
    --     {
    --   "nvim-tree/nvim-web-devicons",
    --   dependencies = { "DaikyXendo/nvim-material-icon" },
    --   config = function()
    --     require("nvim-material-icon").setup()  -- initialize first
    --     require("nvim-web-devicons").setup({
    --       override = require("nvim-material-icon").get_icons() or {},  -- fallback to {}
    --     })
    --   end,
    -- },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "storm",
            transparent = false,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function(_, opts)
            local tokyonight = require("tokyonight")
            tokyonight.setup(opts)
            tokyonight.load()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = "onedark",
                component_separators = "|",
                section_separators = "",
            },
        },
    },

    -- { "catppuccin/nvim", lazy = false, name = "catppuccin" },
}
