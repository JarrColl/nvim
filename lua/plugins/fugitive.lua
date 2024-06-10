return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, {desc = "Fugitive: Show git state buffer."})

    local fugitive_group = vim.api.nvim_create_augroup('fugitive_group', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = fugitive_group,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, remap = false, desc = "Fugitive: " .. desc})
        end

        map('<leader>gP', function()
          vim.cmd.Git 'push'
        end, "Git Push")

        -- rebase always
        map('<leader>gp', function()
          vim.cmd.Git { 'pull', '--rebase' }
        end, "pull with rebase.")

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        -- vim.keymap.set('n', '<leader>t', ':Git push -u origin ', opts)
      end,
    })

    vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>')
    vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>')
  end,
}
