return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
        -- Stop built-in ftplugins (python, rust, ...) from claiming ]] [[ ]m etc.
        vim.g.no_plugin_maps = true
    end,
    config = function()
        require('nvim-treesitter-textobjects').setup {
            select = {
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                    ['@class.outer'] = '<c-v>', -- blockwise
                },
                include_surrounding_whitespace = false,
            },
            move = {
                set_jumps = true,
            },
        }

        local move = require 'nvim-treesitter-textobjects.move'
        local select = require 'nvim-treesitter-textobjects.select'
        local swap = require 'nvim-treesitter-textobjects.swap'
        local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

        local function map_move(lhs, fn, query, group, desc)
            vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
                move[fn](query, group or 'textobjects')
            end, { desc = desc })
        end
        map_move(']f', 'goto_next_start', '@function.outer', nil, 'Next function start')
        map_move(']]', 'goto_next_start', '@class.outer', nil, 'Next class start')
        map_move(']s', 'goto_next_start', '@local.scope', 'locals', 'Next scope')
        map_move(']F', 'goto_next_end', '@function.outer', nil, 'Next function end')
        map_move('][', 'goto_next_end', '@class.outer', nil, 'Next class end')
        map_move('[f', 'goto_previous_start', '@function.outer', nil, 'Previous function start')
        map_move('[[', 'goto_previous_start', '@class.outer', nil, 'Previous class start')
        map_move('[s', 'goto_previous_start', '@local.scope', 'locals', 'Previous scope')
        map_move('[F', 'goto_previous_end', '@function.outer', nil, 'Previous function end')
        map_move('[]', 'goto_previous_end', '@class.outer', nil, 'Previous class end')

        local function map_select(lhs, query, group, desc)
            vim.keymap.set({ 'x', 'o' }, lhs, function()
                select.select_textobject(query, group or 'textobjects')
            end, { desc = desc })
        end
        map_select('af', '@function.outer', nil, 'Select outer function')
        map_select('if', '@function.inner', nil, 'Select inner function')
        map_select('ac', '@class.outer', nil, 'Select outer class')
        map_select('ic', '@class.inner', nil, 'Select inner class')
        map_select('as', '@local.scope', 'locals', 'Select language scope')

        vim.keymap.set('n', '<leader>lp', function()
            swap.swap_next '@parameter.inner'
        end, { desc = 'Swap parameter with next' })
        vim.keymap.set('n', '<leader>lf', function()
            swap.swap_next '@function.outer'
        end, { desc = 'Swap function with next' })
        vim.keymap.set('n', '<leader>Lp', function()
            swap.swap_previous '@parameter.inner'
        end, { desc = 'Swap parameter with previous' })
        vim.keymap.set('n', '<leader>Lf', function()
            swap.swap_previous '@function.outer'
        end, { desc = 'Swap function with previous' })

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
        vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

        -- Make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
