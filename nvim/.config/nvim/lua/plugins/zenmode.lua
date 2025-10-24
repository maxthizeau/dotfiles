return {
  {
    "folke/snacks.nvim",
    keys = {
      -- Disable the default marks keymap
      { "<leader>sm", false },
    },
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },
}
