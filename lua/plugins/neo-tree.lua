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
		require("neo-tree").setup({
			enable_git_status = true,

			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				-- group_empty_dirs = true,

				filtered_items = {
					always_show = {
						".bruno",
						".gitignore",
						".npmrc",
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
						modified = "",
						deleted = "-",
						renamed = "",

						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},

				modified = {
					-- Don't show symbol for unsaved buffers, BarBar already does this
					symbol = " ",
				},
			},

			popup_border_style = "single",

			window = {
				position = "left",
				width = 30,
			},
		})
		vim.keymap.set("n", "<leader>e", "<cmd>Neotree<cr>", { desc = "Open Neotree" })
	end,
}
