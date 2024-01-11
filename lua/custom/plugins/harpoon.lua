-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")

function config() 
  local keymap = vim.keymap.set

  -- harpoon file
  keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", {
    desc= "Add file in harpoon",
    silent = true
  })
  -- harpoon menu
  keymap("n", "<C-h>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR><C-c>", {
    silent = true,
    desc = "Toggle harpoon quick menu"
  })
  -- fuzzy find harpoons
  keymap("n", "<leader>hf", "<cmd>Telescope harpoon marks<CR>", {
    silent = true,
    desc = "Telescope harpoon marks"
  })
  -- navigate harpooned files
  keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°1"
  })
  keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°2"
  })
  keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°3"
  })
  keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°4"
  })

  keymap("n", "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°6"
  })
  keymap("n", "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°7"
  })
  keymap("n", "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°8"
  })
  keymap("n", "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<CR>", {
    silent = true,
    desc = "Navigate to harpoon's file n°9"
  })
  keymap("n",  "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", {desc = "Go to next harpoon mark" })
  keymap("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", {desc = "Go to previous harpoon mark" })
end

return {
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = config,
}

