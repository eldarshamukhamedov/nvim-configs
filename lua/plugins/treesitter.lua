return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "neovim-treesitter/treesitter-parser-registry" },
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Filetypes
		vim.filetype.add({ extension = { mdx = "mdx" } })
		vim.treesitter.language.register("markdown", "mdx")

		local parsers = {
			"css",
			"html",
			"javascript",
			"jsx",
			"lua",
			"markdown",
			"markdown_inline",
			"tsx",
			"typescript",
			"kotlin",
			"java",
		}
		require("nvim-treesitter").setup({})
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"css",
				"html",
				"javascript",
				"javascriptreact",
				"lua",
				"markdown",
				"markdown_inline",
				"typescript",
				"typescriptreact",
				"kotlin",
				"java",
			},
			callback = function()
				-- Single quotes around 'nvim-treesitter' are required
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.treesitter.start()
			end,
		})
	end,
}
