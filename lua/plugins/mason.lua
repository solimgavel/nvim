return {
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup()
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require("mason-lspconfig").setup(
			{
        ensure_installed = {
            "ts_ls",
            "buf_ls",
            -- "lua_ls",
            -- "rust_analyzer",
            "gopls"
        }
        --ensure_installed = {}
			})
		end
	}
}
