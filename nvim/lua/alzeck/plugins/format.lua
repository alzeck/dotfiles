return {
	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	dependencies = {
	-- 		"nvimtools/none-ls-extras.nvim",
	-- 	},
	-- 	config = function()
	-- 		local null_ls = require("null-ls")
	--
	-- 		null_ls.setup({
	-- 			sources = {
	-- 				-- null_ls.builtins.formatting.prettier,
	-- 				-- null_ls.builtins.formatting.stylua,
	-- 				-- null_ls.builtins.formatting.mix,
	-- 				-- require("none-ls.formatting.autopep8"),
	-- 				-- null_ls.builtins.diagnostics.credo,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- elixir = { "mix" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				python = { "autopep8" },
			},
			format_on_save = {
				timeout_ms = 5000,
				lsp_format = "fallback",
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
