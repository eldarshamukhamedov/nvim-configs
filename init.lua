-- General options
vim.opt.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.scroll = 8
vim.o.scrolloff = 8
vim.o.updatetime = 100
vim.o.colorcolumn = "80"
vim.o.backupcopy = "yes"

-- Popup (e.g. autocomplete) max height
vim.o.pumheight = 30

-- Enable wrap for markdown files
local enable_wrap_options = {
	pattern = { "*.md" },
	callback = function()
		vim.o.wrap = true
	end,
}
vim.api.nvim_create_autocmd("BufNewFile", enable_wrap_options)
vim.api.nvim_create_autocmd("BufRead", enable_wrap_options)

-- Global leader key
vim.api.nvim_set_keymap("", "<space>", "<nop>", { silent = true, noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Show whitespace
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = false
vim.o.shiftwidth = 2
vim.o.list = true
vim.opt.listchars = {
	space = "·",
	tab = "| ",
}

-- Override .editorconfig
vim.g.editorconfig = false

-- Clipboard interaction ('n' for normal mode, 'x' for visual mode)
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from clipboard" })

-- Remap q (record macro) to Q, and Q (replay last register) to <M-q>
-- nvim-cmp is disable in record macro mode, and I press q by accident too much
vim.keymap.set("n", "q", "<nop>", { noremap = true })
vim.keymap.set("n", "Q", "q", { noremap = true, desc = "Record macro" })
vim.keymap.set("n", "<M-q>", "Q", { noremap = true, desc = "Replay last register" })

-- Load LazyVim package manager
require("config.lazy")

-- Disable deprecation warnings (YOLO)
vim.deprecate = function() end
