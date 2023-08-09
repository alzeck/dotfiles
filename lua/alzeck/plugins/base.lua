return {
  {
    "theprimeagen/refactoring.nvim",
    config = function()
      require('refactoring').setup({})
      vim.api.nvim_set_keymap("v", "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        { noremap = true, silent = true, expr = false })
    end
  },
  {
    "mbbill/undotree",
    keys = { { "<leader>u", ":UndotreeToggle <CR>" } },
  },
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
    },
    config = function()

    end
  },

  "github/copilot.vim",
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
}
