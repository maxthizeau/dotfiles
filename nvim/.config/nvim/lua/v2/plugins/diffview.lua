return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff working tree" },
    { "<leader>gD", "<cmd>DiffviewOpen HEAD<CR>", desc = "Diff HEAD" },
    { "<leader>gx", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current)" },
    { "<leader>gF", "<cmd>DiffviewFileHistory<CR>", desc = "File history (repo)" },
  },
}
