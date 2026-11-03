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
	-- Narrow terminals: render the tree in a floating window instead of a
	-- 30-col sidebar. Measured per keymap call so it follows live resizing;
	-- setup() snapshots it once for the `nvim .` netrw hijack, which reads
	-- the static config at startup
	local get_position = function()
		return vim.o.columns < 100 and "float" or "left"
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
					".scratch*",
					".git*",
					".claude*",
					-- neo-tree anchors these patterns to the full string (^...$), so a
					-- leading/trailing "*" is required to match nested paths at any depth
					"*/.scratch/*",
					"*/.git/*",
					"*/.claude/*",
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
		for _, w in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(w)
			if vim.bo[buf].filetype == "neo-tree" then
				vim.api.nvim_set_current_win(w)
				return
			end
		end
		require("neo-tree.command").execute({ position = get_position() })
	end, { desc = "Open Neotree" })
end,
}
