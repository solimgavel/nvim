return {
  "mhinz/vim-startify",
  config = function()
    -- local oil = require("oil")
    -- oil.setup()
    vim.g.startify_custom_header = {'   welcome to hell'}
    vim.g.startify_change_to_dir = 0
    vim.g.startify_change_to_vcs_root = 1
    vim.g.startify_files_number = 5
    vim.g.startify_list = {{
            type = 'sessions',
            header = {'   Sessions'}
        }, {
            type = 'dir',
            header = {'   CWD' .. vim.fn.getcwd()}
        }, {
            type = 'files',
            header = {'   Files'}
        }, {
            type = 'bookmarks',
            header = {'   Bookmarks'}
        }, {
            type = 'commands',
            header = {'   Commands'}
        }}
  end,
}
