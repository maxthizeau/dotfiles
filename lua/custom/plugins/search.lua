-- -- Telescope stuff could be migrated here once it's fully done 
-- return {
--   {
--     -- SEARCH AND REPLACE
--     "nvim-pack/nvim-spectre",
--     dependencies = { "nvim-lua/plenary.nvim" },
--     config = function()
--       require("spectre").setup({
--         -- replace_engine = { ["sed"] = { cmd = "gsed" } }
--       })
--       vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
--         desc = "Toggle Spectre"
--       })
--       vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--         desc = "Search current word"
--       })
--       vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--         desc = "Search current word"
--       })
--       vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--         desc = "Search on current file"
--       })
--      vim.keymap.set('n', '<leader>Scf', '<cmd>lua require("spectre").open_file_search({})<CR>', {
--         desc = "Search on current file"
--       })
--     end
--   }
-- }
