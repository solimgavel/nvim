--Init class
autodate = {}
-- Функция для проверки, содержится ли сегодняшняя дата в файле
function autodate:has_today_date()
  local today_date = os.date("#%d, %A")
  local lines = vim.fn.getline(1, '$')
  for _, line in ipairs(lines) do
    if string.find(line, today_date, 1, true) then
      return true
    end
  end
end
-- Функция для добавления даты в новый файл
function autodate:append_date_to_new_file()
    vim.fn.append('0', vim.fn.strftime('#%d, %A'))
--    vim.cmd('normal G$')
end
-- Функция для добавления даты в режиме вставки
function autodate:append_date()
    if not autodate:has_today_date() then
        --vim.fn.append('$', {vim.fn.strftime('#%d, %A'), ''})
        vim.cmd('set formatoptions-=cro')
        vim.api.nvim_feedkeys(vim.fn.strftime('#%d, %A') .. '\n', 'n', true)
        --vim.fn.append('$', {'\n'})
    end
end
-- Функция для проверки текущего рабочего каталога
function autodate:is_allowed_folder()
    local home_directory = vim.fn.expand('~')
    local allowed_folders = {'/notes/notes', '/notes/ideas'}
    for i, folder in ipairs(allowed_folders) do
        allowed_folders[i] = vim.fn.expand('~' .. folder)
    end

    local current_file = vim.fn.expand('%:p')
    local ym1 = '/' .. os.date("%Y") .. '/' .. os.date("%m")
    local ym2 = '/' .. os.date("%Y") .. '/' .. string.lower(os.date("%B")) .. os.date("%Y")
    print(ym1, ym2)

    for _, folder in ipairs(allowed_folders) do
        if string.find(current_file, folder..ym1, 1, true) then
            return true
        end
        if string.find(current_file, folder..ym2, 1, true) then
            return true
        end
    end
    return false
end
-- Автокоманда для нового файла в разрешенных папках
vim.api.nvim_exec([[
  augroup autodate:AddDate
    autocmd!
    autocmd BufNewFile * :lua if autodate:is_allowed_folder() then autodate:append_date_to_new_file() end
  augroup END
]], false)
-- Автокоманда для выполнения при входе в режим вставки
vim.api.nvim_exec([[
  augroup autodate:AutoDateInsert
    autocmd!
    autocmd InsertEnter * :lua if autodate:is_allowed_folder() then autodate:append_date() end
  augroup END
]], false)
