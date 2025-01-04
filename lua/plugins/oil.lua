return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    config = function()
        require('oil').setup {
            columns = { 'icon' },
            keymaps = {
                ['L'] = 'actions.select',
                ['H'] = 'actions.parent',
                ['gd'] = {
                    desc = 'Toggle file detail view',
                    callback = function()
                        detail = not detail
                        if detail then
                            require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
                        else
                            require('oil').set_columns { 'icon' }
                        end
                    end,
                },
                ['\\'] = { 'actions.close', mode = 'n' },
            },
        }
        -- Open parent directory in current window
        vim.keymap.set('n', '\\', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

        -- Open parent directory in floating window
        vim.keymap.set('n', '<space>\\', require('oil').toggle_float)
    end,
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
