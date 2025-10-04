function home_or_word()
    local current_col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local start_of_word

    for i = current_col, 1, -1 do
        if not line:sub(i, i):match('%s') then
            start_of_word = i
        else
            break
        end
    end
    
    if current_col == 1 then
        vim.cmd('normal! ^')
    elseif current_col == start_of_word then
        vim.cmd('normal! 0')
    else
        vim.cmd('normal! ^')
    end
end

vim.cmd("command! Home lua home_or_word()")
