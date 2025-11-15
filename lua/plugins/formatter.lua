return {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format { async = true, lsp_format = 'fallback' }
            end,
            mode = '',
            desc = '[F]ormat buffer',
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            local enable_filetypes = { lua = true }
            if enable_filetypes[vim.bo[bufnr].filetype] then
                return {
                    timeout_ms = 500,
                    lsp_format = 'fallback',
                }
            else
                return nil
            end
        end,
        formatters_by_ft = {
            lua = { 'stylua' },
            --python = { 'ruff' },
            python = { 'isort', 'black' },
            javascript = { 'prettierd' },
            -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
            css = { 'prettierd' },
            html = { 'prettierd' },
            json = { 'prettierd' },
            yaml = { 'prettierd' },
            xml = { 'xmlformatter' },
        },
    },
}
