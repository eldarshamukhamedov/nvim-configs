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
			model = "opencode/kimi-k2.5-free",
			-- model = "moonshotai/kimi-k2.5",
		})

		-- Fill in a function via a prompt
		vim.keymap.set("n", "<leader>9p", _99.fill_in_function_prompt)
		-- Prompt based on visual seletion
		vim.keymap.set("v", "<leader>9v", _99.visual_prompt)
		-- Stop all requests
		vim.keymap.set("v", "<leader>9s", _99.stop_all_requests)
	end,
}
