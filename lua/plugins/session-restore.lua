return {
	"rmagatti/auto-session",
	lazy = false, -- must load at startup if you want auto-restore
	opts = {
		auto_restore_enabled = true,
		auto_session_suppress_dirs = { "~/", "~/Downloads", "/" }, -- don't save sessions in these folders
	},
}
