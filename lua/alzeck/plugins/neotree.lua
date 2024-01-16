return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	event = "VeryLazy",
	keys = {
		{ "<leader><tab>", ":Neotree toggle left<CR>", silent = true, desc = "Left File Explorer" },
	},
	config = function()
		require("neo-tree").setup({
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_modified_markers = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,
			default_component_configs = {
				indent = {
					with_markers = false,
					with_expanders = true,
				},
				modified = {
					symbol = " ",
					highlight = "NeoTreeModified",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "",
						deleted = "",
						modified = "",
						-- renamed = "",
						-- Status type
						untracked = "",
						ignored = "",
						-- unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
		filesystem = {
				use_libuv_file_watcher = true,
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
					},
					never_show = {
						".DS_Store",
						"thumbs.db",
						".git",
					},
				},
			},
		})
	end,
}
