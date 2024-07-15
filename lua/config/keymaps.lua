-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Netrw Keymaps
vim.keymap.set('n', '<leader>sp', function()
    if not pcall(vim.cmd.Rex) then
        vim.cmd.Ex()
    end
end, { desc = 'Open netrw.' })

vim.keymap.set('n', '<leader>sP', vim.cmd.Ex, { desc = 'open return to/from netrw.' })

-- Delete till next word
vim.keymap.set('n', 'X', 'dw')

-- Move within wrapped lines.
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Move selected lines up and down.
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

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
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Quickfix List Keymaps
-- vim.keymap.set('n', '<leader>j', '<cmd>cnext<CR>zz', {desc = 'Move to the next quickfix item'})
-- vim.keymap.set('n', '<leader>k', '<cmd>cprev<CR>zz' {desc = 'Move to the previous quickfix item'})
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz', { desc = 'Move to the next quickfix item' })
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz', { desc = 'Move to the previous quickfix item' })

-- Replace all of selected word.
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Terminal Maps
local set = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', {}),
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        set.number = false
        set.relativenumber = false
        set.scrolloff = 0

        -- When the terminal is open, add a keymap to close it with the same key.
        vim.keymap.set('n', '<c-,>', ':q<CR>', { buffer = bufnr, remap = false })
    end,
})

-- Easily hit escape in terminal mode.
-- vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')
vim.keymap.set('t', '<c-\\><c-\\>', '<c-\\><c-n>')

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set('n', '<c-,>', function()
    vim.cmd.new()
    vim.cmd.wincmd 'J'
    vim.api.nvim_win_set_height(0, 15)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)
