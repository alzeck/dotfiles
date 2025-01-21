return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{ "<leader>pf", builtin.find_files, desc = "find files" },
				{ "<C-p>", builtin.git_files, desc = "find git files" },
				{ "<leader>ps", builtin.live_grep, desc = "grep" },
				{ "<leader>gr", builtin.lsp_references, desc = "lsp references" },
				{ "<leader>fb", builtin.buffers, desc = "find open files" },
				{ "<leader>of", builtin.oldfiles, desc = "find previous files" },
				{ "<leader>fy", builtin.lsp_document_symbols, desc = "lsp symbols" },
				{ "<leader>qf", builtin.quickfix, desc = "telescope quick fix" },
				{ "<leader>fs", builtin.current_buffer_fuzzy_find, desc = "find in buffer" },
			}
		end,
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		lazy = false,
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})
		end,
		keys = function()
			local harpoon = require("harpoon")
			local append = function()
				harpoon:list():add()
			end
			local remove = function()
				harpoon:list():remove()
			end
			local toggle_quick_menu = function()
				-- basic telescope configuration
				local conf = require("telescope.config").values
				local function toggle_telescope(harpoon_files)
					local file_paths = {}
					for _, item in ipairs(harpoon_files.items) do
						table.insert(file_paths, item.value)
					end

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Harpoon",
							finder = require("telescope.finders").new_table({
								results = file_paths,
							}),
							previewer = conf.file_previewer({}),
							sorter = conf.generic_sorter({}),
						})
						:find()
				end
				toggle_telescope(harpoon:list())
			end
			local pick_window = function(page)
				return function()
					harpoon:list():select(page)
				end
			end
			local prev = function()
				harpoon:list():prev()
			end
			local next = function()
				harpoon:list():next()
			end

			return {
				{ "<leader>a", append, desc = "Harpoon append" },
				{ "<leader>r", remove, desc = "Harpoon remove" },
				{ "<C-e>", toggle_quick_menu, desc = "Harpoon menu" },
				{ "<C-a>", pick_window(1), desc = "Harpoon window 1" },
				{ "<C-s>", pick_window(2), desc = "Harpoon window 2" },
				{ "<C-d>", pick_window(3), desc = "Harpoon window 3" },
				{ "<C-f>", pick_window(4), desc = "Harpoon window 4" },
				{ "<C-H>p", prev, desc = "Harpoon previous" },
				{ "<C-H>n", next, desc = "Harpoon next" },
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
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		keys = { { "<leader>o", "<cmd>Oil<cr>" } },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		event = "VeryLazy",
		keys = {
			{ "<leader><tab>", ":Neotree toggle left<CR>", silent = true, desc = "Left File Explorer" },
		},
	},
}
