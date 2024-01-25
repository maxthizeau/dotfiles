return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local nvimtree = require("nvim-tree")

			local custom_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end
				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "<leader>CD", api.tree.change_root_to_node, opts("Selection as Root (cd)"))
			end

			nvimtree.setup({
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 45,
				},
				modified = {
					enable = true,
					show_on_dirs = true,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
				},
				on_attach = custom_attach,
			})
			vim.cmd(":NvimTreeOpen")
			vim.keymap.set("n", "<leader>pv", ":NvimTreeFocus<cr>")
			vim.keymap.set("n", "<leader>pf", ":NvimTreeFindFile<cr>")
		end,
	},
}
