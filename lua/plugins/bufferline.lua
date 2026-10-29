return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('bufferline').setup({
            options = {
                mode = 'buffers', -- show open buffers, not vim tabpages
                separator_style = 'slant',
                show_buffer_close_icons = true,
                show_close_icon = false,
                diagnostics = 'nvim_lsp', -- shows error/warning counts on the tab
                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'File Explorer',
                        highlight = 'Directory',
                        separator = true,
                    },
                },
            },
        })

        vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
        vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
        -- Delete the buffer without letting its window close, which would
        -- otherwise leave neo-tree as the last window and stretch it fullscreen.
        local function close_buffer()
            local cur = vim.api.nvim_get_current_buf()
            -- leave the tree and the persistent terminal alone
            if vim.bo[cur].filetype == 'neo-tree' or vim.bo[cur].buftype == 'terminal' then return end

            local alt = vim.fn.bufnr('#')
            if alt ~= -1 and alt ~= cur and vim.fn.buflisted(alt) == 1 then
                vim.cmd('buffer ' .. alt)
            else
                vim.cmd('bprevious')
            end
            if vim.api.nvim_get_current_buf() == cur then vim.cmd('enew') end
            pcall(vim.cmd, 'bdelete ' .. cur)
        end

        vim.keymap.set('n', '<leader>x', close_buffer, { desc = 'Close current buffer' })
    end
}
