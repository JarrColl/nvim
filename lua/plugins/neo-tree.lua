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
        { '<leader>\\', ':Neotree toggle<CR>', { desc = 'NeoTree reveal' } },
    },
    config = function()
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
                        ['<leader>\\'] = 'close_window',
                        ['l'] = 'open',
                    },
                },
            },
        }
    end,
}
