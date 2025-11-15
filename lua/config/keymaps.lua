-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--  Keymaps to remember
--  : -> ctrl-f
--  q -> :

-- Netrw Keymaps
vim.keymap.set('n', '<leader>sp', function()
    if not pcall(vim.cmd.Rex) then
        vim.cmd.Ex()
    end
end, { desc = 'Open netrw.' })

vim.keymap.set('n', '<leader>sP', vim.cmd.Ex, { desc = 'open return to/from netrw.' })

-- Delete till next word
vim.keymap.set('n', 'X', 'dw')

-- Search and replace selected text.
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//g<left><left>')

-- Move selected lines up and down.
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Copy to & Paste from os clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')

-- Delete to the void
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- Exit insert mode easily with jk pressed quickly in succession.
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'JK', '<Esc>')
vim.keymap.set('i', 'Jk', '<Esc>')
vim.keymap.set('i', 'jK', '<Esc>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--TODO: set this up then uncomment
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to previous [D]iagnostic message' })

vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' }) --NOTE: previously used setloclist, ensure it isn't broken.

-- Quickfix List Keymaps
-- vim.keymap.set('n', '<leader>j', '<cmd>cnext<CR>zz', {desc = 'Move to the next quickfix item'})
-- vim.keymap.set('n', '<leader>k', '<cmd>cprev<CR>zz' {desc = 'Move to the previous quickfix item'})
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz', { desc = 'Move to the next quickfix item' })
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz', { desc = 'Move to the previous quickfix item' })

-- Replace all of selected word.
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Keybinds to make split navigation easier.
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
