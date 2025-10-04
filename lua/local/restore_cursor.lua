-- https://stackoverflow.com/questions/68490836/save-exact-cursor-position-in-the-line :help restore-cursor
vim.api.nvim_exec([[
  augroup RestoreCursorPosition
    autocmd!
    autocmd BufRead * if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  augroup END
]], false)

-- https://www.reddit.com/r/neovim/comments/14e59ub/i_wrote_a_function_that_moves_the_cursor_to_the/
-- local cur_file = vim.fn.expand('%:t')
-- vim.cmd.Ex()
-- vim.fn.search('^'..cur_file..'$')
-- vim.api.nvim_create_user_command("Ex", function()
  --
--   local cur_file = vim.fn.expand('%:t')  -- имя текущего файла
--   vim.cmd.Ex()                           -- открываем netrw
--   vim.fn.search('^' .. cur_file .. '$')  -- ищем файл в списке
-- end, {})
--

