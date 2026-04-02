vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },

    underline = true,
    -- underline = { severity = { min = vim.diagnostic.severity.WARN } },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '󰌵',
        },
    },

    virtual_text = false,

    jump = { float = true },
}
