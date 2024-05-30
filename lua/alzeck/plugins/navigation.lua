return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{ "<leader>pf", builtin.find_files },
				{ "<C-p>", builtin.git_files },
				{ "<leader>ps", builtin.live_grep },
				{ "<leader>vh", builtin.help_tags },
				{ "<leader>gr", builtin.lsp_references },
				{ "<leader>fb", builtin.buffers },
				{ "<leader>of", builtin.oldfiles },
				{ "<leader>fs", builtin.lsp_document_symbols },
				{ "<leader>qf", builtin.quickfix },
				{ "<leader>fib", builtin.current_buffer_fuzzy_find },
			}
		end,
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})
		end,
		keys = function()
			local harpoon = require("harpoon")
			local append = function()
				harpoon:list():add()
			end
			local toggle_quick_menu = function()
				harpoon.ui:toggle_quick_menu(
					harpoon:list(),
					{ border = "rounded", title_pos = "center", title = " Harpoon ", ui_max_width = 80 }
				)
			end
			local pick_window = function(page)
				return function()
					harpoon:list():select(page)
				end
			end
			return {
				{ "<leader>a", append },
				{ "<C-e>", toggle_quick_menu },
				{ "<C-a>", pick_window(1) },
				{ "<C-s>", pick_window(2) },
				{ "<C-d>", pick_window(3) },
				{ "<C-f>", pick_window(4) },
			}
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
