--Lazy Vim Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- OPT settings
vim.opt.number = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Keymaps
-- Persistent terminal: hiding the window keeps the shell (and its session) running.
local term = { buf = nil, win = nil }

local function toggle_term()
    if term.win and vim.api.nvim_win_is_valid(term.win) then
        vim.api.nvim_win_hide(term.win)
        term.win = nil
        return
    end

    vim.cmd("botright 15split")
    term.win = vim.api.nvim_get_current_win()

    if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
        vim.api.nvim_win_set_buf(term.win, term.buf)
    else
        vim.cmd("terminal")
        term.buf = vim.api.nvim_get_current_buf()
    end
    vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<C-t>", toggle_term, { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>t", toggle_term, { desc = "Toggle terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set(
    "n",
    "<leader>cn",
    function()
        vim.fn.setreg("+", vim.fn.expand("%:t"))
    end,
    { desc = "Copy file name" }
)
vim.keymap.set(
    "n",
    "<leader>cp",
    function()
        vim.fn.setreg("+", vim.fn.expand("%:p"))
    end,
    { desc = "Copy full file path" })

-- SQL: the runtime sql indent plugin adds a level after every WHEN, which walks
-- CASE branches off to the right. Plain autoindent copies the previous line instead.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function()
        vim.bo.indentexpr = ""
        vim.bo.autoindent = true
    end,
    desc = "Plain autoindent for SQL/dbt files",
})

-- Setup lazy.nvim
-- No plugin here needs luarocks; leaving it on makes :checkhealth report an error.
require("lazy").setup("plugins", { rocks = { enabled = false } })
