return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'python' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<C-space>',
                node_incremental = '<C-space>',
                scope_incremental = false,
                node_decremental = '<C-bs>',
            },
        },
    },
    config = function(_, opts)
        -- Prefer git instead of curl in order to improve connectivity in some environments
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)
        --
        -- require('nvim-treesitter.configs').setup({
        --
        --
        -- })
    end,
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                local ts_context = require 'treesitter-context'
                ts_context.setup {
                    max_lines = 1,
                }

                vim.keymap.set('n', '[c', function()
                    ts_context.go_to_context(vim.v.count1)
                end, { silent = true })
            end,
        },
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
}
