local function buildTheme(mode)
  local main = {
    base = "#00000000",
    surface = "#00000000",
    subtle = "#908caa",
    text = "#e0def4",
    love = "#eb6f92",
    rose = "#ebbcba",
    pine = "#31748f",
    foam = "#9ccfd8",
    iris = "#c4a7e7",
  }

  local dawn = {
    base = "#00000000",
    surface = "#00000000",
    subtle = "#797593",
    text = "#575279",
    love = "#b4637a",
    rose = "#d7827e",
    pine = "#286983",
    foam = "#56949f",
    iris = "#907aa9",
  }
  local p = main

  if mode == "light" then p = dawn end

  return {
    normal = {
      a = { bg = p.surface, fg = p.rose, gui = "bold" },
      b = { bg = p.surface, fg = p.text },
      c = { bg = p.surface, fg = p.subtle, gui = "italic" },
    },
    insert = {
      a = { bg = p.surface, fg = p.foam, gui = "bold" },
    },
    visual = {
      a = { bg = p.surface, fg = p.iris, gui = "bold" },
    },
    replace = {
      a = { bg = p.surface, fg = p.pine, gui = "bold" },
    },
    command = {
      a = { bg = p.surface, fg = p.love, gui = "bold" },
    },
    inactive = {
      a = { bg = p.base, fg = p.subtle, gui = "bold" },
      b = { bg = p.base, fg = p.subtle },
      c = { bg = p.base, fg = p.subtle, gui = "italic" },
    },
  }
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      disable_background = true,
      disable_float_background = true,
      palette = {
        main = {
          base = "#1f1f1f",
          surface = "#333333",
          overlay = "#2e2e2e",

          -- muted = "#787878",
          -- subtle = "#908caa",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "ColorScheme",
    config = function()
      require("lualine").setup({
        options = {
          -- @usage 'rose-pine' | 'rose-pine-alt'
          theme = buildTheme("dark"),
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
      })
    end,
  },
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   config = function()
  --     local auto_dark_mode = require("auto-dark-mode")
  --
  --     auto_dark_mode.setup({
  --       update_interval = 1000,
  --       set_dark_mode = function()
  --         vim.api.nvim_set_option_value("background", "dark", {})
  --         ColorMyPencils("rose-pine")
  --         local l = require("lualine")
  --         l.setup({
  --           options = {
  --             theme = buildTheme("dark"),
  --           },
  --         })
  --         l.refresh()
  --       end,
  --       set_light_mode = function()
  --         vim.api.nvim_set_option_value("background", "light", {})
  --         ColorMyPencils("rose-pine-dawn")
  --         local l = require("lualine")
  --         l.setup({
  --           options = {
  --             theme = buildTheme("light"),
  --           },
  --         })
  --
  --         l.refresh()
  --       end,
  --     })
  --     auto_dark_mode.init()
  --   end,
  -- },
}
