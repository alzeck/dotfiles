return {
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

  {
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
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
            cloak_pattern = "=.+"
          },
        },
      })
      vim.keymap.set("n", "<leader>ct", "<cmd>:CloakToggle<cr>",
        { silent = true, noremap = true }
      )
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("trouble").setup {
        icons = true,
        -- your configuration comes here
        -- or leave it empty to , the default settings
        -- refer to the configuration section below
      }

      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
      )
    end
  },


}
