return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {},
	config = function()
		local wk = require("which-key")
		wk.register({
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			-- ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
			["<leader>h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
			["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]ath (File Treek", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]eplace", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
		})
		-- register which-key VISUAL mode
		-- required for visual <leader>hs (hunk stage) to work
		wk.register({
			["<leader>"] = { name = "VISUAL <leader>" },
			-- ["<leader>h"] = { "Git [H]unk" },
		}, { mode = "v" })
	end,
}
