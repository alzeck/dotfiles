return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"lazy.nvim",
				"snacks.nvim",
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

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
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})

			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "»",
					},
				},
			})

			-- format on save
			local buffer_autoformat = function(bufnr)
				local group = "lsp_autoformat"
				vim.api.nvim_create_augroup(group, { clear = false })
				vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = group,
					desc = "LSP format on save",
					callback = function()
						-- note: do not enable async formatting
						vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
					end,
				})
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local id = vim.tbl_get(event, "data", "client_id")
					local client = id and vim.lsp.get_client_by_id(id)
					if client == nil then
						return
					end

					-- make sure there is at least one client with formatting capabilities
					if client.supports_method("textDocument/formatting") then
						buffer_autoformat(event.buf)
					end
				end,
			})

			local noop = function() end

			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = {
					"ts_ls",
					"rust_analyzer",
					"tailwindcss",
					"jsonls",
					"basedpyright",
					"elixirls",
					"astro",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					rust_analyzer = noop,
					tailwindcss = function()
						require("lspconfig").tailwindcss.setup({
							settings = {
								tailwindCSS = {
									classAttributes = { "class", "className", "classNames", "class:list" },
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
					ts_ls = function()
						local function organize_imports()
							local params = {
								command = "_typescript.organizeImports",
								arguments = { vim.api.nvim_buf_get_name(0) },
							}
							vim.lsp.buf.execute_command(params)
						end
						local inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						}

						require("lspconfig").ts_ls.setup({
							settings = {
								typescript = {
									inlayHints = inlayHints,
								},
								javascript = {
									inlayHints = inlayHints,
								},
							},
							commands = {
								OrganizeImports = {
									organize_imports,
									description = "Organize Imports",
								},
							},
						})
					end,
					gopls = function()
						require("lspconfig").gopls.setup({
							settings = {
								gopls = {
									hints = {
										rangeVariableTypes = true,
										parameterNames = true,
										constantValues = true,
										assignVariableTypes = true,
										compositeLiteralFields = true,
										compositeLiteralTypes = true,
										functionTypeParameters = true,
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		lazy = false, -- This plugin is already lazy
		config = function()
			vim.g.rustaceanvim = {
				server = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					cmd = function()
						local mason_registry = require("mason-registry")
						local ra_binary = mason_registry.is_installed("rust-analyzer")
								-- This may need to be tweaked, depending on the operating system.
								and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer-aarch64-apple-darwin"
							or "rust-analyzer"
						return { ra_binary } -- You can add args to the list, such as '--log-file'
					end,
				},
			}
		end,
	},
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- Create the configuration for metals
			---
			local metals_config = require("metals").bare_config()
			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

			---
			-- Autocmd that will actually be in charging of starting metals
			---
			local metals_augroup = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = metals_augroup,
				pattern = { "scala", "sbt", "java" },
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
			})
		end,
	},
}
