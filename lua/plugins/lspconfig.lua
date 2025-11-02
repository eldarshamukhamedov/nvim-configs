return {
	"neovim/nvim-lspconfig",
	name = "lspconfig",
	version = false,
	config = function()
		-- TypeScript
		vim.lsp.config("ts_ls", {
			init_options = {
				preferences = {
					importModuleSpecifier = "non-relative",
					importModuleSpecifierPreference = "non-relative",
				},
			},
		})
		vim.lsp.enable("ts_ls")

		-- ESLint
		vim.lsp.enable("eslint")

		-- Error display
		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.hover, { desc = "Open LSP hover float" })
	end,
}
