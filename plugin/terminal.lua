-- Easily hit escape in terminal mode.
vim.keymap.set('t', '<ESC><ESC>', '<c-\\><c-n>')
-- vim.keymap.set('t', '<c-\\><c-\\>', '<c-\\><c-n>')

local state = {
    window = {
        buf = -1,
        win = -1,
    },
    -- mode = 't',
}

local function create_window(buf)
    local l_buf = nil
    if vim.api.nvim_buf_is_valid(buf) then
        l_buf = buf
    else
        l_buf = vim.api.nvim_create_buf(false, true)
        -- state.mode = 't'
    end

    local win_config = {
        win = -1,
        split = 'below',
        -- height = 15,
        style = 'minimal',
    }
    local l_win = vim.api.nvim_open_win(l_buf, true, win_config)
    vim.cmd.wincmd 'J'
    vim.api.nvim_win_set_height(0, 15)
    vim.wo.winfixheight = true

    return { buf = l_buf, win = l_win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.window.win) then
        state.window = create_window(state.window.buf)
        if vim.bo[state.window.buf].buftype ~= 'terminal' then
            vim.cmd.terminal()
        end

        -- print(state.mode)
        -- if state.mode == 't' then
        vim.cmd.startinsert()
        -- end
    else
        vim.api.nvim_set_current_win(state.window.win)
        -- state.mode = vim.fn.mode()
        vim.api.nvim_win_hide(state.window.win)
    end
end

vim.api.nvim_create_user_command('SplitTerm', function()
    toggle_terminal()
end, {})


-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set({ 'n', 'i', 't' }, '<c-\\>', "<cmd>SplitTerm<CR>", {remap=true})
-- Terminal Maps
-- local set = vim.opt_local
--
-- -- Set local settings for terminal buffers
-- vim.api.nvim_create_autocmd('TermOpen', {
--     group = vim.api.nvim_create_augroup('custom-term-open', {}),
--     callback = function()
--         local bufnr = vim.api.nvim_get_current_buf()
--
--         set.number = false
--         set.relativenumber = false
--         set.scrolloff = 0
--
--         -- When the terminal is open, add a keymap to close it with the same key.
--         vim.keymap.set('n', '<c-,>', ':q<CR>', { buffer = bufnr, remap = false })
--     end,
-- })
