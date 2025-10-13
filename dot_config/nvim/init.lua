require("config.lazy")

-- Toggle hiding whitespace characters
vim.keymap.set("n", "<leader>i", ":set list!<cr>")

-- Turn off search highlight
vim.keymap.set("n", "<leader><space>", ":nohlsearch<cr>")

-- Save file with leader w
vim.keymap.set("n", "<leader>w", ":w<cr>")

-- Fast swap to previous buffer
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Rename variables with leader r
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

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
