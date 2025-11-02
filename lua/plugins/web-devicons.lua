return {
	"nvim-tree/nvim-web-devicons",
	name = "web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
			override_by_filename = {
				["package.json"] = {
					icon = "",
				},
			},
			override_by_extension = {
				["json"] = {
					icon = "",
				},
			},
		})
	end,
}
