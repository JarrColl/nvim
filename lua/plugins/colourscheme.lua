return {
    --TODO: https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
    -- {'rose-pine/neovim', name = "rose-pine", priority = 999},
    -- { 'folke/tokyonight.nvim', priority = 999 },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 999, -- Make sure to load this before all the other start plugins.
        lazy = false,
        init = function()
            -- vim.cmd.colorscheme 'tokyonight-night'
            -- Load the colorscheme here.
            vim.cmd.colorscheme 'catppuccin-mocha'

            -- You can configure highlights by doing something like:
            vim.cmd.hi 'Comment gui=none'

            require('catppuccin').setup {
                integrations = {
                    harpoon = true,
                    mason = true,
                    which_key = true,
                },
            }
        end,
    },
}
