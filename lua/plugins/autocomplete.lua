return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				-- Previous/next suggestion
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				-- Manually trigger suggestion
				["<C-Space>"] = cmp.mapping.complete(),
				-- Close suggestion
				["<C-e>"] = cmp.mapping.abort(),
				-- Accept suggestion
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = true, { "i", "c" } }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lua" }, -- neovim lua api
				{ name = "nvim_lsp" }, -- neovim builtin lsp engine
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
		})
	end,
}
