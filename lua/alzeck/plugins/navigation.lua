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
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<C-a>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<C-s>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<C-d>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<C-f>", function()
				ui.nav_file(4)
			end)
		end,
	},
}
