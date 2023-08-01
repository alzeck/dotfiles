return {
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  -- Theming
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        disable_float_background = true,
      })
    end
  },

  'f-person/auto-dark-mode.nvim',

  'nvim-tree/nvim-web-devicons',

  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = true,
        -- your configuration comes here
        -- or leave it empty to , the default settings
        -- refer to the configuration section below
      }
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
  },

  "nvim-treesitter/playground",
  "theprimeagen/harpoon",
  "theprimeagen/refactoring.nvim",
  "mbbill/undotree",
  "tpope/vim-fugitive",
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
  "eandrju/cellular-automaton.nvim",
  "laytan/cloak.nvim",
  "lewis6991/gitsigns.nvim",

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },

  'NvChad/nvim-colorizer.lua',
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'ColorScheme',
    config = function()
      require('lualine').setup({
        options = {
          -- @usage 'rose-pine' | 'rose-pine-alt'
          theme = 'rose-pine-alt',
        },
        sections = {
          lualine_b = { 'branch', 'diff' },
          lualine_c = {
            {
              'filename',
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
            'diagnostics'
          },

          lualine_x = { 'filetype' },
          lualine_y = {},
        }
      })
    end
  },
  {
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup()
    end
  },
}
