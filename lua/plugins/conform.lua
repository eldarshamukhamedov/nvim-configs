return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		local hostname = vim.fn.hostname()

		local webdev_formatter = {
			"prettier",
			timeout_ms = 3000,
			lsp_format = "never",
		}
		local kotlin_formatter = {
			"ktlint",
			timeout_ms = 3000,
			lsp_format = "never",
		}

		local on_save_timeout = 2000
		if hostname == "fw13-23-amd-7840u" then
			webdev_formatter = {
				"oxfmt",
				timeout_ms = 500,
				lsp_format = "never",
			}
			-- on_save_timeout = 500
		end

		conform.setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = on_save_timeout,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				kotlin = kotlin_formatter,
				css = webdev_formatter,
				scss = webdev_formatter,
				html = webdev_formatter,
				javascript = webdev_formatter,
				javascriptreact = webdev_formatter,
				typescript = webdev_formatter,
				typescriptreact = webdev_formatter,
				json = webdev_formatter,
				jsonc = webdev_formatter,
				markdown = webdev_formatter,
				yaml = webdev_formatter,
				mdx = webdev_formatter,
			},
		})
	end,
}
