-- Synchrously organize Go imports
-- https://github.com/neovim/nvim-lspconfig/issues/115
local function go_organize_imports_sync(bufnr, timeout_ms)
	timeout_ms = timeout_ms or 1000
	local encoding = vim.lsp.util._get_offset_encoding(bufnr)
	local params = vim.lsp.util.make_range_params(nil, encoding)
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, encoding)
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

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
					on_attach = function()
						vim.api.nvim_create_autocmd({ "BufWritePre" }, {
							pattern = { "*.go" },
							callback = function(args)
								go_organize_imports_sync(args.buf)
							end,
						})
					end,
					settings = {
						gopls = {
							-- Documented here https://github.com/golang/tools/blob/master/gopls/doc/settings.md
							completeUnimported = true,
							gofumpt = true,
							staticcheck = true,
							usePlaceholders = true,
						},
					},
				},
				lua_ls = {
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
				},
				ruff = {},
				pyright = {},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"pyright",
				"ruff",
				"stylua",
			})
			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
			end
		end,
	},
}
