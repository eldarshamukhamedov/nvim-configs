local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
	vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
local plugins = {
	{
		"nvim-telescope/telescope.nvim",
		commit = "7fb51c8255e8cf689fde6779ca581ab71e76dddd",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- ADD INIT.LUA SETTINGS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local picker_options = { theme = "ivy" }

			telescope.setup({
				defaults = {
					initial_mode = "normal",
					path_display = { "filename_first" },
				},
				pickers = {
					find_files = picker_options,
					buffers = picker_options,
					help_tags = picker_options,
					git_status = picker_options,
					lsp_implementations = picker_options,
					lsp_definitions = picker_options,
					lsp_references = picker_options,
					diagnostics = picker_options,
					live_grep = picker_options,
				},
			})

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		end,
	},
}

-- space as leader
vim.api.nvim_set_keymap("", "<space>", "<nop>", { silent = true, noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "


require("lazy").setup(plugins, {
	root = root .. "/plugins",
})
