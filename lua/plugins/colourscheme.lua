return {
    --TODO: https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
    {
        'rebelot/kanagawa.nvim',
        priority = 999,
        init = function()
            require('kanagawa').setup {
                colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },

                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        -- ### Darker Coloured Completion Menu ###
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },

                        -- ### Floating Windows ###
                        NormalFloat = { bg = 'none' },
                        FloatBorder = { bg = 'none' },
                        FloatTitle = { bg = 'none' },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            }
        end,
    },
    -- { 'rose-pine/neovim', name = 'rose-pine', priority = 999 },
    -- {
    --     'catppuccin/nvim',
    --     name = 'catppuccin',
    --     priority = 999, -- Make sure to load this before all the other start plugins.
    --     lazy = false,
    --     init = function()
    --         -- You can configure highlights by doing something like:
    --         vim.cmd.hi 'Comment gui=none'
    --
    --         require('catppuccin').setup {
    --             integrations = {
    --                 harpoon = true,
    --                 mason = true,
    --                 which_key = true,
    --             },
    --         }
    --     end,
    -- },
    -- {
    --     'zenbones-theme/zenbones.nvim',
    --     -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    --     -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    --     -- In Vim, compat mode is turned on as Lush only works in Neovim.
    --     dependencies = 'rktjmp/lush.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     -- you can set set configuration options here
    --     -- config = function()
    --     --     vim.g.zenbones_darken_comments = 45
    --     --     vim.cmd.colorscheme('zenbones')
    --     -- end
    -- },
}
