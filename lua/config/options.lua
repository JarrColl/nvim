-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

vim.o.mouse = 'a'

-- Turn off insert comment on new line.
-- vim.cmd "set formatoptions-=cro"
-- vim.opt.formatoptions:remove "c"
-- vim.opt.formatoptions:remove "r"
-- -vim.opt.formatoptions:remove "o"

-- ########### Indentation
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
-- vim.opt.autoindent = true
vim.o.smartindent = true

-- # Files
vim.o.swapfile = false -- Replace swap files with undo history
vim.o.backup = false

vim.o.undofile = true -- Save undo history
vim.o.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.o.autoread = true -- If a file has changed and there are no unsaved changes, auto read it without a warning.

-- # Search Settings
vim.o.ignorecase = true -- Case-insensitive searching
vim.o.smartcase = true -- UNLESS \C or one or more capital letters in the search term.
vim.opt.hlsearch = true -- Highlight all search results. These are on by default.
vim.opt.incsearch = true

-- # Visual Settings
vim.o.termguicolors = true
vim.o.signcolumn = 'yes'
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true
