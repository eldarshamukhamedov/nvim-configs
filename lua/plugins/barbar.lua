return {
	"romgrk/barbar.nvim",
	name = "barbar",
	version = false,
	config = function()
		require("barbar").setup({
			sidebar_filetypes = {
				["neo-tree"] = { event = "BufWipeout" },
			},
		})

		-- Move between buffers
		vim.keymap.set("n", "<leader>.", "<cmd>BufferNext<cr>", { desc = "Go to next buffer" })
		vim.keymap.set("n", "<leader>,", "<cmd>BufferPrevious<cr>", { desc = "Go to previous buffer" })
		vim.keymap.set("n", "<leader>x", "<cmd>BufferClose<cr>", { desc = "Close buffer" })
		vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>", { desc = "Open new buffer" })
	end,
}
