# neotree width-based position

## 260920

- Feature: neo-tree opens in `position = "current"` when `vim.o.columns < 100`,
  `position = "left"` otherwise, measured at open time. Chosen basis is the
  terminal width, not the current window: splits can make a window narrow
  while a 30-col sidebar still fits; a narrow terminal is the real pain
  point. Threshold 100 picked because the sidebar is 30 wide, leaving 70 for
  content. No live reposition on resize (user declined); the keymap
  recomputes on next press.
- Replaced the `<leader>e` string mapping with a Lua keymap that drives
  `require("neo-tree.command").execute`. The command API accepts a runtime
  `position` override (command/init.lua), so `setup()` needed no behavior
  change for the keymap path. Logic:
  - Inside an open tree: toggle that exact tree. Passing the tree's own
    `vim.b.neo_tree_position` explicitly is required — with no position, the
    request falls back to the config default (`left`); neo-tree's own
    "redirect current-position to the tree under the cursor" only triggers
    when `position = "current"` is passed explicitly (command/init.lua:128).
    Found via headless test where the naive no-position toggle left the
    current tree open and opened a left tree instead.
  - Tree open in the other position: close it first, then open in the new
    position. Without this, neo-tree stacks a second tree (left sidebar
    stays open while a current-position tree also opens) because
    `toggle = true` only closes the computed position's state.
  - Otherwise: `execute({ position = position, toggle = true })`.
- Verified all four keymap scenarios headless: narrow open → current, toggle
  inside tree → closed, wide open → left, left open + shrink + press from an
  editor window → switched to current.
- `nvim .` case: the netrw hijack (setup/netrw.lua) never goes through the
  keymap; it reads the static `window.position` from `nt.config` — always
  `left`, ignoring terminal width. Fix: `get_position()` helper shared by
  `setup()` and the keymap; `setup()` snapshots it once at startup (safe
  because the plugin is `lazy = false`, so terminal size is known during
  eager plugin load). Verified headless: `nvim <dir>` at 80 cols hijacks to
  `current`, at 120 cols to `left`, tree focused in both.
- Static `window.position` in config now equals the startup-computed value;
  manual `:Neotree` invocations follow it. If the terminal is resized later
  in the session, a manual `:Neotree` (not the keymap) uses the stale
  snapshot — accepted, rare path.
