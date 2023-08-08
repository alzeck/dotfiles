return {

  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
  },

  "nvim-treesitter/playground",
  "theprimeagen/refactoring.nvim",
  {
    "mbbill/undotree",
    keys = { { "<leader>u", ":UndotreeToggle <CR>" } },
  },
  "nvim-treesitter/nvim-treesitter-context",

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        config = function()
          require("mason").setup({
            ui = {
              border = "rounded",
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          })
        end
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Formatters
      { 'jose-elias-alvarez/null-ls.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },

  "github/copilot.vim",

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          css = true,
          mode = "background",
          tailwind = true,
          virtualtext = "■",
          always_update = true
        },
      }
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
}
