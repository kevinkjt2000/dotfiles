require("config.lazy")

-- Toggle hiding whitespace characters
vim.keymap.set("n", "<leader>i", ":set list!<cr>")

-- Turn off search highlight
vim.keymap.set("n", "<leader><space>", ":nohlsearch<cr>")

-- Save file with leader w
vim.keymap.set("n", "<leader>w", ":w<cr>")

-- Fast swap to previous buffer
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Make the completion popups more obvious
vim.o.winborder = "rounded"

-- Smaller tabs
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = false

-- Configure CtrlP
vim.keymap.set("n", "<leader>f", ":CtrlP<cr>")
vim.keymap.set("n", "<leader>b", ":CtrlPBuffer<cr>")
vim.g.ctrlp_user_command = { ".git", 'git -C %s ls-files --cached --others --exclude-standard | grep -v "/\\.keep"' }
vim.g.ctrlp_working_path_mode = ""

-- Improve display of warnings and errors
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	virtual_text = {
		current_line = true,
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
})

-- Enable treesitter syntax highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "rust" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- Register additional languages with treesitter
vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		local parsers = require("nvim-treesitter.parsers")
		parsers.go = {
			install_info = {
				url = "https://github.com/tree-sitter/tree-sitter-go",
				revision = "2346a3ab1bb3857b48b29d779a1ef9799a248cd7",
				queries = "queries",
			},
		}
		parsers.rust = {
			install_info = {
				url = "https://github.com/tree-sitter/tree-sitter-rust.git",
				revision = "77a3747266f4d621d0757825e6b11edcbf991ca5",
				queries = "queries",
			},
		}
	end,
})
