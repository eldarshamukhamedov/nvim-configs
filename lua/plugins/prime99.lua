return {
	"ThePrimeagen/99",
	enabled = function()
		return vim.fn.hostname() == "fw13-23-amd-7840u"
	end,
	config = function()
		local _99 = require("99")

		_99.setup({
			completion = { source = "cmp" },
			-- Run "opencode models" to get a list of slugs
			-- model = "opencode/kimi-k2.5-free",
			model = "moonshotai/kimi-k2.5",
		})

		-- Fill in a function via a prompt
		-- vim.keymap.set("n", "<leader>9p", _99.fill_in_function_prompt)
		--
		vim.keymap.set("n", "<leader>9s", function()
			_99.search()
		end)
		--
		vim.keymap.set("n", "<leader>9o", function()
			_99.open()
		end)
		--
		vim.keymap.set("n", "<leader>9p", function()
			_99.vibe()
		end)
		-- Prompt based on visual seletion
		vim.keymap.set("v", "<leader>9v", function()
			_99.visual()
		end)
		vim.keymap.set("n", "<leader>9l", function()
			_99.view_logs()
		end)
		-- Stop all requests
		vim.keymap.set("n", "<leader>9x", function()
			_99.stop_all_requests()
		end)
	end,
}
