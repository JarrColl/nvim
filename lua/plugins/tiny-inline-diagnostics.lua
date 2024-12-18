return {
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = 'LspAttach', -- Or `VeryLazy`
        config = function()
            require('tiny-inline-diagnostic').setup {
                virt_texts = {
                    priority = 9999,
                },
                options = {
                    multiple_diag_under_cursor = true,
                    -- multilines = true,
                }
            }
        end,
    },
}
