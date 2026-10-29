return {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
        -- One setup call only. Telescope keeps a single config table, so a second
        -- setup() elsewhere would quietly replace what is set here.
        require("telescope").setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {},
                },
            },
        })
        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
    end,
}
