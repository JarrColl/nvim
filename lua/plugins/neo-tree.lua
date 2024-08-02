-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '\\', ':Neotree focus<CR>', { desc = 'NeoTree reveal' } },
    },
    config = function()
        -- vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
        -- vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
        -- vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
        -- vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

        require('neo-tree').setup {
            close_if_last_window = true,
            filesystem = {
                bind_to_cwd = false,
                filtered_items = {
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                },
                window = {
                    -- position = 'current',
                    mappings = {
                        ['\\'] = 'close_window',
                        ['l'] = 'open',
                    },
                },
            },
        }
    end,
}
