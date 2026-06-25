-- scintilla-jade: deep jade green. Diverse syntax, but anchored in the green/teal/
-- cyan neighborhood so it sits seamlessly on the green background — where
-- amethyst uses warm pinks and violets, jade uses greens and teals. A warm gold
-- (strings) provides the complementary pop, the way amethyst's yellow does on
-- purple. Same key contract as amethyst.lua.

return {
	-- Surfaces (deep green-black)
	bg             = "#04120c",
	bg_float       = "#071c12",
	bg_inactive    = "#06160e",
	bg_dim         = "#0b2618",
	bg_active      = "#103a24",
	bg_winbar      = "#071c12",
	bg_cursorline  = "#0a2014",
	bg_colorcolumn = "#0d2c1a",
	bg_visual      = "#14492e", -- mid jade selection (bg-only; tokens read through it)

	-- Text
	fg_normal      = "#d8ecdf", -- soft mint-white
	fg             = "#c8e0d2",
	fg_muted       = "#5f8070",
	fg_dim         = "#93b3a2",
	fg_bright      = "#ecf8f1",

	-- Syntax — green-anchored, with a warm gold relief (string)
	comment        = "#5f8a72", -- sage
	string         = "#ffcf6b", -- warm gold (complementary pop)
	variable       = "#cfeab0", -- light chartreuse (frequent token)
	keyword        = "#5fe6b0", -- emerald (punchy, in-family)
	type           = "#a0e6c0", -- pale jade
	special        = "#ffae6b", -- warm orange (second warm accent)
	preproc        = "#5fb0d9", -- blue

	-- Mineral syntax accents
	func           = "#8fe66f", -- lime-green (functions)
	module         = "#3fd9c0", -- jade-teal (bold; in-family elevated)
	key            = "#79c0e8", -- sky-cyan (atoms / map keys)
	constant       = "#c0e89a", -- light green

	-- UI accents
	cursor         = "#c0e89a", -- light green block cursor (in-family with the green core)
	accent         = "#2ee68a", -- vivid jade-emerald (legible as fg on dark)
	match          = "#79e6c0", -- mint

	-- Terminal ANSI palette — green/cyan-anchored, with hand-tuned red and
	-- magenta (the syntax palette has neither) so :terminal error/highlight
	-- colors read correctly. Slot 0 lifts to bg_dim.
	ansi = {
		[1] = "#e8745f", [2] = "#8fe66f", [3] = "#ffcf6b", [4] = "#5fb0d9",
		[5] = "#c98fd0", [6] = "#3fd9c0", [7] = "#c8e0d2", [8] = "#5f8070",
		[9] = "#ff8f6b", [10] = "#2ee68a", [11] = "#ffdf8b", [12] = "#79b8e8",
		[13] = "#d99fe0", [14] = "#5fe6c8", [15] = "#ecf8f1",
	},
}
