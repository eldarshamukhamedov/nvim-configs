return {
	"airblade/vim-gitgutter",
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git status" })
		end,
	},
}
