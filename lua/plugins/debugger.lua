--TODO: check out debug.lua in kickstart folder

-- return {}
return {
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'rcarriga/nvim-dap-ui' },
        event = "VeryLazy", -- TODO: TEST THIS
        config = function()
            local dap = require 'dap'

            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    -- CHANGE THIS to your path!
                    command = '/home/jarron/bin/codelldb-files/extension/adapter/codelldb',
                    args = { '--port', '${port}' },

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                },
            }

            dap.configurations.c = {
                {
                    name = 'Launch',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    -- args = {},
                },
            }

            dap.configurations.zig = { --TODO: Run zig build everytime debug is started.
                {
                    name = 'Launch',
                    type = 'codelldb',
                    request = 'launch',
                    program = '${workspaceFolder}/zig-out/bin/zig',
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    -- args = {},
                },
            }

            vim.keymap.set('n', '<F5>', function()
                require('dap').continue()
            end)
            vim.keymap.set('n', '<F10>', function()
                require('dap').step_over()
            end)
            vim.keymap.set('n', '<F11>', function()
                require('dap').step_into()
            end)
            vim.keymap.set('n', '<F12>', function()
                require('dap').step_out()
            end)
            vim.keymap.set('n', '<Leader>b', function()
                require('dap').toggle_breakpoint()
            end)
            -- vim.keymap.set('n', '<Leader>B', function()
            --     require('dap').set_breakpoint()
            -- end)
            vim.keymap.set('n', '<Leader>lp', function()
                require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
            end)
            vim.keymap.set('n', '<Leader>dr', function()
                require('dap').repl.open()
            end)
            -- vim.keymap.set('n', '<Leader>dl', function()
            --     require('dap').run_last()
            -- end)
            vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
                require('dap.ui.widgets').hover()
            end)
            vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
                require('dap.ui.widgets').preview()
            end)
            vim.keymap.set('n', '<Leader>df', function()
                local widgets = require 'dap.ui.widgets'
                widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set('n', '<Leader>ds', function()
                local widgets = require 'dap.ui.widgets'
                widgets.centered_float(widgets.scopes)
            end)
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
            local dap, dapui = require 'dap', require 'dapui'
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    --TODO: Need this?? https://github.com/theHamsta/nvim-dap-virtual-text
}
