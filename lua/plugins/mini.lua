return { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        -- local mini_files = require 'mini.files'
        -- mini_files.setup {
        --     mappings = {
        --         close = '\\',
        --         go_in = 'L',
        --         go_in_plus = '<CR>',
        --         go_out = 'H',
        --         go_out_plus = '<c-H>',
        --         reset = '<BS>',
        --         reveal_cwd = '@',
        --         show_help = 'g?',
        --         synchronize = '=',
        --         trim_left = '<',
        --         trim_right = '>',
        --     },
        -- }
        -- vim.keymap.set('n', '\\', mini_files.open)
        -- vim.keymap.set('n', '|', function()
        --     mini_files.open(vim.api.nvim_buf_get_name(0))
        --     mini_files.reveal_cwd()
        -- end)

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require 'mini.statusline'
        -- set use_icons to true if you have a Nerd Font
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return '%2l:%-2v'
        end

        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}
