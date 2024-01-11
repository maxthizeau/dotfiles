return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    -- disable netrw at the very start of your init.lua

    -- set termguicolors to enable highlight groups
    -- vim.opt.termguicolors = true

    -- empty setup using defaults
    -- require("nvim-tree").setup()

    -- OR setup with some options
    local nvimtree = require("nvim-tree")

    local custom_attach = function(bufnr)
      local api = require "nvim-tree.api"
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
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = custom_attach
    })

    vim.keymap.set("n", "<leader>pv", ":NvimTreeFocus<cr>")
  end
}
