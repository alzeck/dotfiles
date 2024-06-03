return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"marilari88/neotest-vitest",
			{
				"mrcjkb/rustaceanvim",
				version = "^4", -- Recommended
				lazy = false, -- This plugin is already lazy
			},
		},
		config = function()
			require("neotest").setup({
				adapter = {
					require("neotest-vitest"),
					require("rustaceanvim.neotest"),
				},
			})
		end,
		keys = {
			{
				"<leader>nt",
				function()
					require("neotest").run.run()
				end,
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
			},
		},
	},
}
