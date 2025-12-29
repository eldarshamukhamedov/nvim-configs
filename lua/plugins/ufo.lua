return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldcolumn = "0" -- change to "1" when nvim is upgraded
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.opt.fillchars = {
			eob = " ",
			fold = " ",
			foldopen = "",
			foldsep = " ",
			foldclose = "",
			-- foldinner = " ", -- enable when nvim is upgraded
		}

		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
}
