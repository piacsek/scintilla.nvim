-- scintilla-diamond: the family's first LIGHT variant. A colorless, icy near-
-- white background that disperses into full-spectrum "fire" — the structural
-- tokens stay cool (indigo modules, violet keywords, cyan keys, blue preproc),
-- anchored on the faint-blue background, while warm pops (amber functions, rose
-- types, crimson constants) supply relief. Same key contract as amethyst.lua.
--
-- Because diamond is light, the whole palette inverts relative to the dark
-- variants: every syntax + UI-accent color is used as a *foreground on a light
-- surface* (or, in Search/Cursor, as the dark backdrop behind `bg`), so they
-- must all be DEEP and saturated. Only the surfaces, comment, muted and dim go
-- pale. fg_bright is the *darkest* text here (it reads on the light bg_active
-- statusline), the reverse of its role on the dark variants. bg_visual is a pale
-- blue so the deep syntax tokens read *through* the selection (Visual is bg-only).

return {
	-- Surfaces (icy near-white, faint blue tint)
	bg             = "#f2f4fb",
	bg_float       = "#ffffff", -- pure white floats lift above the cool bg
	bg_inactive    = "#e7ebf5",
	bg_dim         = "#dde3f0",
	bg_active      = "#bccbee", -- selected surface (PmenuSel, tabs, MatchParen)
	bg_statusline  = "#fbfcff", -- near-white StatusLine — just off white so the bar still reads against the bg
	bg_winbar      = "#eaeef8",
	bg_cursorline  = "#e8edf8", -- subtle line highlight
	bg_colorcolumn = "#e4e9f5",
	bg_visual      = "#c2d6f5", -- light blue selection (bg-only; deep tokens read through it)

	-- Text (dark on light)
	fg_normal      = "#1c2333", -- main editor text
	fg             = "#2b3344", -- UI text
	fg_muted       = "#9aa3b8",
	fg_dim         = "#6f7890",
	fg_bright      = "#11172a", -- DARKEST text (reads on the light bg_active surface)

	-- Syntax — cool-anchored spectral "fire", all deep enough for the light bg
	comment        = "#8b95ab", -- muted blue-gray
	string         = "#0e7a46", -- emerald (literals / numbers)
	variable       = "#455178", -- calm steel-blue (frequent token, stays quiet)
	keyword        = "#7c2fd4", -- violet (punchy)
	type           = "#c01b7a", -- rose-magenta (warm pop)
	special        = "#0a8a72", -- teal
	preproc        = "#1565c0", -- blue

	-- Mineral syntax accents
	func           = "#c0620a", -- amber-orange (functions pop warm)
	module         = "#2641c4", -- indigo (bold; in-family with the cool anchor)
	key            = "#0a7a9c", -- cyan (atoms / map keys)
	constant       = "#c23030", -- crimson (warm pop; Elixir module attrs)

	-- UI accents
	cursor         = "#1840d8", -- brilliant-blue block cursor (the diamond's brilliance; cool-anchored, reads crisp on the icy bg)
	accent         = "#1840d8", -- brilliant blue (the diamond's brilliance)
	match          = "#c0149a", -- magenta (stands out in completion against the blue accent)

	-- Terminal ANSI palette — a true LIGHT-terminal set. Slot 0 (black) is pinned
	-- back to a dark slate (the core would otherwise lift it to the light bg_dim,
	-- which makes terminal "black" invisible). The dark slots (0,8) serve as
	-- foreground; the light slots (7,15) serve as background, per light-theme
	-- convention. Yellow is a dark amber so it reads on white.
	ansi = {
		[0] = "#2b3344", [1] = "#c23030", [2] = "#0e7a46", [3] = "#b07000",
		[4] = "#1565c0", [5] = "#b01b8e", [6] = "#0a7a9c", [7] = "#c2c8d6",
		[8] = "#6f7890", [9] = "#d94444", [10] = "#18965a", [11] = "#c08a00",
		[12] = "#2d6fe0", [13] = "#c844a8", [14] = "#1593b8", [15] = "#eef1f8",
	},
}
