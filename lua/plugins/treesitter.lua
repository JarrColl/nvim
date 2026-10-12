return { -- highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
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
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    },

    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    -- [[ configure treesitter ]] see `:help nvim-treesitter-intro`
    config = function()
        vim.filetype.add {
            extension = {
                container = 'systemd',
                service = 'systemd',
                mount = 'systemd',
                automount = 'systemd',
                network = 'systemd',
                inc = 'bitbake',
            },
        }
        vim.treesitter.language.register('ini', 'systemd')

        -- ensure basic parser are installed
        local parsers = {
            'python',
            'bash',
            'c',
            'diff',
            'html',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'vimdoc',
            'vue',
            'css',
            'scss',
            'typescript',
            'javascript',
            'ini',
        }
        require('nvim-treesitter').install(parsers)

        ---@param buf integer
        ---@param language string
        local function treesitter_try_attach(buf, language)
            -- check if parser exists and load it
            if not vim.treesitter.language.add(language) then
                return
            end
            -- enables syntax highlighting and other treesitter features
            vim.treesitter.start(buf, language)

            -- enables treesitter based folds
            -- for more info on folds see `:help folds`
            -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- vim.wo[0][0].foldmethod = 'expr'
            -- vim.wo[0][0].foldlevel = 99 -- Start with all folds open

            -- enables treesitter based indentation
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        local available_parsers = require('nvim-treesitter').get_available()
        vim.api.nvim_create_autocmd('filetype', {
            callback = function(args)
                local buf, filetype = args.buf, args.match

                local language = vim.treesitter.language.get_lang(filetype)
                if not language then
                    return
                end

                local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

                if vim.tbl_contains(installed_parsers, language) then
                    -- enable the parser if it is installed
                    treesitter_try_attach(buf, language)
                elseif vim.tbl_contains(available_parsers, language) then
                    -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
                    require('nvim-treesitter').install(language):await(function()
                        treesitter_try_attach(buf, language)
                    end)
                else
                    -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                    treesitter_try_attach(buf, language)
                end
            end,
        })
    end,
}
