return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	config = function()
		-- Filetypes
		vim.filetype.add({ extension = { mdx = "mdx" } })
		vim.treesitter.language.register("markdown", "mdx")

		require("nvim-treesitter.configs").setup({
			-- Ensure the following parsers are installed
			ensure_installed = {
				"css",
				"html",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"tsx",
				"typescript",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
