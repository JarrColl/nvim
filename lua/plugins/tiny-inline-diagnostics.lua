--TODO: try lsp_lines plugin with a toggle keybind?
return {
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        -- event = 'LspAttach',
        -- event = 'VimEnter',
        -- event = 'VeryLazy',

        priority = 9999,
        config = function()
            require('tiny-inline-diagnostic').setup {
                virt_texts = {
                    priority = 1000,
                },
                options = {
                    multiple_diag_under_cursor = true,
                    -- multilines = true,
                }
            }
        end,
    },
}
