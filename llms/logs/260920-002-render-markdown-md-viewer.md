# render-markdown md/mdx viewer

## 260920

- Reviewed MeanderingProgrammer/render-markdown.nvim against the config as a
  candidate default viewer for markdown files. No blocking conflicts: nvim
  0.12.4, treesitter `markdown`/`markdown_inline`/`html` parsers already
  installed via main-branch nvim-treesitter, icon provider available through
  nvim-web-devicons, catppuccin auto-integrations picks up the highlight
  groups.
- Added `lua/plugins/render-markdown.lua`: spec lazy-loads on
  `ft = { "markdown", "mdx" }`, renders on by default (`enabled` default
  true), `file_types = { "markdown", "mdx" }`, keymap `<leader>md` toggles
  rendering via `require("render-markdown").toggle()` (also forces lazy load
  when pressed in a non-md buffer). No existing `<leader>m*` maps, no
  conflicts.
- Added `yaml` to the nvim-treesitter parser list for frontmatter rendering
  (was the only optional render-markdown parser missing).
- Fixed the long-standing global-wrap leak: the old `BufNewFile`/`BufRead`
  `*.md` autocmd set `vim.o.wrap = true` (global), so opening any markdown
  file turned wrap on for every new window in the session. Replaced with a
  single `FileType` autocmd for `markdown`/`mdx` that no longer touches wrap
  (global `wrap = false` now applies everywhere; line lengths delegated to
  the linter/prettier) and sets buffer-locally: `listchars` without the
  `space = "·"` char (dots show through render-markdown padding) and empty
  `colorcolumn` (columns draw over rendered backgrounds).
- Plugin install handled by the user via Lazy; lazy-lock.json already
  carries the entry. Unverified at commit time: `:checkhealth render-markdown`.
- Investigated a report of text still wrapping after the fix: headless probes
  with the full config showed `nowrap` for both global and window values,
  `textwidth=0`, editorconfig genuinely disabled (`g:editorconfig=false`,
  `loaded_editorconfig` unset), no after/ftplugin or site-pack overrides,
  and render-markdown only reads `wrap` (its `pipe_table.wrap` logic checks
  the window value). Not reproducible from here; the user rechecked and
  confirmed it resolved (likely a stale window-local wrap value from the
  old autocmd before restart). No code change needed.
- Considered per-block wrap (webpage-like: prose wraps, code blocks scroll
  horizontally) — not possible: `wrap` is window-local in Neovim, so no
  plugin can wrap one region and scroll another in the same window.
  Closest: render-markdown's `pipe_table.wrap` for tables; a window-local
  wrap toggle was considered and rejected to keep things simple.
