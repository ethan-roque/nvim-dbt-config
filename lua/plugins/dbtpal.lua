-- Set DBT_REPO_ROOT if your data-dbx-dbt checkout lives somewhere else.
local REPO_ROOT = vim.fn.expand(vim.env.DBT_REPO_ROOT or '~/Documents/GitHub/data-dbx-dbt')

return {
    'samyilin/dbtpal.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
        require('dbtpal').setup({
            -- Same setup as .bin/activate-local.sh: load the repo's .env (token,
            -- source catalogs), then run the repo's .venv dbt. Sourcing it in a
            -- shell keeps the token out of nvim's own environment and logs.
            path_to_dbt = 'bash',
            pre_cmd_args = { '-c', 'source "$0/.env" && exec "$0/.venv/bin/dbt" "$@"', REPO_ROOT },

            -- path_to_dbt_project stays auto-detected and is passed as --project-dir.
            path_to_dbt_profiles_dir = REPO_ROOT .. '/profiles',

            picker_backend = 'telescope',
            stream_output = true,
        })

        local dbtpal = require('dbtpal')
        local context = require('dbtpal.context')

        -- dbtpal centres its output float; anchor it to the bottom instead.
        local display = require('dbtpal.display')
        local original_stream = display.stream
        display.stream = function(opts)
            local height = math.max(10, math.floor(vim.o.lines * 0.3))
            return original_stream(vim.tbl_extend('force', {
                relative = 'editor',
                width = vim.o.columns,
                height = height,
                row = vim.o.lines - height - 4,
                col = 0,
                border = 'rounded',
            }, opts or {}))
        end

        local STATE_PATH = REPO_ROOT .. '/prd_target/target/'
        local BASE_VARS = { limit_override = 0 }

        local function run_model(cmd, extra_vars)
            local model = context.require_model_buffer()
            if not model then
                return
            end
            local vars = vim.tbl_extend('force', BASE_VARS, extra_vars or {})
            dbtpal.run_command(cmd, {
                '--select', model,
                '--defer',
                '--state', STATE_PATH,
                '--vars', vim.json.encode(vars),
            })
        end

        vim.keymap.set('n', '<leader>drun', function() run_model('run') end, { desc = 'dbt run current model' })
        vim.keymap.set('n', '<leader>dtest', function() run_model('test') end, { desc = 'dbt test current model' })
        vim.keymap.set('n', '<leader>dbuild', function() run_model('build') end, { desc = 'dbt build current model' })

        vim.keymap.set('n', '<leader>dv', function()
            vim.ui.input({ prompt = 'Extra dbt vars (JSON): ' }, function(input)
                if not input or input == '' then
                    return
                end
                local ok, decoded = pcall(vim.json.decode, input)
                if not ok or type(decoded) ~= 'table' then
                    vim.notify('Invalid JSON vars: ' .. input, vim.log.levels.ERROR)
                    return
                end
                run_model('run', decoded)
            end)
        end, { desc = 'dbt run current model with extra vars' })

        vim.keymap.set('n', '<leader>dd', '<cmd>Dbt<cr>', { desc = 'dbt raw passthrough' })
        vim.keymap.set('n', '<leader>dm', '<cmd>DbtSelectModels<cr>', { desc = 'dbt select models' })
        vim.keymap.set('n', '<leader>dw', '<cmd>DbtWalk<cr>', { desc = 'dbt walk graph' })
    end
}
