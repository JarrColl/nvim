-- kanagawa-minimal (standalone): kanagawa-wave palette, minimal highlighting
-- after https://tonsky.me/blog/syntax-highlighting/
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "kanagawa-minimal"

-- Slots mirror wave in kanagawa/themes.lua
local c = {
    -- ui
    fg = "#DCD7BA",         -- fujiWhite
    fg_dim = "#C8C093",     -- oldWhite
    fg_reverse = "#223249", -- waveBlue1
    bg_m3 = "#16161D",      -- sumiInk0
    bg = "#1F1F28",         -- sumiInk3
    bg_p1 = "#2A2A37",      -- sumiInk4 (colorcolumn, folds, gutter)
    bg_p2 = "#363646",      -- sumiInk5 (cursorline, selected tab)
    bg_gutter = "#2A2A37",  -- sumiInk4 (set to c.bg for a flat gutter)
    special = "#938AA9",    -- springViolet1
    nontext = "#54546D",    -- sumiInk6
    bg_search = "#2D4F67",  -- waveBlue2
    bg_visual = "#223249",  -- waveBlue1
    pmenu_bg = "#223249", pmenu_sel = "#2D4F67",
    float_fg = "#C8C093", float_bg = "#16161D", float_border = "#54546D",

    -- syntax (the only places hues are used)
    dim = "#938AA9", -- springViolet1  punctuation
    lit = "#98BB6C", -- springGreen    strings, numbers, constants
    cmt = "#E6C384", -- carpYellow     comments
    def_fn  = "#7FB4CA", -- springBlue   function/type declarations (brighter)
    def = "#7E9CD8", -- crystalBlue    definitions

    -- functional colours (never used for syntax)
    err = "#E82424", warn = "#FF9E3B", info = "#658594", hint = "#6A9589", ok = "#98BB6C",
    vcs_add = "#76946A", vcs_del = "#C34043", vcs_chg = "#DCA561",
    diff_add = "#2B3328", diff_del = "#43242B", diff_chg = "#252535", diff_text = "#49443C",
}

local plain = { fg = c.fg }
local fn_def = { fg = c.def_fn }
local definition = { fg = c.def }

local groups = {
    -- ===== UI =====
    Normal = { fg = c.fg, bg = c.bg },
    NormalNC = { fg = c.fg, bg = c.bg },
    NormalFloat = { fg = c.float_fg, bg = c.float_bg },
    FloatBorder = { fg = c.float_border, bg = c.float_bg },
    FloatTitle = { fg = c.special, bg = c.float_bg, bold = true },
    Cursor = { fg = c.bg, bg = c.fg },
    lCursor = { link = "Cursor" },
    TermCursor = { reverse = true },
    CursorLine = { bg = c.bg_p2 },
    CursorColumn = { bg = c.bg_p2 },
    ColorColumn = { bg = c.bg_p1 },
    CursorLineNr = { fg = c.warn, bold = true },
    LineNr = { fg = c.nontext, bg = c.bg },
    SignColumn = { fg = c.nontext, bg = c.bg },
    FoldColumn = { fg = c.nontext, bg = c.bg },
    Folded = { fg = c.dim, bg = c.bg_p1 },
    Visual = { bg = c.bg_visual },
    VisualNOS = { bg = c.bg_visual },
    Search = { fg = c.fg, bg = c.bg_search },
    IncSearch = { fg = c.fg_reverse, bg = c.warn },
    CurSearch = { link = "IncSearch" },
    Substitute = { fg = c.fg, bg = c.vcs_del },
    MatchParen = { fg = c.warn, bold = true },
    Pmenu = { fg = c.fg, bg = c.pmenu_bg },
    PmenuSel = { bg = c.pmenu_sel },
    PmenuSbar = { bg = c.pmenu_bg },
    PmenuThumb = { bg = c.pmenu_sel },
    WildMenu = { link = "PmenuSel" },
    StatusLine = { fg = c.fg_dim, bg = c.bg_m3 },
    StatusLineNC = { fg = c.nontext, bg = c.bg_m3 },
    WinBar = { fg = c.fg_dim },
    WinBarNC = { fg = c.nontext },
    WinSeparator = { fg = c.bg_m3 },
    VertSplit = { link = "WinSeparator" },
    TabLine = { fg = c.special, bg = c.bg_m3 },
    TabLineSel = { fg = c.dim, bg = c.bg_p2 },
    TabLineFill = { bg = c.bg },
    NonText = { fg = c.nontext },
    EndOfBuffer = { fg = c.bg },
    Whitespace = { fg = c.nontext },
    SpecialKey = { fg = c.special },
    Conceal = { fg = c.special, bold = true },
    Directory = { fg = c.def },
    Title = { fg = c.def, bold = true },
    ErrorMsg = { fg = c.err },
    WarningMsg = { fg = c.warn },
    MoreMsg = { fg = c.info },
    Question = { link = "MoreMsg" },
    ModeMsg = { fg = c.warn, bold = true },
    SpellBad = { undercurl = true, sp = c.err },
    SpellCap = { undercurl = true, sp = c.warn },
    SpellLocal = { undercurl = true, sp = c.info },
    SpellRare = { undercurl = true, sp = c.hint },

    -- ===== Diff / git =====
    DiffAdd = { bg = c.diff_add },
    DiffChange = { bg = c.diff_chg },
    DiffDelete = { bg = c.diff_del },
    DiffText = { bg = c.diff_text },
    Added = { fg = c.vcs_add },
    Changed = { fg = c.vcs_chg },
    Removed = { fg = c.vcs_del },
    GitSignsAdd = { fg = c.vcs_add },
    GitSignsChange = { fg = c.vcs_chg },
    GitSignsDelete = { fg = c.vcs_del },

    -- ===== Diagnostics =====
    DiagnosticError = { fg = c.err },
    DiagnosticWarn = { fg = c.warn },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },
    DiagnosticOk = { fg = c.ok },
    DiagnosticVirtualTextError = { fg = c.err },
    DiagnosticVirtualTextWarn = { fg = c.warn },
    DiagnosticVirtualTextInfo = { fg = c.info },
    DiagnosticVirtualTextHint = { fg = c.hint },
    DiagnosticUnderlineError = { undercurl = true, sp = c.err },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warn },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },
    DiagnosticDeprecated = { strikethrough = true, sp = c.err },
    LspReferenceText = { bg = c.bg_p2 },
    LspReferenceRead = { bg = c.bg_p2 },
    LspReferenceWrite = { bg = c.bg_p2 },

    -- ===== Classic syntax: highlighted =====
    Comment = { fg = c.cmt },
    SpecialComment = { fg = c.cmt },
    Constant = { fg = c.lit },
    String = { fg = c.lit },
    Character = { fg = c.lit },
    Number = { fg = c.lit },
    Float = { fg = c.lit },
    Boolean = { fg = c.lit },
    SpecialChar = { fg = c.lit },

    -- ===== Classic syntax: plain =====
    Function = plain, Identifier = plain, Statement = plain,
    Conditional = plain, Repeat = plain, Label = plain, Operator = plain,
    Keyword = plain, Exception = plain, PreProc = plain, Include = plain,
    Define = plain, Macro = plain, PreCondit = plain, Type = plain,
    StorageClass = plain, Structure = plain, Typedef = plain,
    Special = plain, Tag = plain, Debug = plain,
    Delimiter = { fg = c.dim },
    Underlined = { fg = c.def, underline = true },
    Ignore = { fg = c.nontext },
    Error = { fg = c.err },
    Todo = { fg = c.bg_m3, bg = c.info },

    -- ===== Treesitter =====
    ["@function"] = fn_def,
    ["@function.method"] = fn_def,
    ["@function.call"] = plain,
    ["@function.method.call"] = plain,
    ["@function.builtin"] = plain,
    ["@constructor"] = plain,
    ["@variable"] = plain,
    ["@variable.builtin"] = plain,
    ["@module.builtin"] = plain,
    ["@constant.builtin"] = { fg = c.lit },
    ["@punctuation.special"] = { fg = c.dim },
    ["@markup.heading"] = { fg = c.def },
    ["@markup.link.url"] = { fg = c.dim, underline = true },

    -- ===== LSP semantic tokens =====
    ["@lsp.type.function"] = plain,
    ["@lsp.type.method"] = plain,
    ["@lsp.typemod.function.declaration"] = fn_def,
    ["@lsp.typemod.function.definition"] = fn_def,
    ["@lsp.typemod.method.declaration"] = fn_def,
    ["@lsp.typemod.method.definition"] = fn_def,
    ["@lsp.typemod.class.declaration"] = fn_def,
    ["@lsp.typemod.struct.declaration"] = fn_def,
    ["@lsp.typemod.enum.declaration"] = fn_def,
    ["@lsp.typemod.interface.declaration"] = fn_def,
    ["@lsp.typemod.type.declaration"] = fn_def,

    -- variable declarations (clangd marks declaration sites with this modifier)
    ["@lsp.typemod.variable.declaration"] = definition,
    ["@lsp.typemod.variable.definition"] = definition,
        -- optional: struct/class fields at their declaration
    ["@lsp.typemod.property.declaration"] = definition,
    -- optional: parameters at the function signature
    ["@lsp.typemod.parameter.declaration"] = definition,
}

for name, val in pairs(groups) do
    vim.api.nvim_set_hl(0, name, val)
end

-- Terminal palette: wave `term` list from themes.lua (0-15, then extended 16-17)
local term = {
    "#16161D", "#C34043", "#76946A", "#C0A36E", "#7E9CD8", "#957FB8", "#6A9589", "#C8C093",
    "#727169", "#E82424", "#98BB6C", "#E6C384", "#7FB4CA", "#938AA9", "#7AA89F", "#DCD7BA",
    "#FFA066", "#FF5D62",
}
for i, color in ipairs(term) do
    vim.g["terminal_color_" .. (i - 1)] = color
end
