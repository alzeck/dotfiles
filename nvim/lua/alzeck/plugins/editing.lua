return {
	{
		"theprimeagen/refactoring.nvim",
		opts = {
			show_success_message = true,
		},
	},
	{
		"mbbill/undotree",
		keys = { { "<leader>u", ":UndotreeToggle <CR>" } },
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
