-- Определение регулярного выражения для HEX-кодов
local hex_pattern = "#%x%x%x%x%x%x"

-- Таблица для хранения ID подсветки
local highlight_ids = {}

-- Функция для подсветки HEX-кодов
function highlight_hex_colors()
    -- Очистка предыдущих подсветок
    for _, id in ipairs(highlight_ids) do
        vim.fn.matchdelete(id)
    end
    highlight_ids = {}

    -- Получение всех строк в текущем буфере
    local lines = vim.fn.getline(1, '$')
    for i, line in ipairs(lines) do
        for hex_color in line:gmatch(hex_pattern) do
            -- print(hex_color)
            local highlight_group = 'HexColor' .. hex_color:gsub('#', '')
            if vim.fn.hlexists(highlight_group) == 0 then
                vim.cmd(string.format('hi %s guifg=black guibg=%s', highlight_group, hex_color))
            end
            local id = vim.fn.matchadd(highlight_group, hex_color, 10, -1, {window = 0})
            table.insert(highlight_ids, id)
        end
    end
end

-- Определение автокоманды для выполнения функции при изменении текста
vim.api.nvim_exec([[
  augroup HexHighlighting
    autocmd!
    autocmd BufEnter,BufWinEnter,TextChanged,TextChangedI *.css,*.lua lua highlight_hex_colors()
  augroup end
]], false)
