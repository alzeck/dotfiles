return {
	{
		"theprimeagen/refactoring.nvim",
		config = function()
			require("refactoring").setup({})
			vim.api.nvim_set_keymap(
				"v",
				"<leader>ri",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
				{ noremap = true, silent = true, expr = false }
			)
		end,
	},
	{
		"mbbill/undotree",
		keys = { { "<leader>u", ":UndotreeToggle <CR>" } },
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
		dependencies = {},
	},

	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "󰋽",
			})
			-- vim.diagnostic.config({
			-- 	virtual_text = false,
			-- 	severity_sort = true,
			-- 	float = {
			-- 		style = "minimal",
			-- 		border = "rounded",
			-- 		source = "always",
			-- 		header = "",
			-- 		prefix = "",
			-- 	},
			-- })
			--
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			lsp_zero.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["rust_analyzer"] = { "rust" },
					-- if you have a working setup with null-ls
					-- you can specify filetypes it can format.
					["null-ls"] = {
						"markdown",
						"graphql",
						"html",
						"css",
						"scss",
						"less",
						"yaml",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"markdown.mdx",
						"python",
						"elixir",
						"json",
						"jsonc",
						"vue",
						"lua",
						"svelte",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"rust_analyzer",
					"tailwindcss",
					"jsonls",
					"elixirls",
				},
				handlers = {
					lsp_zero.default_setup,
					tailwindcss = function()
						require("lspconfig").tailwindcss.setup({
							settings = {
								tailwindCSS = {
									classAttributes = { "class", "className", "classNames" },
									experimental = {
										classRegex = {
											{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
											{ "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
										},
									},
								},
							},
						})
					end,
					tsserver = function()
						local function organize_imports()
							local params = {
								command = "_typescript.organizeImports",
								arguments = { vim.api.nvim_buf_get_name(0) },
							}
							vim.lsp.buf.execute_command(params)
						end

						require("lspconfig").tsserver.setup({
							commands = {
								OrganizeImports = {
									organize_imports,
									description = "Organize Imports",
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.mix,
					null_ls.builtins.formatting.autopep8,
					null_ls.builtins.diagnostics.credo,
				},
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				version = "2.*",
				build = "make install_jsregexp",
			},
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					}),
				}),

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				},
			})
		end,
	},
	-- Copilot
	"github/copilot.vim",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
}
