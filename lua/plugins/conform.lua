return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                sql = { 'sqlfmt' },
            },
        })

        vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
            require('conform').format({ async = true, lsp_format = 'fallback' })
        end, { desc = 'Format buffer' })
    end
}
