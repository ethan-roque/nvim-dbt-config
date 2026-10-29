return {
    -- gitsigns config
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs                        = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged                 = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged_enable          = true,
                signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir                 = {
                    follow_files = true,
                },
                auto_attach                  = true,
                attach_to_untracked          = false,
                current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts      = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                blame_formatter              = nil, -- Use default
                sign_priority                = 6,
                update_debounce              = 100,
                status_formatter             = nil,   -- Use default
                max_file_length              = 40000, -- Disable if file is longer than this (in lines)
                preview_config               = {
                    -- Options passed to nvim_open_win
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1,
                },
            })
        end
    },
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('diffview').setup({
                enhance_diff_hl = true,
                view = {
                    default = {
                        layout = 'diff2_horizontal',
                    },
                    file_history = {
                        layout = 'diff2_horizontal',
                    },
                },
                file_panel = {
                    listing_style = 'tree',
                    win_config = {
                        position = 'left',
                        width = 35,
                    },
                }
            })

            vim.keymap.set('n', '<leader>gd', function()
                if next(require('diffview.lib').views) == nil then
                    vim.cmd('DiffviewOpen')
                else
                    vim.cmd('DiffviewClose')
                end
            end, { desc = 'Toggle git diff view' })
            vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>',
                { desc = 'File history (current file)' })
            vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<CR>', { desc = 'Close diff view' })
        end
    }
}
