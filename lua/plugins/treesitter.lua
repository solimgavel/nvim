return {
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = { "python", "go", "lua", "typescript", "javascript" },
				auto_install = true,
				highlight = {
					enable = true,
				},
        indent = { enable = true }, -- fixed my python indent before last bracket
			})
		end
	}
}
