vim.api.nvim_create_user_command('TextMode', function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en"
    vim.opt_local.textwidth = 100
    vim.opt_local.colorcolumn = "100"

    -- Move within wrapped lines.
    vim.keymap.set('n', 'j', 'gj', {buffer = true})
    vim.keymap.set('n', 'k', 'gk', {buffer = true})
end, {})
