-- vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move the selection up by pressing Alt+k
vim.keymap.set("v", "Ï", ":m '>+1<CR>gv=gv")
-- Move the selection down by pressing Alt+j
vim.keymap.set("v", "È", ":m '>-2<CR>gv=gv")

-- Keep the cursor at the same place when doing J's
vim.keymap.set("n", "J", "mzJ`z")

-- Keep the cursor at the middle of the screen while jumping with Ctrl-d/Ctrl-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep the cursor in the middle while searching with n/N
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- This one allow you to paste over something you selected and set the selection to the void buffer
-- So you can paste again the first thing you copied
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete goes to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Jump to another project - Do not work rn, I need to install tmux i guess
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Quickfix navigation / Quickfix list (dont know what it means but lets see)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace the current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make it executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


-- vim.keymap.set('t', '<C- >', "<C-\\><C-n><C-w>h",{silent = true})

-- map <Leader>t :term ++close<cr>
-- tmap <Leader>t <c-w>:term ++close<cr>

-- vim.keymap.set("n", "<leader>t", ":term ++close<C-r>")
-- vim.keymap.set("t", "<leader>t", "<C-w>:term ++close<C-r>")
-- Map <leader>o & <leader>O to newline without insert mode
vim.keymap.set("n", "<leader>o",
  [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline below (no insert-mode)" })
vim.keymap.set("n", "<leader>O",
  [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline above (no insert-mode)" })

-- <ctrl-s> to Save
vim.keymap.set({ "n", "v", "i" }, "<C-S>", "<C-c>:update<cr>", { silent = true, desc = "Save" })

-- w!! to save with sudo
vim.keymap.set("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })

-- tabulation
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Tab>", ">>", opts)
vim.keymap.set("n", "<S-Tab>", "<<", opts)
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts)
