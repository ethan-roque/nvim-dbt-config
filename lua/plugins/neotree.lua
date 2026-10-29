return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    name = "neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    lazy = false,
    config = function()
        require('neo-tree').setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            -- the bufferline offset already shows the project name as a header
            hide_root_node = true,
            window = {
                width = 32,
                mappings = {
                    ["a"] = {'add', config = { show_path = "relative"} },
                    ["A"] = { 'add_directory', config = { show_path = "relative" } },
                }
            },
            default_component_configs = {
                container = { enable_character_fade = false },
                indent = {
                    indent_size = 2,
                    padding = 1,
                    -- thin, uniform guides like VSCode (no └ corner on the last child)
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "│",
                    -- chevrons instead of relying on folder icons to show open/closed
                    with_expanders = true,
                    expander_collapsed = "\u{eab6}", -- codicon chevron-right
                    expander_expanded = "\u{eab4}", -- codicon chevron-down
                },
                modified = { symbol = "●" },
                name = { use_git_status_colors = true },
                -- VSCode-style single letters on the right
                git_status = {
                    symbols = {
                        added     = "A",
                        deleted   = "D",
                        modified  = "M",
                        renamed   = "R",
                        untracked = "U",
                        ignored   = "",
                        unstaged  = "",
                        staged    = "",
                        conflict  = "!",
                    },
                },
                diagnostics = {
                    symbols = { hint = "\u{ea61}", info = "\u{ea74}", warn = "\u{ea6c}", error = "\u{ea87}" },
                },
                -- drop the right-hand metadata columns; the tree is narrow
                file_size = { enabled = false },
                type = { enabled = false },
                last_modified = { enabled = false },
                created = { enabled = false },
            },
            filesystem = {
                follow_current_file = { enabled = true },
                -- collapse single-child folders into one row (VSCode "compact folders")
                group_empty_dirs = true,
                scan_mode = "deep",
                -- refresh on outside changes (git checkout, new files from the terminal)
                use_libuv_file_watcher = true,
                filtered_items = {
                    -- show gitignored/hidden items, dimmed rather than hidden
                    visible = true,
                    -- noise VSCode also hides by default
                    never_show = { ".git", ".DS_Store" },
                },
            },
            event_handlers = {
                {
                    -- full-width highlight on the selected row, no text cursor
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        vim.opt_local.cursorline = true
                        vim.opt_local.signcolumn = "no"
                    end,
                },
            },
        })
        vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neotree" })

        vim.keymap.set("n", "<leader>e", function()
            if vim.bo.filetype == "neo-tree" then
                vim.cmd.wincmd("p")
            else
                vim.cmd("Neotree focus")
            end
        end, { desc = "Toggle focus between Neotree and file" })
    end
}
