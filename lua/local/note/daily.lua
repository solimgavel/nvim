-- Init class
daily = {}
-- Функция для проверки, содержится ли сегодняшняя дата в файле
function daily:has_today_date()
  local today_date = os.date("#%d, %A")
  local lines = vim.fn.getline(1, '$')
  for _, line in ipairs(lines) do
    if string.find(line, today_date, 1, true) then
      return true
    end
  end
end
-- Функция для добавления даты в новый файл
function daily:append_date_to_new_file()
    local file = vim.fn.expand('~' .. '/notes/daily/daily/monthly')
    local text = vim.fn.readfile(file)
--    vim.fn.append('0', table.concat(text, '\n'))
    table.insert(text, vim.fn.strftime('#%d, %A'))
    vim.fn.append('0', text)
--    vim.fn.append('0', vim.fn.strftime('#%d, %A'))
end
-- Функция для добавления даты в режиме вставки
function daily:append_date()
    if not daily:has_today_date() then
        vim.api.nvim_feedkeys(vim.fn.strftime('#%d, %A') .. '\n', 'n', true)
    end
end
-- Проверка наличия чекбокса
function daily:has_checkbox()
  local current_line = vim.fn.getline('.')
  return vim.fn.match(current_line, '\\[.\\]') ~= -1
end
-- Добавить чекбокс в новый файл
function daily:append_checkbox_to_new_file()
    local total_lines = vim.fn.line('$')
    if total_lines == 2 then
        vim.api.nvim_feedkeys('a', 'n', true)
    end
end
-- Добавить чекбокс после даты
function daily:append_first_checkbox()
    if not daily:has_today_date() then
        --vim.cmd('set formatoptions-=cro')
        vim.api.nvim_feedkeys('o', 'n', true)
--    append_date()
--    append_checkbox()
    end
end
-- Добавить чекбокс
function daily:append_checkbox()
    if not daily:has_checkbox() then
        vim.cmd('set formatoptions-=cro')
        local file = vim.fn.expand('~' .. '/notes/daily/daily/daily')
        local text = vim.fn.readfile(file)
        print(text)
        vim.api.nvim_feedkeys(table.concat(text, '\n'), 'n', true)
    end
end
-- Проверить разрешения папки
function daily:is_allowed_folder()
    local allowed_folders = {'/notes/daily/daily'}
    for i, folder in ipairs(allowed_folders) do
        allowed_folders[i] = vim.fn.expand('~' .. folder)
    end

    local current_file = vim.fn.expand('%:p')
    local year_month = '/' .. os.date("%Y") .. '/' .. os.date("%m")
    for _, folder in ipairs(allowed_folders) do
        if string.find(current_file, folder..year_month, 1, true) then
            vim.cmd('normal G$')
            return true
        end
    end
end
-- Автокоманда для добавления даты в новый файл в разрешенных папках
vim.api.nvim_exec([[
  augroup AddDate
    autocmd!
    autocmd BufNewFile * lua if daily:is_allowed_folder() then daily:append_date_to_new_file() end
  augroup END
]], false)
-- Автокоманда для добавления даты при входе в режим вставки
vim.api.nvim_exec([[
  augroup AutoDateInsert
    autocmd!
    autocmd InsertEnter * lua if daily:is_allowed_folder() then daily:append_date() end
  augroup END
]], false)
-- Автокоманда для добавления чекбокса в новый файл
vim.api.nvim_exec([[
  augroup AutoCheckboxToNewFile
    autocmd!
    autocmd BufNewFile * lua if daily:is_allowed_folder() then daily:append_checkbox_to_new_file() end
  augroup END
]], false)
-- Автокоманда для добавления даты
vim.api.nvim_exec([[
  augroup FirstAutoCheckbox
    autocmd!
    autocmd BufEnter * lua if daily:is_allowed_folder() then daily:append_first_checkbox() end
  augroup END
]], false)
-- Автокоманда для добавления чекбокса
vim.api.nvim_exec([[
  augroup AutoCheckbox
    autocmd!
    autocmd InsertEnter * lua if daily:is_allowed_folder() then daily:append_checkbox() end 
  augroup END
]], false)
