return {
	"stevearc/conform.nvim",
	config = function()
		local prettier_format_options = {
			"prettier",
			timeout_ms = 3000,
			lsp_format = "never",
		}
		require("conform").setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 2000,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				css = prettier_format_options,
				html = prettier_format_options,
				javascript = prettier_format_options,
				javascriptreact = prettier_format_options,
				typescript = prettier_format_options,
				typescriptreact = prettier_format_options,
				json = prettier_format_options,
				jsonc = prettier_format_options,
				markdown = prettier_format_options,
				yaml = prettier_format_options,
			},
		})
	end,
}
