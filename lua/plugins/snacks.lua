return {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
        lazygit = {},
        picker = {}, --TODO: Config some picker keys like ctrl-enter to re-search, and change scroll to c-d and c-u?
        bigfile = {},
        quickfile = {},
        -- scroll = {},
        -- zen = {
        --     toggles = {
        --         dim = false
        --     }
        -- },
        -- words = {},
        -- statuscolumn = {}

        ---@type table<string, snacks.win.Config>
        -- styles = {
        --     zen = {
        --         minimal=true,
        --         backdrop = { transparent = false },
        --     },
        -- },
    },
    keys = {
        --####### Picker ########
        { "<leader>sf", function() Snacks.picker.files() end, desc = "Search Files" },
        { "<leader>sg", function() Snacks.picker.git_files() end, desc = "Search Git Files" },
        { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Buffers" },

        -- Grep
        { "<leader>st", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },

        -- Neovim Search
        { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Search Config Files" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },

        -- LSP Search
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },

        { "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
        { "<leader>sz", function() Snacks.picker.zoxide() end, desc = "[S]earch [Z]oxide" },

        -- Git Search
        { "<leader>gsb", function() Snacks.picker.git_branches() end, desc = "[G]it [S]earch [B]ranches" },
        { "<leader>gst", function() Snacks.picker.git_grep() end, desc = "[G]it [S]earch [T]ext" },
        { "<leader>gsd", function() Snacks.picker.git_diff() end, desc = "[G]it [S]earch [D]iff" },
        { "<leader>gal", function() Snacks.picker.git_log() end, desc = "[G]it [A]ll [L]ogs" },
        { "<leader>gfl", function() Snacks.picker.git_log_file() end, desc = "[G]it [F]ile [L]ogs" },
        { "<leader>gll", function() Snacks.picker.git_log_line() end, desc = "[G]it [L]ine [L]ogs" },

        -- Misc
        { "<leader>sM", function() Snacks.picker.man() end, desc = "[S]earch [M]an Pages" },

        -- ######### LSP ########
        picker = {},
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "[G]oto [D]eclaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "[G]oto [R]eferences" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },
        { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "[G]oto T[y]pe Definition" },
        { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "[G]et [A]ll Calls [I]ncoming" },
        { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "[G]et [A]ll Calls [O]utgoing" },
        { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "[D]ocument [S]ymbols" },
        { "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[W]orkspace [S]ymbols" },

        -- ###### Git Browse ######
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "[G]it [B]rowse", mode = { "n", "v" } },

        -- Lazygit
        { "<leader>lg", function() Snacks.lazygit() end, desc = "[L]azy [G]it", mode = { "n", "v" } },
    },
}
-- https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md
--
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
