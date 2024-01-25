return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
	luasnip.config.setup({
		require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snippets" } }),
	  -- require("luasnip.loaders.from_vscode").lazy_load()
	})
	local compare = require("cmp.config.compare")
	local source_names = {
		nvim_lsp = "(LSP)",
		luasnip = "(Snippet)",
		buffer = "(Buffer)",
		path = "(Path)",
	}
    -- local lspkind = require("lspkind")
local duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 1,
				luasnip = 1,
			}
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
	  sorting = {
		  priority_weight = 2,
		  comparators = {
			  compare.score,
			  compare.recently_used,
			  compare.offset,
			  compare.exact,
			  compare.kind,
			  compare.sort_text,
			  compare.length,
			  compare.order,
		  },
	  },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
	  mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "luasnip", group_index = 1 },
					{ name = "buffer", group_index = 2 },
					{ name = "path", group_index = 2 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						local duplicates_default = 0
						item.menu = source_names[entry.source.name]
						item.dup = duplicates[entry.source.name] or duplicates_default
						if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
							item.menu = entry.completion_item.detail
						else
							item.menu = source_names[entry.source.name]
						end
						return item
					end,
				},
				-- experimental = {
				-- 	hl_group = "LspCodeLens",
				-- 	ghost_text = {},
				-- },
				window = {
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
					},
				},
      -- configure lspkind for vs-code like pictograms in completion menu
    })
  end,
}
