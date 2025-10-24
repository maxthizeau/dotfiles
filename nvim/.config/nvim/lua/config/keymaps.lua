-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local keymap = vim.keymap.set

-- Move the selection up by pressing Alt+k
keymap("v", "Ï", ":m '>+1<CR>gv=gv")
-- Move the selection down by pressing Alt+j
keymap("v", "È", ":m '>-2<CR>gv=gv")

-- Keep the cursor at the same place when doing J's
keymap("n", "J", "mzJ`z")

-- Keep the cursor at the middle of the screen while jumping with Ctrl-d/Ctrl-u
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Keep the cursor in the middle while searching with n/N
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- This one allow you to paste over something you selected and set the selection to the void buffer
-- So you can paste again the first thing you copied
keymap("x", "<leader>p", '"_dP', { desc = "Paste and set selection to void" })

keymap("n", "<leader>y", '"+y', { desc = "Yank to system cb" })
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')

-- Delete goes to void register
keymap("n", "<leader>d", '"_d', { desc = "Delete to void register" })
keymap("v", "<leader>d", '"_d', { desc = "Delete to void register" })

-- Quickfix navigation / Quickfix list
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Quickfix navigation" })
keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace the current word
keymap(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace the current word" }
)

keymap(
  "n",
  "<leader>o",
  [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline below (no insert-mode)" }
)
keymap(
  "n",
  "<leader>O",
  [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline above (no insert-mode)" }
)

-- <ctrl-s> to Save
keymap({ "n", "v", "i" }, "<C-S>", "<C-c>:update<cr>", { silent = true, desc = "Save" })

-- w!! to save with sudo
keymap("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true, desc = "Save with Sudo" })

-- tabulation
local opts = { noremap = true, silent = true }
keymap("n", "<Tab>", ">>", opts)
keymap("n", "<S-Tab>", "<<", opts)
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Map Cmd+V to paste from system clipboard
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("i", "<D-v>", "<C-r>+", { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<D-v>", '"+p', { desc = "Paste from system clipboard" })

-- Map Cmd+C to copy to system clipboard
vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy to system clipboard" })

-- Map Cmd+X to cut to system clipboard
vim.keymap.set("v", "<D-x>", '"+x', { desc = "Cut to system clipboard" })
