return {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" }, -- only load for csv/tsv files
    opts = {
        view = { display_mode = "border" }, -- draw │ between columns instead of showing commas
    },
    config = function(_, opts)
        -- csvview right-aligns any cell that looks like a number and has no option to turn that off.
        -- The number check is only used for alignment, so make it always say "not a number" to left-align everything.
        require("csvview.strings").is_number = function()
            return false
        end
        require("csvview").setup(opts)
    end,
}
