return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"nvim-tree/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({
					override_by_filename = {
						["package.json"] = { icon = "" },
						[".gitignore"] = { icon = "" },
						[".gitattributes"] = { icon = "" },
						[".git-blame-ignore-revs"] = { icon = "" },
						[".gitmodules"] = { icon = "" },
						[".npmrc"] = { icon = "" },
					},
					override_by_extension = {
						["json"] = { icon = "" },
					},
				})
			end,
		},
	},
lazy = false,
config = function()
	-- Narrow terminals: render the tree in the current window instead of a
	-- 30-col sidebar. Measured per keymap call so it follows live resizing;
	-- setup() snapshots it once for the `nvim .` netrw hijack, which reads
	-- the static config at startup
	local get_position = function()
		return vim.o.columns < 100 and "current" or "left"
	end

	require("neo-tree").setup({
		enable_git_status = true,

		filesystem = {
			hijack_netrw_behavior = "disabled",
			use_libuv_file_watcher = true,
			follow_current_file = {
				enabled = true,
			},
			-- group_empty_dirs = true,

			filtered_items = {
				always_show = {
					".bruno",
					".gitignore",
					".oxfmtrc.json",
					".npmrc",
					".storybook",
				},
				always_show_by_pattern = {
					".env*",
				},
			},
		},

		default_component_configs = {
			git_status = {
				symbols = {
					added = "+",
					modified = "",
					deleted = "-",
					renamed = "",

					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},

			modified = {
				-- Don't show symbol for unsaved buffers, BarBar already does this
				symbol = " ",
			},
		},

		popup_border_style = "single",
		window = {
			position = get_position(),
			width = 30,
		},
	})
	vim.keymap.set("n", "<leader>e", function()
		local cmd = require("neo-tree.command")
		-- Pressing inside an open tree: toggle that tree. The explicit
		-- position is what makes neo-tree redirect current-position
		-- requests to the tree under the cursor; without it the request
		-- falls back to the config default (left)
		if vim.bo.filetype == "neo-tree" then
			cmd.execute({ position = vim.b.neo_tree_position, toggle = true })
			return
		end
		local position = get_position()
		-- Tree open in the other position: switch instead of stacking two trees
		for _, w in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(w)
			if vim.bo[buf].filetype == "neo-tree" then
				if vim.b[buf].neo_tree_position ~= position then
					cmd.execute({ action = "close" })
					cmd.execute({ position = position })
					return
				end
				break
			end
		end
		cmd.execute({ position = position, toggle = true })
	end, { desc = "Open Neotree" })
end,
}
