return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"gopls",
				"lua_ls",
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "CmdlineEnter", "InsertEnter" },
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-emoji", "hrsh7th/cmp-buffer" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "emoji" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				-- Kudos to https://blog.viktomas.com/graph/neovim-lsp-rename-normal-mode-keymaps/
				local function bufoptsWithDesc(desc)
					return { silent = true, buffer = bufnr, desc = desc }
				end

				local on_rename = function()
					-- when rename opens the prompt, this autocommand will trigger
					-- it will "press" CTRL-F to enter the command-line window `:h cmdwin`
					-- in this window I can use normal mode keybindings
					local cmdId = vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
						callback = function()
							local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
							vim.api.nvim_feedkeys(key, "c", false)
							vim.api.nvim_feedkeys("0", "n", false)
							-- autocmd was triggered and so we can remove the ID and return true to delete the autocmd
							cmdId = nil
							return true
						end,
					})
					vim.lsp.buf.rename()
					-- if LPS couldn't trigger rename on the symbol, clear the autocmd
					vim.defer_fn(function()
						-- the cmdId is not nil only if the LSP failed to rename
						if cmdId then
							vim.api.nvim_del_autocmd(cmdId)
						end
					end, 500)
				end

				-- mappings
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufoptsWithDesc("Definition"))
				vim.keymap.set("n", "<leader>r", on_rename, bufoptsWithDesc("Rename symbol"))
			end

			vim.lsp.config("gopls", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					gopls = {
						completeUnimported = true,
						gofumpt = true,
						staticcheck = true,
					},
				},
			})
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				on_attach = on_attach,
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
