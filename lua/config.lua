vim.opt.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true

--[[vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"
vim.opt.showmode = false
vim.opt.updatetime = 100
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.wo.linebreak = true
vim.opt.virtualedit = "block"
vim.opt.undofile = true]]--
--vim.opt.shell = "/bin/zsh"

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"
-- vim.opt.clipboard:append("unnamedplus") 

-- Shorter messages
vim.opt.shortmess:append("c")

-- Indent Settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.bo.autoindent = false
-- vim.g.pyindent_open_paren = 0 
-- vim.g.pyindent_close_paren = 1
-- vim.opt.cindent = true
-- vim.opt.cinoptions = ":0"
-- vim.o.indentexpr=""
-- vim.b.did_indent=1

-- vim.api.nvim_exec([[
--   augroup SetIndent
--     autocmd!
--     autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
--   augroup END
-- ]], false)

-- vim.g.netrw_sort_by = "time"
-- vim.g.netrw_sort_options="i"
-- vim.g.netrw_fastbrowse = 2

-- Fillchars
vim.opt.fillchars = {
    vert = "│",
    fold = "⠀",
    eob = " ", -- suppress ~ at EndOfBuffer
    -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸"
}

vim.cmd([[highlight clear LineNr]])
vim.cmd([[highlight clear SignColumn]])
