local opt = vim.opt

opt.iskeyword:append("-")
-- For Nvim Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 10
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

-- Put this here to be sure its loaded first
vim.g.mapleader = " "
vim.g.maplocalleader = ","
