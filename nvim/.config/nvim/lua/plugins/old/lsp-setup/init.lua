local M = {}

local lsp_utils = require "base.plugins.lsp-setup.utils"

local function lsp_init()
	-- LSP handlers configuration
	local config = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},

		diagnostic = {
			virtual_text = {
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
			},
			underline = false,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
	}

	-- Diagnostic configuration
	vim.diagnostic.config(config.diagnostic)

	-- Hover configuration
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

	-- Signature help configuration
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

function M.setup(_, opts)
	lsp_utils.on_attach(function(client, bufnr)
		-- require("base.plugins.lsp-setup.format").on_attach(client, bufnr)
		require("base.plugins.lsp-setup.keymaps").on_attach(client, bufnr)
	end)
	local lspconfig = require("lspconfig")

	lsp_init() -- diagnostics, handlers

	local servers = opts.servers
	local capabilities = lsp_utils.capabilities()

-- local mason_lspconfig = require("mason-lspconfig")

-- mason_lspconfig.setup({
-- 	ensure_installed = vim.tbl_keys(servers),
-- })

-- mason_lspconfig.setup_handlers({
-- 	function(server_name)
-- 		require("lspconfig")[server_name].setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			settings = servers[server_name],
-- 			filetypes = (servers[server_name] or {}).filetypes,
-- 		})
-- 	end,
-- })

	-- lspconfig.tailwindcss.setup({
	-- 	capabilities = require("base.plugins.lsp-setup.servers.tailwindcss").capabilities,
	-- 	filetypes = require("base.plugins.lsp-setup.servers.tailwindcss").filetypes,
	-- 	handlers = handlers,
	-- 	init_options = require("base.plugins.lsp-setup.servers.tailwindcss").init_options,
	-- 	on_attach = require("base.plugins.lsp-setup.servers.tailwindcss").on_attach,
	-- 	settings = require("base.plugins.lsp-setup.servers.tailwindcss").settings,
	-- })

	-- lspconfig.cssls.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = require("base.plugins.lsp-setup.servers.cssls").on_attach,
	-- 	settings = require("base.plugins.lsp-setup.servers.cssls").settings,
	-- })

	-- lspconfig.eslint.setup({
	-- 	capabilities = capabilities,
	-- 	handlers = handlers,
	-- 	on_attach = require("base.plugins.lsp-setup.servers.eslint").on_attach,
	-- 	settings = require("base.plugins.lsp-setup.servers.eslint").settings,
	-- })

	-- lspconfig.jsonls.setup({
	-- 	capabilities = capabilities,
	-- 	handlers = handlers,
	-- 	on_attach = on_attach,
	-- 	settings = require("base.plugins.lsp-setup.servers.jsonls").settings,
	-- })

	-- lspconfig.lua_ls.setup({
	-- 	capabilities = capabilities,
	-- 	handlers = handlers,
	-- 	on_attach = on_attach,
	-- 	settings = require("base.plugins.lsp-setup.servers.lua_ls").settings,
	-- })

	-- for _, server in ipairs({ "bashls", "emmet_ls", "graphql", "html", "prismals" }) do
	-- 	lspconfig[server].setup({
	-- 		on_attach = on_attach,
	-- 		capabilities = capabilities,
	-- 		handlers = handlers,
	-- 	})
	-- end
end

return M
