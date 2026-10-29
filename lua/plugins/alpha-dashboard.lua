return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
    local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]
    logo = logo .. "\n\n"
    require('dashboard').setup {
        theme = 'doom',
        config = {
            vertical_center = true,
            header = vim.split(logo, "\n"),
            center = {
                { action = "Telescope find_files",                          desc = " Find File",       icon = " ", key = "f" },
                { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
                { action = "Telescope oldfiles",                            desc = " Recent Files",    icon = " ", key = "r" },
                { action = "Telescope live_grep",                           desc = " Find Text",       icon = " ", key = "g" },
                { action = "Telescope find_files cwd=" .. vim.fn.stdpath("config"), desc = " Config",          icon = " ", key = "c" },
                { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
                { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
            },
            footer = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
            end,
        }
    }
    end
}
