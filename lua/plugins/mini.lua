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

        local statusline = require 'mini.statusline'
        statusline.setup {
            use_icons = vim.g.have_nerd_font,
            content = {
                active = function()
                    local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
                    local git = statusline.section_git { trunc_width = 40 }
                    local diff = statusline.section_diff { trunc_width = 75 }
                    local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
                    local lsp = statusline.section_lsp { trunc_width = 75 }
                    local filename = statusline.section_filename { trunc_width = 140 }
                    local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
                    local search = statusline.section_searchcount { trunc_width = 75 }

                    local indent = (vim.bo.expandtab and 'spaces.' or 'tabs.') .. vim.bo.shiftwidth

                    local location = '%2l:%-2v'
                    local num_lines = '%LL'

                    return statusline.combine_groups {
                        { hl = mode_hl, strings = { mode } },
                        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                        '%<',
                        { hl = 'MiniStatuslineFilename', strings = { filename } },
                        '%=',
                        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo, indent } },
                        { hl = mode_hl, strings = { search, location, num_lines } },
                    }
                end,
            },
        }

        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}
