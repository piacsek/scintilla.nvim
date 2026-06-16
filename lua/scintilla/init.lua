-- scintilla.nvim
-- A family of "deep" colorschemes forked from Neovim's bundled `zaibatsu`, with
-- friendlier popup, statusline, and treesitter/LSP highlighting tuned for
-- everyday TS + Elixir. Each variant (amethyst, ruby, …) supplies its own
-- palette; the highlight logic below is shared across all of them.
--
-- The palette is a full semantic contract — see lua/scintilla/palettes/amethyst.lua
-- for the canonical key list. The core drives the editor base (Normal, syntax,
-- line numbers, cursorline, …) from the palette so each variant fully owns its
-- look rather than inheriting zaibatsu's purple. zaibatsu is still loaded first
-- as a base so the long tail of minor groups has sane defaults.

local M = {}

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- Apply the shared scintilla highlight set on top of zaibatsu, using `p` (a
-- palette table) for colors and registering under colorscheme `name`.
function M.apply(name, p)
	-- Inherit zaibatsu as the base, then layer our overrides on top.
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.cmd.runtime("colors/zaibatsu.vim")
	vim.g.colors_name = name

	-- ── Editor base ─────────────────────────────────────────────────────────
	-- Drive the main surfaces + gutter from the palette so the background tone
	-- follows the variant (zaibatsu hardcodes these to purple).
	hl("Normal", { fg = p.fg_normal, bg = p.bg })
	hl("NormalNC", { link = "Normal" })
	hl("EndOfBuffer", { fg = p.comment, bg = p.bg })
	hl("NonText", { fg = p.fg_muted, bg = p.bg })
	hl("Conceal", { fg = p.fg_muted })
	hl("ColorColumn", { bg = p.bg_colorcolumn })
	hl("CursorLine", { bg = p.bg_cursorline })
	hl("CursorColumn", { bg = p.bg_cursorline })
	hl("CursorLineNr", { link = "CursorLine" }) -- matches zaibatsu's linkage
	hl("LineNr", { fg = p.comment })
	hl("SignColumn", { fg = p.preproc })
	hl("FoldColumn", { fg = p.preproc })
	hl("Folded", { fg = p.func, bg = p.bg_dim })
	hl("WinSeparator", { fg = p.comment })
	hl("VertSplit", { fg = p.comment })
	hl("Directory", { fg = p.variable })
	hl("Cursor", { fg = p.bg, bg = p.cursor or p.string }) -- palettes may override the block color

	-- Selection / search — zaibatsu uses reverse video (purple); set solid
	-- palette colors so they read correctly on any background. fg_visual lets
	-- each variant pick selected-text color: dark on a light selection
	-- (amethyst) or light on a dark one (ruby).
	hl("Visual", { fg = p.fg_visual, bg = p.bg_visual })
	hl("Search", { fg = p.bg, bg = p.variable })
	hl("IncSearch", { fg = p.bg, bg = p.func })
	hl("CurSearch", { link = "IncSearch" })

	-- ── Core syntax ─────────────────────────────────────────────────────────
	-- zaibatsu links String/Number/Boolean/Float→Constant, Function→Identifier,
	-- Keyword→Statement, Typedef→Type, so setting the parents is enough.
	hl("Comment", { fg = p.comment })
	hl("Constant", { fg = p.string })
	hl("Identifier", { fg = p.variable })
	hl("Statement", { fg = p.keyword })
	hl("Type", { fg = p.type })
	hl("Special", { fg = p.special })
	hl("PreProc", { fg = p.preproc })

	-- ── Surfaces zaibatsu leaves bright/white ───────────────────────────────
	-- Statusline: tone down zaibatsu's bright white statusline. Optional
	-- `bg_statusline` lets a variant give the bar its own surface (e.g. diamond's
	-- near-white bar); falls back to bg_active so the other variants are unchanged.
	hl("StatusLine", { fg = p.fg_bright, bg = p.bg_statusline or p.bg_active })
	hl("StatusLineNC", { fg = p.fg_dim, bg = p.bg_dim })

	-- ── Terminal (ANSI) palette ─────────────────────────────────────────────
	-- Drive all 16 g:terminal_color_* from the palette so every variant exposes
	-- a complete, scintilla-owned ANSI set. Previously only slot 0 was set, so
	-- slots 1–15 leaked in from whatever colorscheme loaded before — the wrong
	-- colors inside :terminal, and a palette that anything mirroring
	-- g:terminal_color_* (e.g. ghostty-mirror) can't tell apart from the prior
	-- scheme. Slot 0 (ANSI black) stays lifted to bg_dim so :terminal borders
	-- (lazygit, etc.) keep contrast against the editor background.
	--
	-- The default maps the standard ANSI slots to their closest semantic palette
	-- entries; a palette may override any slot (including for a different cursor
	-- ANSI color) via its `ansi` table — keyed 0–15, partial is fine. Each
	-- shipped variant defines a full `ansi` so its terminal hues stay recognizable
	-- even though the syntax palette is anchored on a single hue family.
	local ansi = {
		[0] = p.bg_dim,    -- black (lifted off bg for visible borders)
		[1] = p.type,      -- red
		[2] = p.special,   -- green
		[3] = p.string,    -- yellow
		[4] = p.preproc,   -- blue
		[5] = p.module,    -- magenta
		[6] = p.key,       -- cyan
		[7] = p.fg,        -- white
		[8] = p.fg_muted,  -- bright black
		[9] = p.keyword,   -- bright red
		[10] = p.func,     -- bright green
		[11] = p.accent,   -- bright yellow
		[12] = p.match,    -- bright blue
		[13] = p.constant, -- bright magenta
		[14] = p.variable, -- bright cyan
		[15] = p.fg_bright, -- bright white
	}
	if p.ansi then
		ansi = vim.tbl_extend("force", ansi, p.ansi)
	end
	for i = 0, 15 do
		vim.g["terminal_color_" .. i] = ansi[i]
	end

	-- Floats (LSP hover, diagnostics, plugin popups, snacks, etc.)
	hl("NormalFloat", { fg = p.fg, bg = p.bg_float })
	hl("FloatBorder", { fg = p.fg_muted, bg = p.bg_float })
	hl("FloatTitle", { fg = p.accent, bg = p.bg_float, bold = true })

	-- Completion popup (LSP, nvim-cmp, blink)
	hl("Pmenu", { fg = p.fg, bg = p.bg_float })
	hl("PmenuSel", { fg = p.accent, bg = p.bg_active, bold = true })
	hl("PmenuKind", { fg = p.fg_muted, bg = p.bg_float })
	hl("PmenuKindSel", { fg = p.fg_muted, bg = p.bg_active })
	hl("PmenuExtra", { fg = p.fg_muted, bg = p.bg_float })
	hl("PmenuExtraSel", { fg = p.fg_muted, bg = p.bg_active })
	hl("PmenuMatch", { fg = p.match, bg = p.bg_float, bold = true })
	hl("PmenuMatchSel", { fg = p.match, bg = p.bg_active, bold = true })
	hl("PmenuSbar", { bg = p.bg_dim })
	hl("PmenuThumb", { bg = p.fg_muted })

	hl("VisualNOS", { fg = p.fg, bg = p.bg_active })
	hl("WildMenu", { fg = p.accent, bg = p.bg_active, bold = true })
	hl("TabLine", { fg = p.fg_dim, bg = p.bg_dim })
	hl("TabLineSel", { fg = p.accent, bg = p.bg_active, bold = true })
	hl("TabLineFill", { bg = p.bg_inactive })
	hl("WinBar", { fg = p.fg, bg = p.bg_winbar })
	hl("WinBarNC", { fg = p.fg_muted, bg = p.bg_inactive })
	hl("MsgArea", { fg = p.fg, bg = p.bg })

	-- Message-area prompts (hit-enter "Press ENTER…", :messages, mode indicator).
	-- zaibatsu's bright cyan/green are tuned for a dark bg and leak through
	-- unreadably on light variants (diamond). Drive them from the palette. The
	-- chosen keys equal zaibatsu's exact MoreMsg/Question/ModeMsg/WarningMsg
	-- colors on amethyst, so amethyst stays byte-identical. (ErrorMsg keeps its
	-- own solid-red backdrop and reads on any bg, so it's left to zaibatsu.)
	hl("MoreMsg", { fg = p.variable })
	hl("Question", { fg = p.special })
	hl("ModeMsg", { fg = p.bg, bg = p.special })
	hl("WarningMsg", { fg = p.keyword })

	-- WhichKey-style overlays (covers folke/which-key.nvim and snacks variants).
	hl("WhichKeyFloat", { bg = p.bg_float })
	hl("WhichKeyBorder", { fg = p.fg_muted, bg = p.bg_float })

	-- MatchParen: zaibatsu uses reverse video which obscures the cursor.
	hl("MatchParen", { fg = p.accent, bg = p.bg_active, bold = true })

	-- ── Treesitter ──────────────────────────────────────────────────────────
	-- Distinguish object keys from value identifiers (JSON, JS/TS, Lua tables, etc.).
	hl("@variable.member", { fg = p.key })
	hl("@property", { fg = p.key })
	-- Elixir atoms / map keys (`:foo`, `%{key: val}`).
	hl("@string.special.symbol", { fg = p.key })

	-- Function/method calls + declarations. Distinct from variables, strings,
	-- keys, keywords. Covers JS/TS + Elixir.
	hl("@function", { fg = p.func })
	hl("@function.call", { fg = p.func })
	hl("@function.method", { fg = p.func })
	hl("@function.method.call", { fg = p.func })

	-- Module / namespace names — bold. Elixir modules, TS classes &
	-- constructors all share this styling.
	hl("@module", { fg = p.module, bold = true })
	hl("@constructor", { fg = p.module, bold = true })

	-- Capitalized JSX component tags (`<Foo/>`). The tsx grammar captures these
	-- as `@tag` (lowercase intrinsic elements like `<div>` get `@tag.builtin`
	-- instead), and `@tag` is the last-applied capture so it wins. Once an LSP
	-- attaches it retags the name via @lsp.type.class/namespace → module; mirror
	-- that here so the color is stable with or without LSP — e.g. in
	-- treesitter-only fzf-lua previews, which otherwise fell back to Tag→Special.
	hl("@tag", { fg = p.module, bold = true })

	-- Elixir constants (module attributes like `@foo`) — kept in the theme's
	-- secondary accent so it doesn't compete with module names.
	hl("@constant.elixir", { fg = p.constant })

	-- ── LSP semantic tokens ─────────────────────────────────────────────────
	-- These override treesitter once the server attaches; keep our colors
	-- stable across pre-/post-LSP transitions.
	hl("@lsp.type.property", { fg = p.key })
	hl("@lsp.type.function", { fg = p.func })
	hl("@lsp.type.method", { fg = p.func })
	hl("@lsp.type.module", { fg = p.module, bold = true })
	hl("@lsp.type.namespace", { fg = p.module, bold = true })
	hl("@lsp.type.class", { fg = p.module, bold = true })
	hl("@lsp.type.enumMember", { link = "@variable.member" })
	hl("@lsp.typemod.enumMember.readonly", { link = "@variable.member" })
end

-- Convenience loader: `require("scintilla").load("amethyst")` loads the palette
-- from `scintilla.palettes.amethyst` and applies it as `scintilla-amethyst`.
function M.load(variant)
	local p = require("scintilla.palettes." .. variant)
	M.apply("scintilla-" .. variant, p)
end

return M
