-- TODO: Add the buffers as visual tabs on top?

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

    -- Use `opts = {}` to force a plugin to be loaded.
    --
    --  This is equivalent to:
    --    require('Comment').setup({})

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', event = "VeryLazy", opts = {} },


    -- This is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- For example, in the following configuration, we use:
    --  event = 'VimEnter'
    --
    -- which loads which-key before all the UI elements are loaded. Events can be
    -- normal autocommands events (`:help autocmd-events`).
    --
    -- Then, because we use the `config` key, the configuration only runs
    -- after the plugin has been loaded:
    --  config = function() ... end

    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        config = function() -- This is the function that runs, AFTER loading
            require('which-key').setup()

            -- Document existing key chains
            require('which-key').add {

                { '<leader>c', group = '[C]ode' },
                { '<leader>c_', hidden = true },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>d_', hidden = true },
                { '<leader>h', group = 'Git [H]unk' },
                { '<leader>h_', hidden = true },
                { '<leader>r', group = '[R]ename' },
                { '<leader>r_', hidden = true },
                { '<leader>s', group = '[S]earch' },
                { '<leader>s_', hidden = true },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>t_', hidden = true },
                { '<leader>w', group = '[W]orkspace' },
                { '<leader>w_', hidden = true },
            }
            -- visual mode
            require('which-key').add {
                { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
            }
        end,
    },

    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    { import = 'plugins' },
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})
