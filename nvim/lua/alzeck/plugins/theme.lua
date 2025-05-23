return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    ---@module 'catppuccin'
    ---@type CatppuccinOptions
    opts = {
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        harpoon = true,
        mason = true,
        neotest = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "ColorScheme",
    opts = {
      options = {
        -- @usage 'rose-pine' | 'rose-pine-alt'
        theme = "catppuccin",
      },
      sections = {
        lualine_b = { "branch", "diff" },
        lualine_c = {
          {
            "filename",
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
          "diagnostics",
        },

        lualine_x = { "filetype" },
        lualine_y = {},
      },
    },
  },
}
