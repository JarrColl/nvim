-- TODO: Update to vim.pack the built in package manager. (also vim.loader.enable with this)
-- nvim autocomplete option built in, investigate it. Or stick with blink.cmp
-- Keep an eye on the ui2 improved interface.
-- v_an and v_in new commands, investigate.
-- look into treesitter folds feature.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'

require 'config.autocmd'

require 'config.diagnostics'

require 'config.lazyInit'
require 'config.commands'

require 'config.colourscheme'
