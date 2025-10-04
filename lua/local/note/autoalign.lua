autoalign = {}

function autoalign:center_text()
  local width = vim.api.nvim_win_get_width(0)
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  local changes = nil
  
  for i, line in ipairs(lines) do
    if line:match('^#%d+, %a+') then
    -- if line:find('\n'..'#') ~= nil then
    -- print(changes, 111, line, line:sub(1, 1))
    -- if line:sub(1, 1) == '#' then
      changes = true
      if #line < width then
        local spaces = math.floor((width - #line) / 2)
        lines[i] = string.rep(" ", spaces) .. line
      end
    end
  end
  
  if changes then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end
end

function autoalign:is_allowed_folder()
    local allowed_folders = {'/notes/todo'}
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

-- Starts after alredy pasted date
vim.api.nvim_exec([[
  augroup Autoalign
    autocmd!
    autocmd BufNewFile,BufEnter * lua if autoalign:is_allowed_folder() then autoalign:center_text() end
  augroup END
]], false)
-- vim.api.nvim_create_autocmd('BufWinEnter', {
--   pattern = '*', -- Можно настроить паттерн, если нужно
--   callback = function()
--     center_text()
--   end
-- })

-- -- Функция для визуального центрирования текста с использованием foldexpr и foldtext
-- local function setup_fold_centering()
--   local width = vim.api.nvim_win_get_width(0)  -- Получаем ширину окна
--
--   -- Устанавливаем foldexpr для создания свёрнутых блоков
--   vim.wo.foldexpr = "getline(v:lnum) =~ '^#%d+, %a+' ? 1 : 0"
--
--   -- Определяем foldtext для центрирования текста
--   vim.wo.foldtext = [[
--     let line = getline(v:foldstart)
--     let len = strlen(line)
--     let width = winwidth(0)
--     let spaces = max([0, (width - len) / 2])
--     return repeat(' ', spaces) . line
--   ]]
--
--   -- Устанавливаем foldmethod на expr
--   vim.wo.foldmethod = 'expr'
-- end
--
-- -- Автокоманда для применения визуального центрирования при открытии буфера
-- vim.api.nvim_create_autocmd('BufWinEnter', {
--   pattern = '*', -- Измените на нужный паттерн, если требуется
--   callback = setup_fold_centering
-- })
