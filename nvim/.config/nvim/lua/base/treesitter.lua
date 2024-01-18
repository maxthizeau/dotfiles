return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"c",
					"cpp",
					"go",
					"lua",
					"python",
					"rust",
					"tsx",
					"javascript",
					"typescript",
					"vimdoc",
					"vim",
					"bash",
				},

				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = true,

				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<M-space>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					autotag = {
						enable = true,
						enable_rename = true,
						enable_close = true,
						enable_close_on_slash = true,
						filetypes = { "html", "xml" },
					},
				},
			})
		end,
		opts = {
			sync_install = false,
			ensure_installed = {
				"bash",
				"dockerfile",
				"html",
				"markdown",
				"markdown_inline",
				"org",
				"query",
				"regex",
				"latex",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown" } },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },

			config = function(_, opts)
				print("hello from base treesitter")
				if type(opts.ensure_installed) == "table" then
					---@type table<string, boolean>
					local added = {}
					opts.ensure_installed = vim.tbl_filter(function(lang)
						if added[lang] then
							return false
						end
						added[lang] = true
						return true
					end, opts.ensure_installed)
				end

				require("nvim-treesitter.configs").setup(opts)
			end,
		},
	},
}
