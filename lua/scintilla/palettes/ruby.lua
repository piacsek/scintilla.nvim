-- scintilla-ruby: deep garnet red. Warm-anchored jewel tones — saturated rose,
-- coral, orange and gold — over a deep wine background, with one vivid teal
-- relief (atoms / map keys) for separation and pop, the way amethyst's cyan
-- works on purple. Tuned for vibrancy: the syntax sparkles rather than sitting
-- in dusty pastels, and the status bars carry a saturated garnet rather than a
-- muted wine. Same key contract as amethyst.lua (plus the optional
-- `bg_statusline`).

return {
	-- Surfaces (deep wine; richer than near-black so the warm tones sit alive)
	bg             = "#1a0608",
	bg_float       = "#270b11",
	bg_inactive    = "#200709",
	bg_dim         = "#380f18",
	bg_active      = "#4a1320", -- selection surface; kept deep so `accent` reads on it
	bg_winbar      = "#270b11",
	bg_cursorline  = "#260a0f",
	bg_colorcolumn = "#3e1019",
	bg_visual      = "#7a1f33", -- vivid wine selection (bg-only; tokens read through it)
	bg_statusline  = "#bd1424", -- deep blood-scarlet bar (StatusLine) — red-dominant, not pink

	-- Text (brighter, warmer rose-white)
	fg_normal      = "#ffd9dc",
	fg             = "#f0c5c8",
	fg_muted       = "#9a7176",
	fg_dim         = "#c79ca0",
	fg_bright      = "#fff0f2",

	-- Syntax — warm jewel tones, with one vivid cool relief (key)
	comment        = "#a8807a", -- warm mauve (muted, but not dead)
	string         = "#ffc233", -- jewel gold (literals)
	variable       = "#f5cca0", -- warm cream (frequent token, stays calm)
	keyword        = "#ff5c84", -- hot rose-red (punchy)
	type           = "#ff6a5c", -- vivid coral
	special        = "#ffd84d", -- bright gold
	preproc        = "#d97a45", -- amber-brown

	-- Mineral syntax accents
	func           = "#ff9838", -- bright orange (functions pop warm)
	module         = "#ff5fb0", -- vivid magenta-pink (bold)
	key            = "#2dd4bf", -- vivid teal (cool relief — atoms / map keys)
	constant       = "#ffa590", -- light salmon-coral

	-- UI accents
	cursor         = "#ff8a72", -- bright coral block cursor (in-family with the warm core)
	accent         = "#ff2d55", -- brilliant garnet (legible as fg on dark selections)
	match          = "#ff7ab0", -- pink

	-- Terminal ANSI palette — warm-anchored, but green/blue/cyan are hand-tuned
	-- (the syntax palette has no true green or blue) so :terminal stays usable.
	-- Refreshed to the vibrant hues. Slot 0 lifts to bg_dim.
	ansi = {
		[1] = "#ff2d55", [2] = "#3fcf6f", [3] = "#ffc233", [4] = "#5f9fe0",
		[5] = "#ff5fb0", [6] = "#2dd4bf", [7] = "#f0c5c8", [8] = "#9a7176",
		[9] = "#ff5c84", [10] = "#4fe088", [11] = "#ffd84d", [12] = "#7fb8f0",
		[13] = "#ff7ab0", [14] = "#4fe8d4", [15] = "#fff0f2",
	},
}
