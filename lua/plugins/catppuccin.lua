return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
       vim.cmd.colorscheme "catppuccin"
       vim.g.airline_theme = "catppuccin"
    end
  }
}
