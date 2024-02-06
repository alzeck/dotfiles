return {
	{
		"theprimeagen/refactoring.nvim",
		opts = {
			show_success_message = true,
		},
		keys = {
			{
				"<leader>ri",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
				mode = "v",
				{ noremap = true, silent = true, expr = false },
			},
		},
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
			{ "folke/neodev.nvim", opts = {} },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			require("neodev").setup({
				-- add any options here, or leave empty to use the default settings
			})
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "󰋽",
			})

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
						"yaml",
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
					"eslint",
					"pyright",
					"elixirls",
				},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
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
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Formatters
	{
		"nvimtools/none-ls.nvim",
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
			{ "zbirenbaum/copilot.lua" },
			{ "zbirenbaum/copilot-cmp" },
			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				version = "2.*",
				build = "make install_jsregexp",
			},
			{
				"Dynge/gitmoji.nvim",
				dependencies = {
					"hrsh7th/nvim-cmp",
				},
				opts = {
					filetypes = { "gitcommit", "NeogitCommitMessage" },
				},
				ft = { "gitcommit", "NeoGitCommitMessage" },
			},
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
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
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "gitmoji" },
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = true,
	},
}
