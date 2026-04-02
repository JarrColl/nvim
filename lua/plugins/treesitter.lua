if vim.fn.has 'nvim-0.12' == 1 then
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
                    container = 'toml',
                    service = 'toml',
                    mount = 'toml',
                    automount = 'toml',
                    network = 'toml',
                },
            }

            -- ensure basic parser are installed
            local parsers = { 'python', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
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
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'
                -- vim.wo.foldlevel = 99 -- Start with all folds open
                -- vim.wo.foldlevelstart = 99

                -- enables treesitter based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
else -- Legacy treesitter
    return { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        branch = 'master',
        opts = {
            ensure_installed = { 'python', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
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
                    node_decremental = '<C-A-Space>',
                },
            },
        },
        config = function(_, opts)
            -- Prefer git instead of curl in order to improve connectivity in some environments
            require('nvim-treesitter.install').prefer_git = true
            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup(opts)

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
end
