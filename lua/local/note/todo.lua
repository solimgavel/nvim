todo = {}

function todo:has_today_date()
  local current_file = vim.fn.expand('%:p')
  local year_month = '/' .. os.date("%Y") .. '/' .. os.date("%m")
  for _, folder in ipairs({vim.fn.expand('~'..'/notes/todo')}) do
    if current_file ~= folder..year_month then
    -- if file is old then return true so as not to add first data
      return true
    end
  end

  local today_date = os.date("#%d, %A")
  local lines = vim.fn.getline(1, '$')
  for _, line in ipairs(lines) do
    if string.find(line, today_date, 1, true) then
      return true
    end
  end
end

function todo:append_data_to_new_file()
  vim.fn.append('0', vim.fn.strftime('#%d, %A'))
  local total_lines = vim.fn.line('$')
  if total_lines == 2 then
      vim.api.nvim_feedkeys('a[ ] ', 'n', true)
  end
end

-- function todo:append_date_to_new_file()
--   vim.fn.append('0', vim.fn.strftime('#%d, %A'))
-- end
--
-- function todo:append_date()
--   if not todo:has_today_date() then
--     vim.api.nvim_feedkeys(vim.fn.strftime('#%d, %A') .. '\n', 'n', true)
--   end
-- end
--
-- function todo:has_checkbox()
--   local current_line = vim.fn.getline('.')
--   -- return vim.fn.match(current_line, '\\[.\\]') ~= -1
--   -- return vim.fn.match(current_line, '[[]') ~= -1
--   return vim.fn.match(current_line, '[[•]') ~= -1
-- end
--
-- function todo:append_checkbox_to_new_file()
--     local total_lines = vim.fn.line('$')
--     if total_lines == 2 then
--         vim.api.nvim_feedkeys('a', 'n', true)
--     end
-- end

function todo:append_first_data()
  if not todo:has_today_date() then
    vim.api.nvim_feedkeys('o', 'n', true)
    local width = vim.api.nvim_win_get_width(0)
    local date = (vim.fn.strftime('#%d, %A') .. '\n')
    local date = string.rep(' ', math.floor((width - #date)) / 2) .. date
    vim.api.nvim_feedkeys(date, 'n', true)
    vim.api.nvim_feedkeys('[ ] ', 'n', true)
  end
  -- else?
end

function todo:append_checkbox()
  -- if not todo:has_checkbox() then
  --     print(2)
  --     vim.cmd('set formatoptions-=cro')
  --     vim.api.nvim_feedkeys('[ ] ', 'n', true)
  -- end
  vim.api.nvim_feedkeys('$a\n[ ] ', 'n', true)
end

function todo:append_subcheckbox()
  -- local current_line = vim.fn.getline('.')
  -- if vim.fn.match(current_line, '[[]') ~= -1 then
    vim.api.nvim_feedkeys('o  • ', 'n', true)
  -- else
  --   vim.api.nvim_feedkeys('o• ', 'n', true)
  -- end
end

function todo:is_allowed_folder()
  local home_directory = vim.fn.expand('~')
  local allowed_folders = {'/notes/todo'}
  for i, folder in ipairs(allowed_folders) do
      allowed_folders[i] = vim.fn.expand('~' .. folder)
  end
  for _, folder in ipairs(allowed_folders) do
    -- if string.find(vim.fn.argv()[1], folder, 1, true) then
    --     vim.cmd('normal G$')
    --     return true
    -- end

    -- for startify plugin
    if vim.fn.argv()[1] then
      if string.find(vim.fn.argv()[1], folder, 1, true) then
        vim.api.nvim_command('set nonumber')
        vim.api.nvim_command('set norelativenumber')
        vim.opt.autoindent = false
        vim.opt.smartindent = false
        vim.opt.cindent = false
        vim.cmd('set formatoptions-=cro')
        vim.cmd('normal G$')
        return true
      end
    end
  end
  -- local current_file = vim.fn.expand('%:p')
  -- local year_month = '/' .. os.date("%Y") .. '/' .. os.date("%m")
  -- for _, folder in ipairs(allowed_folders) do
  --     -- print(folder, '\n', current_folder, '\n', vim.fn.argv()[1])
  --     if string.find(current_file, folder..year_month, 1, true) then
  --         vim.cmd('normal G$')
  --         return true
  --     end
  -- end
end

vim.api.nvim_exec([[
  augroup todo:FirstDataNewFile
    autocmd!
    autocmd BufNewFile * lua if todo:is_allowed_folder() then todo:append_data_to_new_file() end
  augroup END
]], true)
-- vim.api.nvim_exec([[
--   augroup todo:AddDate
--     autocmd!
--     autocmd BufNewFile * lua if todo:is_allowed_folder() then todo:append_date_to_new_file() end
--   augroup END
-- ]], true)
-- Автокоманда для добавления даты при входе в режим вставки
-- vim.api.nvim_exec([[
--   augroup todo:AutoDateInsert
--     autocmd!
--     autocmd InsertEnter * lua if todo:is_allowed_folder() then todo:append_date() end
--   augroup END
-- ]], true)
-- Автокоманда для добавления чекбокса в новый файл
-- vim.api.nvim_exec([[
--   augroup todo:AutoCheckboxToNewFile
--     autocmd!
--     autocmd BufNewFile * lua if todo:is_allowed_folder() then todo:append_checkbox_to_new_file() end
--   augroup END
-- ]], true)
-- Автокоманда для добавления даты
vim.api.nvim_exec([[
  augroup todo:FirstData
    autocmd!
    autocmd BufEnter * lua if todo:is_allowed_folder() then todo:append_first_data() end
  augroup END
]], true)
-- Автокоманда для добавления чекбокса
-- vim.api.nvim_exec([[
--   augroup todo:AutoCheckbox
--     autocmd!
--     autocmd InsertEnter * lua if todo:is_allowed_folder() then todo:append_checkbox() end 
--   augroup END
-- ]], true)
