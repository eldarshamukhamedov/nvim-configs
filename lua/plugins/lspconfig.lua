return {
	"neovim/nvim-lspconfig",
	version = false,
	config = function()
		local hostname = vim.fn.hostname()

		if hostname == "fw13-23-amd-7840u" then
			-- TypeScript 7
			vim.lsp.config("tsgo", {
				init_options = {
					preferences = {
						-- These settings usually carry over as they are passed to the
						-- underlying TypeScript server host
						importModuleSpecifier = "non-relative",
						importModuleSpecifierPreference = "non-relative",
					},
				},
			})
			vim.lsp.enable("tsgo")

			-- Oxlint
			vim.lsp.config("oxlint", {
				settings = {
					run = "onType",
					fixKind = "safe",
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							client:exec_cmd({
								title = "Apply Oxlint automatic fixes",
								command = "oxc.fixAll",
								arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
							})
						end,
					})
				end,
			})
			vim.lsp.enable("oxlint")
		else
			-- TypeScript 6
			vim.lsp.config("ts_ls", {
				init_options = {
					preferences = {
						importModuleSpecifier = "non-relative",
						importModuleSpecifierPreference = "non-relative",
					},
				},
			})
			vim.lsp.enable("ts_ls")

			-- ESLint
			vim.lsp.enable("eslint")
		end

		-- MDX
		vim.lsp.config("mdx_analyzer", {
			init_options = {
				typescript = {
					enabled = true,
				},
			},
		})
		vim.lsp.enable("mdx_analyzer")

		-- Tailwind V4
		if hostname == "fw13-23-amd-7840u" then
			vim.lsp.config("tailwindcss", {
				root_dir = function(bufnr, on_dir)
					-- Copied and modified from https://github.com/neovim/nvim-lspconfig/blob/1c505a2a37c7732fb2a7e290c0f822abfb2ba1c5/lsp/tailwindcss.lua#L110
					-- Tailwind V4 doesn't have a local per-package config
					-- The TW LSP struggles to find the correct root in multi-package repos
					-- It finds the first package.json with a mention of "tailwind" and sets that as root
					-- Instead, we want to set root to the monorepo root

					-- Opened buffer file path
					local fname = vim.api.nvim_buf_get_name(bufnr)
					-- .git path
					local git_path = vim.fs.find({ ".git" }, { path = fname, upward = true })[1]
					-- Monorepo root path
					local repo_root_path = vim.fs.dirname(git_path)

					on_dir(repo_root_path)
				end,

				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
							},
						},
						classFunctions = { "cva" },
					},
				},
			})
			vim.lsp.enable("tailwindcss")
		end

		-- Lua
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
						},
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})
		vim.lsp.enable("lua_ls")

		-- Error display
		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			update_in_insert = false,
			signs = {
				severity_sort = true,
			},
			float = {
				close_events = {
					"CursorMoved",
					"BufHidden",
					"LspDetach",
				},
			},
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.hover, { desc = "Open LSP hover float" })
	end,
}
