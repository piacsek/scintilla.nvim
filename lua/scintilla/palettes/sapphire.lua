-- scintilla-sapphire: deep sapphire blue. Diverse syntax anchored in the blue /
-- cyan / teal / indigo neighborhood so it sits seamlessly on the navy background,
-- with warm gold + amber (strings, functions) as the complementary pops — blue's
-- complement is gold, the same relief trick as amethyst's cyan on purple. Same
-- key contract as amethyst.lua.

return {
	-- Surfaces (deep navy / blue-black)
	bg             = "#04081a",
	bg_float       = "#081230",
	bg_inactive    = "#060e26",
	bg_dim         = "#0c1a42",
	bg_active      = "#142a5e",
	bg_winbar      = "#081230",
	bg_cursorline  = "#0a1638",
	bg_colorcolumn = "#0d1e4a",
	bg_visual      = "#1c3a78", -- mid sapphire selection (bg-only; tokens read through it)

	-- Text
	fg_normal      = "#d6e0f5", -- soft blue-white
	fg             = "#c4d2ec",
	fg_muted       = "#5f6f90",
	fg_dim         = "#93a3c4",
	fg_bright      = "#ecf2ff",

	-- Syntax — blue-anchored core, with warm gold/amber pops
	comment        = "#5f6f90", -- muted blue-gray
	string         = "#f0c25a", -- gold (complementary pop)
	variable       = "#9fc5f0", -- light azure (frequent token)
	keyword        = "#7f8fff", -- periwinkle-violet (punchy, in-family)
	type           = "#a0b0f0", -- light periwinkle
	special        = "#ff9e7a", -- coral (second warm accent)
	preproc        = "#5f9fd9", -- mid blue

	-- Mineral syntax accents
	func           = "#f5a85f", -- amber-orange (functions pop warm)
	module         = "#4fb8e0", -- cyan-azure (bold; in-family elevated)
	key            = "#6fd0d0", -- teal (atoms / map keys)
	constant       = "#c0c8f0", -- light periwinkle

	-- UI accents
	cursor         = "#c0c8f0", -- light periwinkle block cursor (in-family with the blue core)
	accent         = "#2e7fff", -- vivid sapphire (legible as fg on dark)
	match          = "#7fb8ff", -- light blue

	-- Terminal ANSI palette — blue/cyan-anchored, with hand-tuned red and green
	-- (the syntax palette has neither) so :terminal error/success colors read
	-- correctly. Slot 0 lifts to bg_dim.
	ansi = {
		[1] = "#ff7a6a", [2] = "#5fc28f", [3] = "#f0c25a", [4] = "#5f9fd9",
		[5] = "#a87fe0", [6] = "#6fd0d0", [7] = "#c4d2ec", [8] = "#5f6f90",
		[9] = "#ff9e7a", [10] = "#7fd9a8", [11] = "#ffd884", [12] = "#7fb8ff",
		[13] = "#c0a8f0", [14] = "#4fb8e0", [15] = "#ecf2ff",
	},
}
