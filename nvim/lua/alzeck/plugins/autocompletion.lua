return {
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
			local cmp = require("cmp")
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()
			require("luasnip.loaders.from_vscode").lazy_load()
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				formatting = {
					-- changing the order of fields so the icon is the first
					fields = { "menu", "abbr", "kind" },
					expandable_indicator = true,

					-- here is where the change happens
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = "λ",
							luasnip = "⋗",
							buffer = "Ω",
							path = "/",
							nvim_lua = "Π",
							copilot = "",
						}
						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},
				--
				window = {
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
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
					expand = function(args) require("luasnip").lsp_expand(args.body) end,
				},
				sources = cmp.config.sources({
					{ name = "lazydev", group_index = 0 },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "gitmoji" },
					{ name = "copilot" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
