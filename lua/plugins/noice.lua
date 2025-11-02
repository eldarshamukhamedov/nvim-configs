return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			view = "cmdline",
		},
		routes = {
			{ filter = { event = "msg_show", kind = "", find = "written" } },
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				render = "compact",
				stages = "static",
				timeout = 2500,
				top_down = false,
			},
		},
	},
}
