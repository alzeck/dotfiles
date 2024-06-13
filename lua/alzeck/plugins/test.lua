return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"marilari88/neotest-vitest",
			{
				"mrcjkb/rustaceanvim",
				version = "^4", -- Recommended
				lazy = false, -- This plugin is already lazy
			},
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-vitest"),
					require("rustaceanvim.neotest"),
				},
			})
			vim.keymap.set("n", "<leader>nt", neotest.run.run)
		end,
	},
}
