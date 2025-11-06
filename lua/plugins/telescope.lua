return {
	"nvim-telescope/telescope.nvim",
	commit = "a9bb091895cfe5088c448e6a7b16fc36a7b7acf7",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local picker_options = { theme = "ivy" }

		telescope.setup({
			defaults = {
				initial_mode = "normal",
				path_display = { "filename_first" },
			},
			pickers = {
				find_files = picker_options,
				buffers = picker_options,
				help_tags = picker_options,
				git_status = picker_options,
				lsp_implementations = picker_options,
				lsp_definitions = picker_options,
				lsp_references = picker_options,
				diagnostics = picker_options,
				live_grep = picker_options,
			},
		})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set("n", "<leader>fg", builtin.git_status, { desc = "Telescope Git status by file" })
		vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Telescope LSP go to implementation" })
		vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "Telescope LSP go to definition" })
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope LSP show references" })
		vim.keymap.set("n", "<leader>dl", builtin.diagnostics, { desc = "Telescope show diagnostics" })
		vim.keymap.set("n", "<leader>fF", builtin.live_grep, { desc = "Telescope grep in files" })
	end,
}
