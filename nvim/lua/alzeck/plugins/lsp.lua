return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        "snacks.nvim",
        "todo-comments.nvim",
        "nvim-treesitter",
        "nvim-treesitter-context",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "mason-org/mason-lspconfig.nvim",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        ---@module 'mason'
        ---@type MasonSettings
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

      "neovim/nvim-lspconfig",
    },
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = {
      automatic_enable = true,
      automatic_installation = false,
      ensure_installed = {
        "ts_ls",
        "eslint",
        "lua_ls",
        "rust_analyzer",
        "tailwindcss",
        "jsonls",
        "basedpyright",
        "gopls",
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
