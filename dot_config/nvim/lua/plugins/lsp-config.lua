return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
		},

		config = function()
			local vim_capabilities = vim.lsp.protocol.make_client_capabilities()
			local blink_capabilities = require("blink.cmp").get_lsp_capabilities({}, false)
			local capabilities = vim.tbl_deep_extend("force", vim_capabilities, blink_capabilities)
			local servers = {
				gopls = {
					gopls = {
						-- Documented here https://github.com/golang/tools/blob/master/gopls/doc/settings.md
						completeUnimported = true,
						gofumpt = true,
						staticcheck = true,
						usePlaceholders = true,
					},
				},
				lua_ls = {
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
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			for server, settings in pairs(servers) do
				vim.lsp.config(server, { settings = settings })
			end
		end,
	},
}
