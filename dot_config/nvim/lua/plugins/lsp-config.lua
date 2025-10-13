return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							-- Get the language server to recognize common globals
							globals = {
								"love",
								"require",
								"vim",
							},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = {
								vim.env.RUNTIME,
								"${3rd}/luv/library",
							},
							-- Slower alternative:
							-- library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = { enable = false },
					},
				},
			})
		end,
	},
}
