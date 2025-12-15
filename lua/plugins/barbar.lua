return {
	"romgrk/barbar.nvim",
	enabled = false,
	version = false,
	config = function()
		require("barbar").setup({
			icons = {
				modified = { button = "" },
				pinned = { filename = true },
			},

			-- sidebar_filetypes = {
			-- 	["neo-tree"] = { event = "BufWipeout" },
			-- },
		})

		-- Move between buffers
		vim.keymap.set("n", "<leader>.", "<cmd>BufferNext<cr>", { desc = "Go to next buffer" })
		vim.keymap.set("n", "<leader>,", "<cmd>BufferPrevious<cr>", { desc = "Go to previous buffer" })
		vim.keymap.set("n", "<leader>p", "<cmd>BufferPin<cr>", { desc = "Pin buffer" })
		vim.keymap.set("n", "<leader>x", "<cmd>BufferClose<cr>", { desc = "Close buffer" })
		vim.keymap.set(
			"n",
			"<leader>X",
			"<cmd>BufferCloseAllButCurrentOrPinned<cr>",
			{ desc = "Close all but current or pinned" }
		)
		vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>", { desc = "Open new buffer" })
	end,
}
