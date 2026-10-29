return {
    'nvim-treesitter/nvim-treesitter',
    name = "treesitter",
    lazy = false,
    -- master does not support Neovim 0.12 (its markdown injections crash).
    -- main does, but builds parsers with tree-sitter-cli (brew install tree-sitter-cli).
    branch = "main",
    build = ':TSUpdate',
    config = function()
        -- main has no auto_install; this is a no-op once they are installed
        require("nvim-treesitter").install({
            "dockerfile", "gitignore", "json", "lua", "make", "markdown", "markdown_inline",
            "requirements", "sql", "vim", "vimdoc", "yaml",
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                -- csvview and rainbow_csv colour these instead
                if ft == "csv" or ft == "tsv" then return end
                if not pcall(vim.treesitter.start, args.buf) then return end

                if ft == "sql" then
                    -- dbt .sql files are full of jinja, which the sql parser cannot read.
                    -- Keep vim's regex highlighting on top, and skip treesitter indent:
                    -- a broken parse makes it return 0, so new lines land at column 0.
                    -- init.lua sets plain autoindent for sql instead.
                    vim.bo[args.buf].syntax = "on"
                else
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
            desc = "Treesitter highlight and indent",
        })
    end
}
