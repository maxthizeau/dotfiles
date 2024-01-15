local EditorConfig =  {
	{
		'sgur/vim-editorconfig',
		lazy = false,
		init = function()
			vim.g.editorconfig_verbose = 1
			vim.g.editorconfig_blacklist = {
				filetype = {
					'git.*',
					'fugitive',
					'help',
					'lsp-.*',
					'any-jump',
					'gina-.*',
				},
				pattern = { '\\.un~$' },
			}
		end,
	},
}

local Conform = {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}

return {
	EditorConfig, 
	Conform
}
