return {
	"catppuccin/nvim",
	name="catppuccin",
	priority=1000,
	config = function()
	    require("catppuccin").setup({
            flavour = "mocha",
			custom_highlights = function(colors)
				return {
					["@variable"] = { fg = colors.lavender },
					DashboardHeader = { fg = colors.blue },
					DashboardIcon = { fg = colors.blue },
					DashboardDesc = { fg = colors.text },
					DashboardKey = { fg = colors.pink, bold = true },
					DashboardFooter = { fg = colors.overlay1, italic = true },
					CsvViewHeaderLine = { bg = colors.surface0, bold = true },
					CsvViewStickyHeaderSeparator = { fg = colors.surface2 },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
