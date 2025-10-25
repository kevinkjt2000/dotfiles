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

-- Configure CtrlP
vim.keymap.set("n", "<leader>f", ":CtrlP<cr>")
vim.keymap.set("n", "<leader>b", ":CtrlPBuffer<cr>")
vim.g.ctrlp_user_comand = {
	types = { [1] = { ".git", 'cd %s && git ls-files -co --exclude-standard | grep -v "/\\.keep"' } },
	fallback = "find %s -type f",
}
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
	pattern = { "go" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- Register additional languages with treesitter
vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").go = {
			install_info = {
				url = "https://github.com/tree-sitter/tree-sitter-go",
				revision = "2346a3ab1bb3857b48b29d779a1ef9799a248cd7",
				queries = "queries",
			},
		}
	end,
})
