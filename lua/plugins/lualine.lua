return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- file name only, no path; skip the terminal, which has no real file
        local function winbar_filename(color)
            return {
                'filename',
                path = 0,
                file_status = false,
                color = color,
                cond = function() return vim.bo.buftype == '' end,
            }
        end
        -- Dracula purple for the focused window, Dracula comment grey for the rest
        local active_filename = winbar_filename({ fg = '#282a36', bg = '#bd93f9', gui = 'bold' })
        local inactive_filename = winbar_filename({ fg = '#6272a4', bg = 'NONE' })

        require('lualine').setup({
            options = {
                theme = "dracula",
                disabled_filetypes = {
                    winbar = { 'neo-tree', 'alpha' },
                },
            },
            -- per-window bar under the buffer tabs; inactive splits keep their name too
            winbar = {
                lualine_c = { active_filename },
            },
            inactive_winbar = {
                lualine_c = { inactive_filename },
            },
        })
    end
}
