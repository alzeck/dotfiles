local autocmd = vim.api.nvim_create_autocmd
local ui_helpers = vim.api.nvim_create_augroup("UiHelpers", { clear = true })

-- disable buggy anims in completion windows
autocmd("User", {
  group = ui_helpers,
  pattern = "BlinkCmpMenuOpen",
  callback = function() vim.g.snacks_animate = false end,
})

autocmd("User", {
  group = ui_helpers,
  pattern = "BlinkCmpMenuClose",
  callback = function() vim.g.snacks_animate = true end,
})

return {
  {
    "saghen/blink.cmp",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
      },

      appearance = {
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",

          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",

          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",

          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",

          Keyword = "󰻾",
          Constant = "󰏿",

          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
      },

      completion = {
        menu = { border = "rounded" },
        documentation = { auto_show = true, window = { border = "rounded" } },
        ghost_text = { enabled = true },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
