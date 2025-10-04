mappings = {}

function mappings:main()
  -- vim.api.nvim_set_keymap('n', 't', ':lua if todo:is_allowed_folder() then todo:append_checkbox() end<CR>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', 'o', ':lua if todo:is_allowed_folder() then todo:append_subcheckbox() end<CR>', { noremap = false, silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-t>', ':lua if todo:is_allowed_folder() then todo:append_checkbox() end<CR>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-o>', ':lua if todo:is_allowed_folder() then todo:append_subcheckbox() end<CR>', { noremap = false, silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-t>', ':lua todo:append_checkbox()<CR>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-o>', ':lua todo:append_subcheckbox()<CR>', { noremap = false, silent = true })

  vim.api.nvim_set_keymap('n', 't', ':lua if not todo:has_today_date() then todo:append_first_data() else todo:append_checkbox() end<CR>', { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', 'f', ':lua todo:append_subcheckbox()<CR>', { noremap = false, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>x', [[:s/\[[ \*]\]/[✓]/ge<CR>:nohlsearch<CR>$<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>c', [[:s/\[[ \*]\]/[c]/ge<CR>:nohlsearch<CR>$<CR>]], { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-u>', [[:s/\[✓\]/[ ]/ge<CR>$<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>u', [[:s/\[[\*✓a-zA-Z0-9]\]/[ ]/ge<CR>:nohlsearch<CR>$<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>d', [[:s/\[ ]/[\*\]/ge<CR>:nohlsearch<CR>$<CR>]], { noremap = true, silent = true })
end

vim.api.nvim_exec([[
  augroup mappings:NoteMappings
    autocmd!
    autocmd BufEnter * lua if todo:is_allowed_folder() then mappings:main() end
  augroup END
]], true)
