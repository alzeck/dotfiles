return {
	{
		"laytan/cloak.nvim",
		opts = {
			enabled = true,
			cloak_character = "*",
			highlight_group = "Comment",
			patterns = {
				{
					file_pattern = {
						".env*",
						"wrangler.toml",
						".dev.vars",
					},
					cloak_pattern = "=.+",
				},
			},
		},
		-- TODO: improve lazy loading
		lazy = false,
		keys = {
			{ "<leader>ct", "<cmd>:CloakToggle<cr>" },
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		lazy = false,
		keys = {
			{ "<leader>xq", "<cmd>Trouble quickfix toggle<cr>" },
			{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>" },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" },
			{ "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>" },
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		lazy = false,
		keys = {
			{ "<leader>tt", "<cmd>TodoTelescope<cr>" },
			{ "<leader>tq", "<cmd>TodoTrouble<cr>" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"vimdoc",
					"javascript",
					"typescript",
					"c",
					"python",
					"go",
					"lua",
					"rust",
					"css",
					"elixir",
					"eex",
				},
				ignore_install = {},
				modules = {},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				highlight = {
					-- `false` will disable the whole extension
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "css", "typescript", "typescriptreact" },
			user_default_options = {
				css = true,
				mode = "background",
				tailwind = true,
				virtualtext = "■",
				always_update = true,
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "▏" },
			scope = {
				enabled = true,
				highlight = { "Function", "Label" },
				show_exact_scope = true,
			},
		},
	},
}
