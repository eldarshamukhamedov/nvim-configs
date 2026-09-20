# Kotlin setup + treesitter main-branch migration

Date: 2026-09-20
Commit: 5ab8e37 (kotlin setup, treesitter main-branch rewrite);
follow-up d982a7f (treesitter: cindent fallback for kotlin, no indents.scm
upstream)

## What changed

Three plugin files, all part of one work stream: getting Kotlin/Java working
in this config.

- `lua/plugins/lspconfig.lua` — new `kotlin_ls` config for the
  `fw13-23-amd-7840u` host only: runs `kotlin-language-server`, kotlin
  filetypes, root markers are gradle settings/build files plus `.git`.
  Enabled alongside tsgo and oxlint on that host.
- `lua/plugins/conform.lua` — `ktlint` as the kotlin formatter (3s timeout,
  never LSP-format). Also commented out the `on_save_timeout = 500` override
  for the fw13 host, so format-on-save there uses the default 2000ms again.
- `lua/plugins/treesitter.lua` — migrated off the legacy nvim-treesitter
  API to the rewritten `main` branch, and added `kotlin` + `java` parsers.

## Treesitter migration details

The old config used `require("nvim-treesitter.configs").setup` with
`ensure_installed`, `highlight`, and `indent` tables. The `main` branch is a
full incompatible rewrite; that module no longer exists. New shape:

- spec: `branch = "main"`, `lazy = false` (plugin does not support
  lazy-loading), `build = ":TSUpdate"`, plus
  `neovim-treesitter/treesitter-parser-registry` as a dependency (parsers
  now install as prebuilt archives from the registry).
- parsers installed via `require("nvim-treesitter").install(parsers)`.
- highlighting enabled per-filetype by a `FileType` autocmd calling
  `vim.treesitter.start()`; patterns include `javascriptreact` /
  `typescriptreact` alongside the parser names.
- `kotlin` and `java` added to both the parser list and the autocmd pattern.

## Discovery: indent was silently dropped, then fixed

The legacy `indent = { enable = true }` block died with the module API.
On `main`, treesitter indent is opt-in per-filetype via an experimental
indentexpr. Fixed in this session by setting, in the same autocmd callback:

```lua
-- Single quotes around 'nvim-treesitter' are required
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.treesitter.start()
```

Quoting inside the string is literal per the docs.

## Requirements / environment

- main branch requires Neovim 0.12+; this machine runs 0.12.4 — fine.
- README also lists `tar`, `curl`, and `tree-sitter-cli` (0.26.1+, not npm).

## Open / unverified

- `jsx` is listed as a parser in both the old `ensure_installed` and the new
  install list; not verified whether the main-branch registry actually has a
  `jsx` parser (javascript may cover it).
- `markdown_inline` appears in the FileType autocmd pattern but is a parser
  name, not a filetype — harmless no-op, could be cleaned up.
- Indent fix verified for js/ts (user); kotlin proved broken, see next
  section.

## Follow-up: kotlin indent has no upstream query — cindent fallback

The treesitter indent fix worked for js/ts/java but not kotlin: the kotlin
parser tarball ships `folds/highlights/injections/locals` queries but no
`indents.scm`. Confirmed in three places that kotlin indent queries don't
exist upstream:

- local install at `~/.local/share/nvim/site/queries/kotlin/` — no
  `indents.scm` (java and typescript have one)
- `SUPPORTED_LANGUAGES.md` on main: kotlin is `HF JL` (no Indents), java/ts
  are `HFIJL`
- the new per-language repo `neovim-treesitter/nvim-treesitter-queries-kotlin`
  (queries were split out after the April 2026 archive/unarchive) — also 404s
  on `indents.scm`

Mechanism: `indentexpr()` returns `-1` when no indent query exists, which
Neovim treats as autoindent (copy previous line), so kotlin got flat
indentation while other languages stayed structure-aware. Also relevant: the
indent engine on `main` is experimental and mid-rewrite (nvim-treesitter
issue #7840); user's plugin is pinned at the original repo
(`nvim-treesitter/nvim-treesitter` @ f603a2f per lazy-lock.json).

Resolution (user's call, after declining a custom kotlin indents.scm): keep
treesitter indentexpr for everything else, give kotlin Neovim's built-in
`cindent`. Kotlin keeps `vim.treesitter.start()` for highlighting; indentexpr
stays empty there so cindent can engage. ktlint via conform handles full
indent correctness on save, so cindent only needs to be good while typing.

Autocmd callback now branches on `args.match == "kotlin"`. If cindent feels
wrong in practice, fallback option: runtime `indent/java.vim` applied to
kotlin buffers.
