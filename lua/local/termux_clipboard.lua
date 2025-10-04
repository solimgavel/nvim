vim.g.clipboard = {
  name = 'TermuxClipboard',
  copy = {
    ['+'] = 'termux-clipboard-set',
    ['*'] = 'termux-clipboard-set',
  },
  paste = {
    ['+'] = 'termux-clipboard-get',
    ['*'] = 'termux-clipboard-get',
  },
  cache_enabled = 0,
}
