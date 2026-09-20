return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	ft = { "markdown", "mdx" },
	keys = {
		{
			"<leader>md",
			function()
				require("render-markdown").toggle()
			end,
			desc = "Toggle markdown render",
		},
	},
	opts = {
		file_types = { "markdown", "mdx" },
	},
}
