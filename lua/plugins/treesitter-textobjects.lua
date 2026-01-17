return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'master',
    lazy = true,
    config = function()
        local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
        vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

        -- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

        require('nvim-treesitter-textobjects').setup {
            textobjects = {
                swap = {
                    enable = true,
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']]'] = { query = '@class.outer', desc = 'Next class start' },
                        [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },

                        -- [']i'] = '@conditional.outer',
                        -- [']o'] = '@loop.outer',

                        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
                        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        -- [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[['] = '@class.outer',
                        ['[s'] = { query = '@scope', query_group = 'locals', desc = 'Previous scope' },
                        -- ['[i'] = '@conditional.outer',
                        -- ['[o'] = '@loop.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },

                    -- Below will go to either the start or the end, whichever is closer.
                    -- Use if you want more granular movements
                    -- Make it even more gradual by adding multiple queries and regex.
                    -- goto_next = {
                    --     [']d'] = '@conditional.outer',
                    -- },
                    -- goto_previous = {
                    --     ['[d'] = '@conditional.outer',
                    -- },
                },
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
                        -- You can also use captures from other query groups like `locals.scm`
                        ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
                    },

                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },

                    include_surrounding_whitespace = false,
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true or false
                },
            },
        }
        -- Swap
        vim.keymap.set('n', '<leader>lp', function()
            require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner'
        end)
        vim.keymap.set('n', '<leader>lf', function()
            require('nvim-treesitter-textobjects.swap').swap_next '@function.outer'
        end)
        vim.keymap.set('n', '<leader>Lp', function()
            require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.inner'
        end)
        vim.keymap.set('n', '<leader>Lf', function()
            require('nvim-treesitter-textobjects.swap').swap_previous '@function.outer'
        end)
    end,
}
