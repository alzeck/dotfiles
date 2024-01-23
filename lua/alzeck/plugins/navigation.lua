return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "cljoly/telescope-repo.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					repo = {
						list = {
							search_dirs = {
								"~/Projects",
								"~/.config",
							},
						},
					},
				},
			})

			require("telescope").load_extension("repo")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.keymap.set("n", "<C-p>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>pp", "<cmd>Telescope repo list<cr>", {})
			vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>qf", builtin.quickfix, {})
			vim.keymap.set("n", "<leader>fib", builtin.current_buffer_fuzzy_find, {})
		end,
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():append()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list(), {
					border = "rounded",
					title_pos = "center",
					title = " Harpoon ",
					ui_max_width = 80,
				})
			end)

			vim.keymap.set("n", "<C-a>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-d>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-f>", function()
				harpoon:list():select(4)
			end)
		end,
	},
}
