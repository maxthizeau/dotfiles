function NvimTreeTrash()
	function get_user_input_char()
		local c = vim.fn.getchar()
		return vim.fn.nr2char(c)
	end

	function clear_prompt()
		vim.api.nvim_command("normal :esc<CR>")
	end

	function remove()
		local lib = require("nvim-tree.lib")
		local function on_exit(job_id, data, event)
			lib.refresh_tree()
		end
		local node = lib.get_node_at_cursor()
		if node then
			vim.fn.jobstart("trash " .. node.absolute_path, {
				detach = true,
				on_exit = on_exit,
			})
		end
	end

	print("Are you sure ? y/n")
	local ans = get_user_input_char()

	if ans:match("^y") then
		remove()
	end

	clear_prompt()
end

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
				vim.keymap.set("n", "d", ":lua NvimTreeTrash()<CR>", opts("Trash"))
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
				trash = {
					cmd = "trash",
				},
				on_attach = custom_attach,
			})
			-- vim.cmd(":NvimTreeOpen")
			vim.keymap.set("n", "<leader>pc", "<cmd>NvimTreeToggle<CR>", { desc = "Close/open file explorer" }) -- toggle file explorer
			vim.keymap.set("n", "<leader>pv", ":NvimTreeFocus<cr>", { desc = "Open/Focus file explorer" })
			vim.keymap.set("n", "<leader>pf", ":NvimTreeFindFile<cr>", { desc = "Focus current file in file explorer" })
		end,
	},
}
