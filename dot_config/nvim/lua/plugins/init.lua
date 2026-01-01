return {
	{ "wakatime/vim-wakatime", lazy = false },
	{
		"ctrlpvim/ctrlp.vim",
		cmd = { "CtrlP", "CtrlPBuffer" },
	},
	{
		"morhetz/gruvbox",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		---@class ConformOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
	},
}
