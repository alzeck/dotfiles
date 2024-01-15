return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "ColorScheme",
		config = function()
			local theme = require("lualine.themes.rose-pine-alt")
			theme.normal.a.bg = "#00000000"
			theme.normal.b.bg = "#00000000"
			theme.normal.c.bg = "#00000000"
			theme.insert.a.bg = "#00000000"
			theme.visual.a.bg = "#00000000"
			theme.replace.a.bg = "#00000000"
			theme.command.a.bg = "#00000000"
			theme.inactive.a.bg = "#00000000"
			theme.inactive.b.bg = "#00000000"
			theme.inactive.c.bg = "#00000000"

			require("lualine").setup({
				options = {
					-- @usage 'rose-pine' | 'rose-pine-alt'
					theme = theme,
				},
				sections = {
					lualine_b = { "branch", "diff" },
					lualine_c = {
						{
							"filename",
							path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
						},
						"diagnostics",
					},

					lualine_x = { "filetype" },
					lualine_y = {},
				},
			})
		end,
	},
	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
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
			})
			vim.keymap.set("n", "<leader>ct", "<cmd>:CloakToggle<cr>", { silent = true, noremap = true })
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				icons = true,
				-- your configuration comes here
				-- or leave it empty to , the default settings
				-- refer to the configuration section below
			})

			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
		end,
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
		config = function()
			require("colorizer").setup({
				filetypes = { "css", "typescript", "typescriptreact" },
				user_default_options = {
					css = true,
					mode = "background",
					tailwind = true,
					virtualtext = "■",
					always_update = true,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				indent = { char = "▏" },
				scope = {
					enabled = true,
					highlight = { "Function", "Label" },
					show_exact_scope = true,
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					hover = {
						enabled = false,
					},
					signature = {
						enabled = false,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}
