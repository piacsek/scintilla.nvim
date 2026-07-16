# scintilla.nvim — repo guide

A family of "deep" gemstone colorschemes forked from Neovim's bundled
`zaibatsu`. Each variant is `scintilla-<gem>` (amethyst, ruby, jade, sapphire, …).

## Architecture

- `lua/scintilla/init.lua` — shared core. `M.apply(name, palette)` loads zaibatsu
  as a base, then drives the editor base (Normal, core syntax, line numbers,
  cursorline, selection, search), surfaces (floats, statusline, tabs, popups),
  treesitter and LSP groups from the palette. `M.load(variant)` requires
  `scintilla.palettes.<variant>` and applies it as `scintilla-<variant>`.
- `lua/scintilla/palettes/<gem>.lua` — a palette table. Every palette must define
  the full semantic key contract (see `amethyst.lua` for the canonical list:
  surfaces, text, syntax, accents). Two optional keys: `cursor` (a hex string
  overriding the `Cursor` block color, which otherwise derives from `string`) and
  `ansi` (a 0–15-keyed table overriding `g:terminal_color_*`; see below).
- `colors/scintilla-<gem>.lua` — one line: `require("scintilla").load("<gem>")`.

Adding a gem = a new palette file + a one-line colors file. No core changes.

## Palette philosophy

Each gem must be **diverse** (not monochromatic) AND feel **seamless with its
background**. Two failure modes we've hit:
- Monochromatic syntax (all one hue) reads "weird."
- Amethyst's exact hues on another bg read "foreign" — its purple-family violet
  modules / cornflower atoms clash on a red or green background.

The working principle: **analogous harmony anchored on the background's hue,
plus a complementary pop or two for relief and token separation.** This is why
amethyst works — a purple-family core (violet modules, lavender constants,
cornflower keys) with cyan/yellow pops.

- **ruby** (maroon bg): warm core — golds, corals, rose-red modules — with one
  cool teal accent for atoms/keys (the "cyan relief" role).
- **jade** (green bg): green/teal/cyan core with a warm gold (strings) as the pop.

**`Visual` is background-only** — the core sets `bg = bg_visual` and no
foreground, so each token keeps its own syntax color *through* the selection
(forcing a single `fg` flattens selected text to one color and loses
highlighting). The consequence: `bg_visual` must contrast against **every**
syntax color at once, not just one. Pick a deep, low-ish-saturation tint on the
dark variants (dark enough that bright tokens read) and a pale tint on the light
variant (light enough that the deep tokens read). `QuickFixLine` links to
`Visual`, so it inherits the same behavior.

### Light variants (e.g. `diamond`)

The core's color math is background-agnostic, so a **light** variant just
inverts which palette roles are pale vs. deep — no core changes. In a light
palette:
- **Every syntax + UI-accent color must be deep/saturated.** Each is used either
  as a foreground on a light surface (`Comment`, `@function`, `accent` on
  `bg_active`, `match` on `bg_float`, …) or as the dark backdrop behind the light
  `bg` (`Search`→`variable`, `IncSearch`→`func`, `Cursor`→`cursor`). Pale syntax
  would vanish in both roles. Only the surfaces, `comment`, `fg_muted`, `fg_dim`
  go light.
- **`fg_bright` is the *darkest* text**, not the lightest — it's the statusline
  foreground on the light `bg_active`. The inverse of its dark-variant role.
- **Pin `ansi[0]` to a dark color** in the variant's `ansi` table. The core lifts
  slot 0 to `bg_dim` for dark-variant terminal-border contrast, but on a light
  variant `bg_dim` is pale and would make terminal "black" invisible. Follow the
  light-terminal convention: dark slots (0, 8) read as foreground, light slots
  (7, 15) serve as background.

## Terminal (ANSI) palette

The core sets **all 16** `g:terminal_color_0..15` so every variant exposes a
complete, scintilla-owned ANSI palette to `:terminal` and to anything mirroring
it (e.g. ghostty-mirror). Slot 0 (ANSI black) is always lifted to `bg_dim` so
`:terminal` borders stay visible. The core default maps each ANSI slot to its
closest semantic key (`type`→red, `special`→green, `string`→yellow, …), but
because each variant's syntax palette is anchored on **one** hue family it can't
supply a believable red/green/blue across the board. So every shipped variant
defines a full `ansi = { [1]=…, … [15]=… }` table (omit `[0]`; it stays
`bg_dim`) with hand-tuned, recognizable ANSI hues — error-red, success-green
etc. must read correctly in a terminal even on a mono-hue theme. **Amethyst's
`ansi` is pinned to zaibatsu's exact 16 colors** so its `:terminal` stays
byte-identical to upstream. When you add/edit a variant, give it a complete,
internally-distinct `ansi`; ANSI changes don't affect the README gallery (those
render syntax, not `:terminal`), but they do change the generated Ghostty theme
files — regenerate those via the mirror (`:ThemeToGhostty`, or headless
`write_generated`).

## Hard rules

- **Never change `scintilla-amethyst`** (palette or rendered output) unless the
  user explicitly asks. It's the reference variant and their daily theme. When
  refactoring shared code, verify amethyst's output is byte-identical (diff its
  highlight groups against the previous version / against `zaibatsu` for base
  groups).
- Each palette owns its own syntax hues — there is no shared syntax module.
- **Keep this file current.** Whenever we agree on a new convention or guideline,
  add it here in the same change.

## Verifying a change

Headless render of any variant:

```sh
nvim --headless --clean --cmd "set rtp+=$PWD" -c "colorscheme scintilla-<gem>" \
  -c "redir => m | for g in ['Normal','Statement','@module','@property','Visual','PmenuSel'] | silent exe 'hi '.g | endfor | redir END | echo m" \
  -c "qa"
```

Confirm: syntax categories are distinct, `Visual` selected-text is readable, the
UI accent reads on dark selections, and (for shared-code changes) amethyst is
unchanged.

## Sample screenshots (README gallery)

The README's Variants section has a `###` sub-section per variant — a colored
circle emoji + `` `scintilla-<gem>` `` heading, then a two-column `tsx | ex`
table holding `samples/screenshots/<gem>-tsx.png` and `<gem>-ex.png`, each
`samples/showcase.*` rendered with treesitter highlighting. **Whenever a change visibly alters a
theme** (a palette edit, a new gem, or any shared-core change that shifts
colors), regenerate the gallery so the README stays truthful:

```sh
samples/render.sh            # all variants (auto-discovered from palettes/)
samples/render.sh ruby jade  # only the named ones
```

The script drives `nvim :TOhtml` → headless Google Chrome → ImageMagick (no live
GUI screenshot). When you **add a gem**, also add a `###` sub-section to the
README's Variants section: a circle emoji matching the gem's hue + the
`` `scintilla-<gem>` `` heading, then the `tsx | ex` table
(`<gem>-tsx.png` | `<gem>-ex.png`). When you **add a syntax
construct worth showing**, extend the two `showcase.*` files (keep them
exercising the full set: modules, functions, keys/atoms, strings, types,
constants, numbers, comments) and re-run for every variant. Commit the
regenerated PNGs alongside the palette change.

## Install / dev loop

Consumed via `vim.pack` from `piacsek/scintilla.nvim`. The user develops in
`~/projects/scintilla.nvim` and the installed copy lives at
`~/.local/share/nvim/site/pack/core/opt/scintilla.nvim`. After pushing, refresh
the installed copy through `vim.pack` — **never** a manual `git pull`/`checkout`
in the installed clone (that desyncs it from the lock file, and `:checkhealth`
then reports a version diff between the lock file and the checked-out commit).
Run `vim.pack.update()`: it opens a confirmation buffer that must be `:w`-saved
to apply, and it rewrites the lock file so `:checkhealth` stays clean.
