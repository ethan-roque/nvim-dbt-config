return {
    "gbakes/dbt-forge.nvim",
    url = "https://github.com/gbakes/dbt-forge.git",
    config = function()
        require("dbt-forge").setup({
            keymaps = {
                lineage = '<leader>dl',
                -- dbtpal handles running dbt; these defaults would also clash with <leader>drun/<leader>dtest
                run_model = false,
                transpile_model = false,
                test_model = false,
            },
            lineage = {
                up_depth = 2,
                down_depth = 2,
                presentation = 'float',
                width = 48,
                float = {
                    width_ratio = 1,
                },
                follow = true,
                include = { 'model', 'source', 'seed', 'snapshot', 'exposure' },
            },
            ui = {
                split_size = 15,
                float_border = 'rounded',
            }
        })
    end,
    ft = "sql", -- Load only for SQL files
}
