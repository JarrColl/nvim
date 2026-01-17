return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function(_, opts)
        local treesitter = require 'nvim-treesitter'
        treesitter.setup()
        treesitter.install { 'python', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

        -- Enable Treesitter highlighting.
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '<filetype>' },
            callback = function()
                vim.treesitter.start()
            end,
        })

        -- Enable Treesitter folding.
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'

        -- Enable Treesitter based indentation.
        -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        vim.filetype.add {
            extension = {
                container = 'toml',
                service = 'toml',
                mount = 'toml',
                automount = 'toml',
                network = 'toml',
            },
        }
    end,
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                local ts_context = require 'treesitter-context'
                ts_context.setup {
                    max_lines = 1,
                }

                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    ts_context.go_to_context(vim.v.count1)
                end, { silent = true })
            end,
        },
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
}
