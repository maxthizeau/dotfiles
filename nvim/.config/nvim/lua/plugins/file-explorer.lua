function NvimTreeTrash()
  local function get_user_input_char()
    local c = vim.fn.getchar()
    return vim.fn.nr2char(c)
  end
  local function clear_prompt()
    vim.api.nvim_command("normal :esc<CR>")
  end
  local function remove()
    local api = require("nvim-tree.api")
    local function on_exit(job_id, data, event)
      api.tree.reload()
    end
    local node = api.tree.get_node_under_cursor()
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

function NvimTreeOpenFinder()
  local api = require("nvim-tree.api")
  local node = api.tree.get_node_under_cursor()
  if not node then
    print("No file/folder selected")
    return
  end

  local path = node.absolute_path
  local cmd

  -- Detect operating system and use appropriate command
  if vim.fn.has("mac") == 1 then
    -- macOS: open Finder and select the file/folder
    cmd = "open -R " .. vim.fn.shellescape(path)
  elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    -- Windows: open Explorer and select the file/folder
    cmd = "explorer /select," .. vim.fn.shellescape(path)
  else
    -- Linux/Unix: try different file managers
    local file_managers = {
      "nautilus --select " .. vim.fn.shellescape(path),
      "dolphin --select " .. vim.fn.shellescape(path),
      "thunar " .. vim.fn.shellescape(vim.fn.fnamemodify(path, ":h")),
      "nemo " .. vim.fn.shellescape(vim.fn.fnamemodify(path, ":h")),
      "xdg-open " .. vim.fn.shellescape(vim.fn.fnamemodify(path, ":h")),
    }

    -- Try each file manager until one works
    for _, fm_cmd in ipairs(file_managers) do
      if vim.fn.executable(vim.split(fm_cmd, " ")[1]) == 1 then
        cmd = fm_cmd
        break
      end
    end

    if not cmd then
      print("No suitable file manager found")
      return
    end
  end

  -- Execute the command
  vim.fn.jobstart(cmd, {
    detach = true,
    on_exit = function(job_id, data, event)
      if data ~= 0 then
        print("Failed to open file manager")
      end
    end,
  })
end

return {
  -- {
  --
  --   "nvim-tree/nvim-web-devicons",
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   "MunifTanjim/nui.nvim",
    -- },
  },
  {
    {
      "folke/snacks.nvim",
      opts = {
        bigfile = { enabled = true },
        statuscolumn = { enabled = true },
        scope = { enabled = true },
        gitbrowse = { enabled = true },
        scroll = { enabled = false },
        -- explorer = { enabled = false, replace_netrw = false },
      },
    },
  },
  -- Setup nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local nvimtree = require("nvim-tree")
      -- Custom attach function for nvim-tree specific keymaps
      local function custom_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end
        -- Load default mappings first
        api.config.mappings.default_on_attach(bufnr)
        -- Add custom mappings
        vim.keymap.set("n", "<leader>CD", api.tree.change_root_to_node, opts("Selection as Root (cd)"))
        vim.keymap.set("n", "d", ":lua NvimTreeTrash()<CR>", opts("Trash"))
        vim.keymap.set("n", "O", ":lua NvimTreeOpenFinder()<CR>", opts("Open in Finder"))
      end
      -- Setup nvim-tree
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
    end,
    keys = {
      -- Override LazyVim's default file explorer keybindings
      { "<leader>fe", false }, -- Disable LazyVim's default explorer in root
      { "<leader>fE", false }, -- Disable LazyVim's default explorer in cwd
      -- Your custom keybindings
      {
        "<leader>pc",
        "<cmd>NvimTreeToggle<CR>",
        desc = "Close/open file explorer",
      },
      {
        "<leader>pv",
        "<cmd>NvimTreeFocus<cr>",
        desc = "Open/Focus file explorer",
      },
      {
        "<leader>pf",
        "<cmd>NvimTreeFindFile<cr>",
        desc = "Focus current file in file explorer",
      },
    },
  },
}
-- -- File explorer configuration for LazyVim
-- -- Place this file in: lua/plugins/file-explorer.lua
--
-- -- Define the trash function globally so it can be used in keymaps
--
-- return {
--   -- Disable neo-tree
--   {
--     "nvim-neo-tree/neo-tree.nvim",
--     enabled = false,
--   },
--
-- }
