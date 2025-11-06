return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavor = "mocha",
			color_overrides = {
				mocha = {
					base = "#000000",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
