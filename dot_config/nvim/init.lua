require("config.lazy")

-- Toggle hiding whitespace characters
vim.keymap.set("n", "<leader>i", ":set list!<cr>")

-- Turn off search highlight
vim.keymap.set("n", "<leader><space>", ":nohlsearch<cr>")

-- Save file with leader w
vim.keymap.set("n", "<leader>w", ":w<cr>")

-- Fast swap to previous buffer
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- TODO Change CtrlP to open with <leader>f instead
-- TODO Change CtrlP buffer mode to open with <leader>b

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
