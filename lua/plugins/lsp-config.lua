return {
    {
        "mason-org/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "yamlls" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { 'saghen/blink.cmp', 'b0o/schemastore.nvim' },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)

            vim.lsp.config('lua_ls', { capabilities = capabilities })
            vim.lsp.enable('lua_ls')

            -- dbt language server
            vim.lsp.config('dbt', {
                cmd = { 'dbt-language-server' },
                filetypes = { 'sql', 'yaml' },
                root_markers = { 'dbt_project.yml' },
                capabilities = capabilities,
            })
            vim.lsp.enable('dbt')

            -- yaml schemas (dbt_project.yml, models/*.yml, ...) from SchemaStore
            vim.lsp.config('yamlls', {
                capabilities = capabilities,
                settings = {
                    yaml = {
                        -- use schemastore.nvim's catalog instead of the server's built-in one
                        schemaStore = { enable = false, url = "" },
                        schemas = require('schemastore').yaml.schemas({
                            -- SchemaStore points dbt files at the Fusion schemas; we run dbt Core
                            replace = (function()
                                local base = 'https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/'
                                return {
                                    ['dbt YAML files'] = base .. 'dbt_yml_files-latest.json',
                                    ['dbt Project'] = base .. 'dbt_project-latest.json',
                                    ['dbt Packages'] = base .. 'packages-latest.json',
                                    ['dbt Selectors'] = base .. 'selectors-latest.json',
                                    ['dbt Dependencies'] = base .. 'dependencies-latest.json',
                                }
                            end)(),
                        }),
                    },
                },
            })
            vim.lsp.enable('yamlls')

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', function()
                vim.lsp.buf.code_action({
                    -- yamlls offers to open the remote schema json, which neovim can't follow
                    filter = function(action)
                        return not action.title:lower():find('jump to schema location', 1, true)
                    end,
                })
            end, {})

            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●', -- could also be '■', '▎', 'icon'
                    spacing = 4,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = 'rounded',
                    source = true,
                },
            })
        end
    }
}
