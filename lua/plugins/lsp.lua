return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { 'mason-org/mason.nvim', opts = {} }, -- NOTE: Must be loaded before dependants
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        { 'j-hui/fidget.nvim', opts = {} },
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`

        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                -- map('<leader>hr', vim.lsp.buf.document_highlight, '[H]ighlight [R]eference')

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap.
                map('K', vim.lsp.buf.hover, 'Hover Documentation')

                -- vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { buffer = event.buf, desc = 'LSP: ' .. 'Show signature in insert mode' })
                vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: ' .. 'Show signature in insert mode' })
                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                -- The following autocommand is used to enable inlay hints in your
                -- code, if the language server you are using supports them.
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local server_configs = {
            basedpyright = {
                settings = {
                    basedpyright = {
                        typeCheckingMode = 'standard',
                    },
                },
            },
            ltex = {
                settings = {
                    ltex = {
                        language = 'en-AU',
                    },
                },
            },
            grammarly = {
                filetypes = { 'text', 'tex', 'latex' },
            },
            clangd = {
                cmd = {
                    'clangd',
                    '--clang-tidy',
                    '--header-insertion=iwyu',
                    '--enable-config',
                    '--completion-style=detailed',
                    '--all-scopes-completion',
                    '-j=2',
                    '--fallback-style=WebKit',
                },
            },
            -- Special Lua Config, as recommended by neovim help docs
            lua_ls = {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = { 'lua/?.lua', 'lua/?/init.lua' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                                '${3rd}/luv/library',
                                '${3rd}/busted/library',
                            }),
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            },
            vtsls = {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                                    languages = { 'vue' },
                                },
                            },
                        },
                    },
                },
            },
            arduino_language_server = {
                settings = {
                    arduino = {
                        cli_path = '/usr/local/bin/arduino-cli', -- Make sure this is correct
                        config_path = '/home/jarron/.arduino15/arduino-cli.yaml',
                    },
                },
            },
        }

        for server_name, server_config in pairs(server_configs) do
            vim.lsp.config(server_name, server_config)
            vim.lsp.enable(server_name)
        end

        require('mason').setup {
            registries = {
                'github:mason-org/mason-registry',
                'github:Crashdummyy/mason-registry',
            },
        }

        local ensure_installed = {
            -- Language Servers.
            'basedpyright',
            'lua_ls',

            -- Formatters & Tools.
            'stylua',
            'prettierd',
            'black',
            'isort',
        }
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            ensure_installed = {},
        }
    end,
}
