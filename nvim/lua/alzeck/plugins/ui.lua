return {
  {
    "laytan/cloak.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
    },
    keys = {
      { "<leader>ct", "<cmd>:CloakToggle<cr>" },
    },
  },
  {
    "folke/trouble.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>" },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    cmd = { "TodoTrouble" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>tt", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>tq", "<cmd>TodoTrouble<cr>" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "*",
      },
      user_default_options = {
        css = true,
        mode = "background",
        tailwind = true,
        virtualtext = "■",
        always_update = true,
      },
    },
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    keys = {
      { "<leader>o", "<cmd>Oil<cr>", desc = "Open in Oil" },
    },
  },
}
