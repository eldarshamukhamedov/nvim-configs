return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = true,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
					refresh_time = 16, -- ~60fps
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"CursorMoved",
						"CursorMovedI",
						"ModeChanged",
					},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					"location",
					"diff",
					"diagnostics",
				},
				lualine_x = {
					"lsp_status",
					{
						"filetype",
						fmt = function(str)
							if str == "javascript" then
								return "js"
							elseif str == "javascriptreact" then
								return "jsx"
							elseif str == "typescript" then
								return "ts"
							elseif str == "typescriptreact" then
								return "tsx"
							else
								return str
							end
						end,
					},
				},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {
				lualine_b = {
					{ "filetype", icon_only = true },
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 1,
						shorting_target = 80,
						fmt = function(str)
							if string.find(str, "neo-tree", 1, true) then
								return "[File Tree]"
							elseif string.find(str, "fugitive", 1, true) then
								return "[Git Status]"
							elseif string.find(str, ".git", 1, true) then
								return "[Git Commit]"
							else
								return str
							end
						end,
					},
					"diff",
					"diagnostics",
				},
			},
			inactive_winbar = {
				lualine_b = {
					{ "filetype", icon_only = true },
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 1,
						shorting_target = 80,
						fmt = function(str)
							if string.find(str, "neo-tree", 1, true) then
								return "[File Tree]"
							elseif string.find(str, "fugitive", 1, true) then
								return "[Git Status]"
							elseif string.find(str, ".git", 1, true) then
								return "[Git Commit]"
							else
								return str
							end
						end,
					},
				},
			},
			extensions = {},
		})
	end,
}
