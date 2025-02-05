return {
  {
    "laytan/cloak.nvim",
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
    -- TODO: improve lazy loading
    lazy = false,
    keys = {
      { "<leader>ct", "<cmd>:CloakToggle<cr>" },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    lazy = false,
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
    lazy = false,
    keys = {
      { "<leader>tt", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>tq", "<cmd>TodoTrouble<cr>" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = "─",
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "vimdoc",
          "javascript",
          "typescript",
          "c",
          "python",
          "go",
          "lua",
          "rust",
          "css",
          "elixir",
          "eex",
        },
        ignore_install = {},
        modules = {},

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      })
    end,
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
}
