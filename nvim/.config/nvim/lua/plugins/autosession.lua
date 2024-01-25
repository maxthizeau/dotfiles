return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>asr", "<cmd>SessionRestore<CR>", { desc = "[A]uto-[S]ession [R]estore for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ass", "<cmd>SessionSave<CR>", { desc = "[A]uto-[S]ession [S]ave for auto session root dir" }) -- save workspace session for current working directory
  end,
}
