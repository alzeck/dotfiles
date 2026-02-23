return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    ---@module 'catppuccin'
    ---@type CatppuccinOptions
    opts = {
      transparent_background = true,
      float = {
        solid = false,
        transparent = true,
      },
      integrations = {
        blink_cmp = true,
        harpoon = true,
        mason = true,
        neotest = true,
      },
    },
  },
  {
    "sschleemilch/slimline.nvim",
    event = "ColorScheme",
    opts = {
      style = "fg",
      components = {
        right = {
          "diagnostics",
          "filetype_lsp",
        },
      },
      configs = {
        path = {
          hl = {
            primary = "Label",
          },
        },
        git = {
          hl = {
            primary = "Function",
          },
        },
        filetype_lsp = {
          hl = {
            primary = "String",
          },
        },
      },

      spaces = {
        components = "", -- string between components
        left = " ", -- string at the start of the line
        right = " ", -- string at the end of the line
      },
      sep = {
        left = "", -- left separator of components
        right = "", -- right separator of components
      },
    },
  },
}
