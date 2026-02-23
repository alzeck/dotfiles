return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    ---@type TSContext.Config
    opts = {
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
      multiwindow = false,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    dependencies = {},
  },

  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@module 'treesitter-modules'
    ---@type ts.mod.UserConfig
    opts = {
      -- list of parser names, or 'all', that must be installed
      ensure_installed = {
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "c",
        "python",
        "go",
        "lua",
        "rust",
        "css",
        "ruby",
        -- "elixir",
        -- "eex",
      },
      -- list of parser names, or 'all', to ignore installing
      ignore_install = {},
      -- install parsers in ensure_installed synchronously
      -- automatically install missing parsers when entering buffer
      auto_install = true,
      fold = {
        enable = true,
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true,
      },
    },
  },
}
