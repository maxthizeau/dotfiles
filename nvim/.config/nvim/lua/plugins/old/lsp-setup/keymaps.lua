local M = {}

function M.on_attach(client, buffer)
	local self = M.new(client, buffer)

	self:map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	self:map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	self:map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	self:map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  -- stylua: ignore
  self:map("gt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
    { desc = "[G]oto [T]ype Definition" })
	self:map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	self:map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	self:map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	self:map("K", vim.lsp.buf.hover, "Hover Documentation")
	self:map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	self:map("]d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
	self:map("[d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
	self:map("]e", M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
	self:map("[e", M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
	self:map("]w", M.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
	self:map("[w", M.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })
	self:map("<leader>la", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })

	local format = require("base.lsp.format").format
	self:map("<leader>lf", format, { desc = "Format Document", has = "documentFormatting" })
	self:map("<leader>lf", format, { desc = "Format Range", mode = "v", has = "documentRangeFormatting" })
	self:map("<leader>lr", vim.lsp.buf.rename, { expr = true, desc = "Rename", has = "rename" })

	self:map("<leader>ls", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
	self:map("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
	self:map("<leader>lw", require("base.lsp.utils").toggle_diagnostics, { desc = "Toggle Inline Diagnostics" })
end

function M.new(client, buffer)
	return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
	return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lhs, rhs, opts)
	opts = opts or {}
	if opts.has and not self:has(opts.has) then
		return
	end
	vim.keymap.set(
		opts.mode or "n",
		lhs,
		type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
		---@diagnostic disable-next-line: no-unknown
		{ silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
	)
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
-- local self:map = function(keys, func, desc)
-- 	if desc then
-- 		desc = "LSP: " .. desc
-- 	end

-- 	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
-- end

-- self:map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
-- self:map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

-- self:map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
-- self:map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
-- self:map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
-- self:map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
-- self:map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
-- self:map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

-- -- See `:help K` for why this keymap
-- self:map("K", vim.lsp.buf.hover, "Hover Documentation")
-- self:map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

-- -- Lesser used LSP functionality
-- self:map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
-- self:map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
-- self:map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
-- self:map("<leader>wl", function()
-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, "[W]orkspace [L]ist Folders")

-- -- Create a command `:Format` local to the LSP buffer
-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
-- 	vim.lsp.buf.format()
-- end, { desc = "Format current buffer with LSP" })
