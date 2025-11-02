return {
	"nvim-neo-tree/neo-tree.nvim",
	name = "neo-tree",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			enable_git_status = true,
			popup_border_style = "single",
			window = {
				position = "left",
				width = 30,
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				group_empty_dirs = true,
			},
		})
		vim.keymap.set("n", "<leader>e", "<cmd>Neotree<cr>", { desc = "Open Neotree" })
	end,
}
