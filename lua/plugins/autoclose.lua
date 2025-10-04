return {
  'm4xshen/autoclose.nvim',
  opts = {
  -- add any options here
  },
  lazy = false,
  config = function()
      require("autoclose").setup()
  end,
}
