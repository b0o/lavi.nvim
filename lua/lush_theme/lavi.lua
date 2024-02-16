--# selene: allow(undefined_variable)
---@diagnostic disable: undefined-global
local lush = require("lush")
local palette = require'lavi.palette'

local p = palette

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    ---- General highlight groups
    ColorColumn      { bg = p.black }, -- Columns set with 'colorcolumn'
    Conceal          { fg = p.green, bg = p.bg_med }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor           { bg = p.fg }, -- Character under the cursor
    -- CurSearch        { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- lCursor          { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM         { }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorColumn     { bg = p.black }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine       { bg = p.bg_med }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorLineNC     { bg = p.bg.lighten(6) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory        { fg = p.violet_bright.lighten(50).desaturate(10) }, -- Directory names (and other special names in listings)
    DiffAdd          { bg = p.black, fg = p.green.lighten(10) }, -- Diff mode: Added line |diff.txt|
    DiffChange       { bg = p.black, fg = p.yellow.lighten(10)  }, -- Diff mode: Changed line |diff.txt|
    DiffDelete       { bg = p.black, fg = p.red_bright.lighten(10)  }, -- Diff mode: Deleted line |diff.txt|
    DiffText         { bg = p.black, fg = p.oceanblue.lighten(10)  }, -- Diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer      { fg = p.black }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor       { }, -- Cursor in a focused terminal
    TermCursorNC     { bg = p.black }, -- Cursor in an unfocused terminal
    ErrorMsg         { fg = p.white_bright, bg = p.red_bright }, -- Error messages on the command line
    WinSeparator     { fg = p.black_med }, -- Column separating vertically split windows
    VertSplit        { WinSeparator },
    Folded           { fg = p.black_bright, bg = p.black, gui = 'bold' }, -- Line used for closed folds
    FoldColumn       { fg = p.black_bright }, -- 'foldcolumn'
    SignColumn       { fg = p.black }, -- Column where |signs| are displayed
    IncSearch        { fg = p.white_bright, bg = p.violet, gui = 'underline' }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute       { }, -- |:substitute| replacement text highlighting
    LineNr           { fg = p.black_bright }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove      { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    -- LineNrBelow      { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr     { fg = p.fg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineNrNC   { fg = p.fg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line in non-current windows.
    -- CursorLineFold   { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    -- CursorLineSign   { }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen       { bg = p.cyan, fg = p.black }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg          { fg = p.fg }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea          { }, -- Area for messages and cmdline
    -- MsgSeparator     { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg          { fg = p.fg }, -- |more-prompt|
    NonText          { fg = p.black_med }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal           { fg = p.fg, bg = p.bg }, -- Normal text
    NormalNC         { fg = p.fg, bg = p.bg_dark }, -- normal text in non-current windows
    NormalFloat      { fg = p.fg, bg = p.bg }, -- Normal text in floating windows.
    NormalFloatNC    { fg = p.fg, bg = p.bg_dark }, -- Normal text in non-current floating windows.
    FloatBorder      { fg = p.black_med }, -- Border of floating windows.
    -- FloatTitle       { }, -- Title of floating windows.
    Pmenu            { fg = p.fg, bg = p.bg.lighten(30) }, -- Popup menu: Normal item.
    PmenuSel         { fg = p.cyan, bg = p.black_bright }, -- Popup menu: Selected item.
    -- PmenuKind        { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel     { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra       { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel    { }, -- Popup menu: Selected item "extra text"
    PmenuSbar        { fg = p.fg, bg = p.bg.lighten(30) }, -- Popup menu: Scrollbar.
    PmenuThumb       { fg = p.violet.lighten(70).saturate(90), bg = p.bg.lighten(50) }, -- Popup menu: Thumb of the scrollbar.
    Question         { fg = p.fg }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine     { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search           { fg = p.black, bg = p.skyblue }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    SpecialKey       { fg = p.black_bright }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad         { gui = 'undercurl' }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap         { gui = 'undercurl' }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal       { gui = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare        { gui = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine       { }, -- Status line of current window
    StatusLineNC     { StatusLine }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    StatusLineTerm   { StatusLine }, -- Status line of current window
    StatusLineTermNC { StatusLineNC }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- StatusLine       { fg = g.cyan, bg = p.black_bright }, -- Status line of current window
    -- StatusLineNC     { fg = g.fg, bg = p.black_bright }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- StatusLineTerm   { fg = g.cyan, bg = p.black_bright }, -- Status line of current window
    -- StatusLineTermNC { fg = g.fg, bg = p.black_bright }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine          { fg = p.fg, bg = p.black }, -- Tab pages line, not active tab page label
    TabLineFill      { fg = p.fg, bg = p.black }, -- Tab pages line, where there are no labels
    TabLineSel       { fg = p.cyan, bg = p.black_bright }, -- Tab pages line, active tab page label
    Title            { fg = p.fg }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual           { bg = p.bg.lighten(30) }, -- Visual mode selection
    VisualNOS        { bg = p.black_med }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg       { fg = p.black, bg = p.yellow }, -- Warning messages
    -- Whitespace       { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- Winseparator     { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu         { fg = p.cyan, bg = p.black }, -- Current match in 'wildmenu' completion
    -- WinBar           { }, -- Window bar of current window
    -- WinBarNC         { }, -- Window bar of not-current windows

    ---- Standard syntax highlighting
    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment          { fg = p.anise_dark, gui = 'italic,bold' }, -- Any comment

    Constant         { fg = p.cyan }, -- (*) Any constant
    String           { fg = p.yellow.lighten(40).rotate(50).saturate(10) }, --   A string constant: "this is a string"
    Character        { String }, --   A character constant: 'c', '\n'
    Number           { fg = p.pumpkin }, --   A number constant: 234, 0xff
    Float            { Number }, --   A floating point constant: 2.3e10
    Boolean          { fg = p.cyan.lighten(30) }, --   A boolean constant: TRUE, false

    Identifier       { fg = p.anise.lighten(85).saturate(100) }, -- (*) Any variable name
    Function         { fg = p.cyan.desaturate(10).lighten(50) }, --   Function name (also: methods for classes)

    Statement        { fg = p.velvet.rotate(5).lighten(10) }, -- (*) Any statement
    Conditional      { Statement }, --   if, then, else, endif, switch, etc.
    Repeat           { Statement }, --   for, do, while, etc.
    Label            { Statement }, --   case, default, etc.
    Operator         { Statement }, --   "sizeof", "+", "*", etc.
    Keyword          { Statement }, --   any other keyword
    Exception        { Statement }, --   try, catch, throw

    PreProc          { Statement }, -- (*) Generic Preprocessor
    Include          { PreProc }, --   Preprocessor #include
    Define           { PreProc }, --   Preprocessor #define
    Macro            { PreProc }, --   Same as Define
    PreCondit        { PreProc }, --   Preprocessor #if, #else, #endif, etc.

    Type             {  fg = p.violet.rotate(-55) }, -- (*) int, long, char, etc.
    StorageClass     { Type }, --   static, register, volatile, etc.
    Structure        { Type }, --   struct, union, enum, etc.
    Typedef          { Type }, --   A typedef

    Special          { Identifier }, -- (*) Any special symbol
    SpecialChar      { fg = p.orange }, --   Special character in a constant
    Tag              { fg = p.dust }, --   You can use CTRL-] on this
    Delimiter        { fg = p.deep_velvet.lighten(40).saturate(30) }, --   Character that needs attention
    SpecialComment   { fg = p.fg }, --   Special things inside a comment (e.g. '\n')
    -- Debug            { }, --   Debugging statements

    -- Underlined       { gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore           { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error            { fg = p.bg_bright, bg = p.red_bright }, -- Any erroneous construct
    Todo             { fg = p.yellow }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    ---- LSP
    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
    LspInlayHint                { Comment }, -- Used for inline hint virtual text

    ---- Diagnostics
    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    ---- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    sym"@text.diff.add"     { DiffAdd }, -- tree-sitter-diff Add
    sym"@text.diff.delete"  { DiffDelete }, -- tree-sitter-diff Delete
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag

    ------ Generic Groups
    ActivePopupBorder         { fg = p.anise.desaturate(60).darken(20) },

    ------ Plugin Support
    ---- gitsigns.nvim
    GitSignsAdd               { fg = p.green },
    GitSignsChange            { fg = p.yellow },
    GitSignsDelete            { fg = p.red_bright },

    ---- Neogit
    NeogitCursorLine          { gui = "nocombine" },
    NeogitDiffAdd             { fg = p.green.desaturate(40).lighten(20) },
    NeogitDiffAddHighlight    { fg = p.green.lighten(10) },
    NeogitDiffDelete          { fg = p.red_bright.desaturate(40).lighten(20) },
    NeogitDiffDeleteHighlight { fg = p.red_bright.lighten(10) },

    ---- nvim-tree.lua
    NvimTreeGitDirty          { GitSignsChange },
    NvimTreeGitStaged         { NeogitDiffAddHighlight },
    NvimTreeGitMerge          { fg = p.violet_bright },
    NvimTreeGitRenamed        { fg = p.orange },
    NvimTreeGitNew            { NeogitDiffAdd },
    NvimTreeGitDeleted        { NeogitDiffDeleteHighlight },
    NvimTreeIndentMarker      { fg = p.black_bright },
    NvimTreeNormal            { fg = p.violet_bright.lighten(50).desaturate(10) },
    NvimTreeNormalNC          { fg = p.violet_bright.lighten(50).desaturate(10) },
    NvimTreeFolderName        { fg = p.violet_bright.lighten(30).desaturate(10) },
    NvimTreeEmptyFolderName   { NvimTreeFolderName },
    NvimTreeOpenedHL          { fg = p.white_bright },
    NvimTreeExecFile          { gui = 'bold,italic' },
    NvimTreeSpecialFile       { gui = 'bold' },

    -- noice.nvim
    NoiceCmdlinePopupBorder   { ActivePopupBorder },
    NoiceCmdlinePopupTitle    { fg = p.anise.desaturate(50).lighten(40) },
    NoiceCmdlineIcon          { NoiceCmdlinePopupTitle },

    ---- nvim-cmp
    CmpNormal                 { Normal },
    -- CmpNormal                 { fg = p.fg, bg = p.bg.lighten(10) },
    CmpBorder                 { ActivePopupBorder },
    CmpSel                    { bg = p.bg.saturate(15).lighten(50), fg = p.white_bright, gui = 'bold' },

    CmpItemMenu               { fg = p.dust, gui = "italic" },
    CmpItemAbbr               { fg = p.fg },
    CmpItemAbbrMatch          { fg = p.blush },
    CmpItemAbbrMatchFuzzy     { fg = p.blush },

    CmpItemAbbrDeprecated     { fg = p.cayenne, gui = "strikethrough" },

    CmpItemKind               { fg = p.white_bright },

    CmpItemKindMethod         { bg = p.velvet.darken(5), fg = p.white_bright },
    CmpItemKindConstructor    { CmpItemKindMethod },
    CmpItemKindFunction       { CmpItemKindMethod },

    CmpItemKindVariable       { bg = p.blush.darken(5), fg = p.white_bright },
    CmpItemKindConstant       { CmpItemKindVariable },
    CmpItemKindValue          { CmpItemKindVariable },
    CmpItemKindField          { CmpItemKindVariable },
    CmpItemKindProperty       { CmpItemKindVariable },
    CmpItemKindEnumMember     { CmpItemKindVariable },
    CmpItemKindReference      { CmpItemKindVariable },

    CmpItemKindOperator       { bg = p.matcha.darken(5), fg = p.white_bright },
    CmpItemKindKeyword        { CmpItemKindOperator },
    CmpItemKindTypeParameter  { CmpItemKindOperator },

    CmpItemKindModule         { bg = p.yellow.darken(5), fg = p.white_bright },
    CmpItemKindClass          { CmpItemKindModule },
    CmpItemKindInterface      { CmpItemKindModule },
    CmpItemKindStruct         { CmpItemKindModule },
    CmpItemKindEnum           { CmpItemKindModule },

    CmpItemKindEvent          { bg = p.light_lavender.darken(5), fg = p.white_bright },
    CmpItemKindUnit           { CmpItemKindEvent },
    CmpItemKindFile           { CmpItemKindEvent },
    CmpItemKindFolder         { CmpItemKindEvent },

    CmpItemKindText           { bg = p.anise.darken(5), fg = p.white_bright },

    CmpItemKindSnippet        { bg = p.violet, fg = p.white_bright },
    CmpItemKindColor          { bg = p.mint.darken(0), fg = p.white_bright },

    ---- flash.nvim
    FlashBackdrop             { bg = p.bg.lighten(5) },
    FlashMatch                { bg = p.velvet.darken(10), fg = p.white },
    FlashCurrent              { bg = p.blush, fg = p.bg_med },
    FlashLabel                { bg = p.yellow, fg = p.bg_med },
    FlashPrompt               { bg = p.violet_med, fg = p.white },
    FlashPromptIcon           { bg = p.violet_med, fg = p.white },
    FlashCursor               { bg = p.skyblue, fg = p.bg_med },

    ---- nvim-treesitter-context
    TreesitterContext         { bg = p.bg.lighten(15).desaturate(5) },
    TreesitterContextLineNumber { fg = p.black_bright.lighten(10), bg = p.bg.lighten(5) },
    -- TreesitterContextSeparator {},
    -- TreesitterContextBottom    {},

    ---- twoslash-queries.nvim
    TypeVirtualText           { fg = p.blue.lighten(30), bg = p.bg.lighten(15).desaturate(5) },

    ---- aerial.nvim
    AerialLine                { bg = p.bg.lighten(40) },
    AerialLineNC              { bg = p.bg.lighten(20) },
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
