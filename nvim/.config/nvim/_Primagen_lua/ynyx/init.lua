require("ynyx.remap")
require("ynyx.lazy")
require("ynyx.set")

-- vim.api.nvim_command('echo "hello from vim"')
-- function resizeAndOpenTerminal() 
--   vim.cmd ":vertical resize 140"
--   vim.cmd <C-w>l
--   vim.cmd ":term"
--   vim.cmd <C-w>h
-- end
--
-- vim.api.nvim_create_user_command('TermRight', resizeAndOpenTerminal, {})
vim.api.nvim_create_user_command('BufOnly',function()
  vim.cmd ":vertical resize 140" 
end,{})




vim.api.nvim_create_user_command('TestStu', function() 
    vim.cmd('vertical split')
  vim.cmd('terminal')
  vim.fn.feedkeys('a')
  local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
  vim.fn.feedkeys('clear' .. enter)
  vim.fn.feedkeys('echo hello world' .. enter)
end, {})
