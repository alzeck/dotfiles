local with_biome = { "biome-check", "prettier", stop_after_first = true }
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function() require("conform").format({ async = true }) end,
        mode = "",
        desc = "Format buffer",
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { "stylua", lsp_format = "never" },
        python = { "autopep8" },
        astro = { "prettier" },
        css = with_biome,
        graphql = { "prettier" },
        handlebars = { "prettier" },
        html = { "prettier" },
        javascript = with_biome,
        javascriptreact = with_biome,
        json = with_biome,
        jsonc = with_biome,
        less = { "prettier" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        scss = { "prettier" },
        typescript = with_biome,
        typescriptreact = with_biome,
        vue = { "prettier" },
        yaml = { "prettier" },

        ruby = { "standardrb" },
        eruby = { "erb_format" },
      },
      formatters = {
        biome = {
          require_cwd = true,
        },
      },
      format_on_save = { timeout_ms = 5000 },
      default_format_opts = {
        lsp_format = "fallback", -- use LSP if available, otherwise use a formatter
      },
    },
  },
}
