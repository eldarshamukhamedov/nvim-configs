return {
	"nvim-telescope/telescope.nvim",
	name = "telescope",
	version = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				initial_mode = "normal",
			},
		})

		local function ivy_theme(tele_command)
			return function()
				tele_command(require("telescope.themes").get_ivy({
					shorten_path = true,
					path_display = {
						"filename_first",
					},
				}))
			end
		end

		local tele_builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", ivy_theme(tele_builtin.find_files), { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fb", ivy_theme(tele_builtin.buffers), { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", ivy_theme(tele_builtin.help_tags), { desc = "Telescope help tags" })
		vim.keymap.set("n", "<leader>fg", ivy_theme(tele_builtin.git_status), { desc = "Telescope Git status by file" })
		vim.keymap.set(
			"n",
			"<leader>fi",
			ivy_theme(tele_builtin.lsp_implementations),
			{ desc = "Telescope LSP go to implementation" }
		)
		vim.keymap.set(
			"n",
			"<leader>fd",
			ivy_theme(tele_builtin.lsp_definitions),
			{ desc = "Telescope LSP go to definition" }
		)
		vim.keymap.set(
			"n",
			"<leader>fr",
			ivy_theme(tele_builtin.lsp_references),
			{ desc = "Telescope LSP show references" }
		)
		vim.keymap.set("n", "<leader>dl", ivy_theme(tele_builtin.diagnostics), { desc = "Telescope show diagnostics" })
		vim.keymap.set("n", "<leader>fF", ivy_theme(tele_builtin.live_grep), { desc = "Telescope grep in files" })
	end,
}
